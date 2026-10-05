import unittest

from tiny_language import (
    Binary,
    LexError,
    Name,
    Number,
    ParseError,
    parse,
    run,
    tokenize,
)


class TokenizerTests(unittest.TestCase):
    def test_tokenize_let_statement(self):
        tokens = tokenize("let radius = 10;")
        kinds = [token.kind for token in tokens]
        self.assertEqual(
            kinds,
            ["LET", "IDENT", "EQUAL", "NUMBER", "SEMICOLON", "EOF"],
        )

    def test_underscore_is_allowed_after_first_character(self):
        tokens = tokenize("let total_2 = 5; total_2")
        identifiers = [t.text for t in tokens if t.kind == "IDENT"]
        self.assertEqual(identifiers, ["total_2", "total_2"])

    def test_identifier_cannot_start_with_underscore(self):
        with self.assertRaises(LexError):
            tokenize("_hidden + 1")

    def test_illegal_character_is_lex_error(self):
        with self.assertRaises(LexError):
            tokenize("2 @ 3")


class ParserAndEvaluatorTests(unittest.TestCase):
    def test_multiplication_has_higher_precedence(self):
        self.assertEqual(run("2 + 3 * 4"), 14)

    def test_parentheses_override_precedence(self):
        self.assertEqual(run("(2 + 3) * 4"), 20)

    def test_subtraction_is_left_associative(self):
        self.assertEqual(run("10 - 3 - 2"), 5)

    def test_ast_structure_matches_precedence(self):
        program = parse("2 + 3 * 4")
        self.assertEqual(
            program.result,
            Binary(
                "+",
                Number(2),
                Binary("*", Number(3), Number(4)),
            ),
        )

    def test_identifier_becomes_name_node(self):
        program = parse("radius + 5")
        self.assertEqual(
            program.result,
            Binary("+", Name("radius"), Number(5)),
        )

    def test_running_example(self):
        source = """
        let radius = 10;
        let area = 3 * radius * radius;
        area + 5
        """
        self.assertEqual(run(source), 305)

    def test_later_binding_can_use_earlier_binding(self):
        self.assertEqual(
            run("let x = 4; let y = x * 3; y + 1"),
            13,
        )

    def test_missing_expression_is_parse_error(self):
        with self.assertRaises(ParseError):
            parse("let x = ; x")

    def test_missing_right_parenthesis_is_parse_error(self):
        with self.assertRaises(ParseError):
            parse("(2 + 3")

    def test_unbound_identifier_is_semantic_error(self):
        with self.assertRaises(NameError):
            run("unknown + 1")


class StudentAddedTests(unittest.TestCase):
    def test_add_your_own_precedence_or_parentheses_case(self):
        self.assertEqual(run("2 * (3 + 4)"), 14)

    def test_add_your_own_let_binding_case(self):
        self.assertEqual(
            run("let x = 2; let y = x + 3; y * 4"),
            20,
        )


if __name__ == "__main__":
    unittest.main()
