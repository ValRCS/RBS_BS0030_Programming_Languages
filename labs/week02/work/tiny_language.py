"""BS0030 Week 2 starter: a tiny expression language.

Grammar:

    program     ::= { statement } expression EOF ;
    statement   ::= "let" identifier "=" expression ";" ;

    expression  ::= term { ("+" | "-") term } ;
    term        ::= factor { ("*" | "/") factor } ;
    factor      ::= number | identifier | "(" expression ")" ;

    identifier  ::= letter { letter | digit | "_" } ;
    number      ::= digit { digit } ;

The tokenizer, AST data classes, statement/program parsing, and evaluator are
provided. Your main task is to implement the three expression-parser methods:

    parse_expression
    parse_term
    parse_factor

Keep the implementation close to the grammar.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import TypeAlias


# ---------------------------------------------------------------------------
# Tokens
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class Token:
    kind: str
    text: str
    position: int


_SINGLE_CHAR_TOKENS = {
    "+": "PLUS",
    "-": "MINUS",
    "*": "STAR",
    "/": "SLASH",
    "=": "EQUAL",
    "(": "LPAREN",
    ")": "RPAREN",
    ";": "SEMICOLON",
}


class LexError(ValueError):
    """Raised when source text contains a character our language cannot lex."""


class ParseError(ValueError):
    """Raised when the token stream does not match the grammar."""


def tokenize(source: str) -> list[Token]:
    """Convert source characters into a token stream."""
    tokens: list[Token] = []
    i = 0

    while i < len(source):
        ch = source[i]

        if ch.isspace():
            i += 1
            continue

        if ch.isdigit():
            start = i
            while i < len(source) and source[i].isdigit():
                i += 1
            tokens.append(Token("NUMBER", source[start:i], start))
            continue

        # Keep the implementation consistent with the grammar:
        # identifiers must start with a letter, but later characters may
        # contain letters, digits, or underscores.
        if ch.isalpha():
            start = i
            while i < len(source) and (
                source[i].isalnum() or source[i] == "_"
            ):
                i += 1
            text = source[start:i]
            kind = "LET" if text == "let" else "IDENT"
            tokens.append(Token(kind, text, start))
            continue

        if ch in _SINGLE_CHAR_TOKENS:
            tokens.append(Token(_SINGLE_CHAR_TOKENS[ch], ch, i))
            i += 1
            continue

        raise LexError(f"Unexpected character {ch!r} at position {i}")

    tokens.append(Token("EOF", "", len(source)))
    return tokens


# ---------------------------------------------------------------------------
# Abstract syntax tree
# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class Number:
    value: int


@dataclass(frozen=True)
class Name:
    identifier: str


@dataclass(frozen=True)
class Binary:
    operator: str
    left: "Expr"
    right: "Expr"


Expr: TypeAlias = Number | Name | Binary


@dataclass(frozen=True)
class LetStatement:
    name: str
    expression: Expr


@dataclass(frozen=True)
class Program:
    statements: list[LetStatement]
    result: Expr


# ---------------------------------------------------------------------------
# Recursive-descent parser
# ---------------------------------------------------------------------------

class Parser:
    def __init__(self, tokens: list[Token]):
        self.tokens = tokens
        self.current = 0

    def peek(self) -> Token:
        return self.tokens[self.current]

    def previous(self) -> Token:
        return self.tokens[self.current - 1]

    def check(self, kind: str) -> bool:
        return self.peek().kind == kind

    def match(self, *kinds: str) -> bool:
        if self.peek().kind in kinds:
            self.current += 1
            return True
        return False

    def expect(self, kind: str, message: str) -> Token:
        if self.check(kind):
            token = self.peek()
            self.current += 1
            return token

        token = self.peek()
        raise ParseError(
            f"{message} at position {token.position}; "
            f"found {token.kind} {token.text!r}"
        )

    def parse_program(self) -> Program:
        statements: list[LetStatement] = []

        while self.check("LET"):
            statements.append(self.parse_statement())

        result = self.parse_expression()
        self.expect("EOF", "Expected end of input")
        return Program(statements, result)

    def parse_statement(self) -> LetStatement:
        self.expect("LET", "Expected 'let'")
        name = self.expect("IDENT", "Expected identifier after 'let'")
        self.expect("EQUAL", "Expected '=' after identifier")
        expression = self.parse_expression()
        self.expect("SEMICOLON", "Expected ';' after let statement")
        return LetStatement(name.text, expression)

    def parse_expression(self) -> Expr:
        """Parse: expression ::= term { ("+" | "-") term } ;"""
        expr = self.parse_term()

        while self.match("PLUS", "MINUS"):
            operator = self.previous()
            right = self.parse_term()
            expr = Binary(
                "+" if operator.kind == "PLUS" else "-",
                expr,
                right,
            )

        return expr

    def parse_term(self) -> Expr:
        """Parse: term ::= factor { ("*" | "/") factor } ;"""
        expr = self.parse_factor()

        while self.match("STAR", "SLASH"):
            operator = self.previous()
            right = self.parse_factor()
            expr = Binary(
                "*" if operator.kind == "STAR" else "/",
                expr,
                right,
            )

        return expr

    def parse_factor(self) -> Expr:
        """Parse: factor ::= number | identifier | "(" expression ")" ;"""
        if self.match("NUMBER"):
            return Number(int(self.previous().text))

        if self.match("IDENT"):
            return Name(self.previous().text)

        if self.match("LPAREN"):
            expr = self.parse_expression()
            self.expect("RPAREN", "Expected ')' after expression")
            return expr

        token = self.peek()
        raise ParseError(
            f"Expected number, identifier, or '(' at position {token.position}; "
            f"found {token.kind} {token.text!r}"
        )


def parse(source: str) -> Program:
    return Parser(tokenize(source)).parse_program()


# ---------------------------------------------------------------------------
# Evaluation: giving the AST meaning
# ---------------------------------------------------------------------------

NumberValue: TypeAlias = int | float


def evaluate_expression(expr: Expr, environment: dict[str, NumberValue]) -> NumberValue:
    if isinstance(expr, Number):
        return expr.value

    if isinstance(expr, Name):
        try:
            return environment[expr.identifier]
        except KeyError as exc:
            raise NameError(f"Unbound name: {expr.identifier}") from exc

    if isinstance(expr, Binary):
        left = evaluate_expression(expr.left, environment)
        right = evaluate_expression(expr.right, environment)

        match expr.operator:
            case "+":
                return left + right
            case "-":
                return left - right
            case "*":
                return left * right
            case "/":
                return left / right
            case _:
                raise ValueError(f"Unknown operator: {expr.operator}")

    raise TypeError(f"Unknown expression node: {expr!r}")


def evaluate(program: Program) -> NumberValue:
    environment: dict[str, NumberValue] = {}

    for statement in program.statements:
        value = evaluate_expression(statement.expression, environment)
        environment[statement.name] = value

    return evaluate_expression(program.result, environment)


def run(source: str) -> NumberValue:
    """Tokenize, parse, and evaluate a Tiny Language program."""
    return evaluate(parse(source))
