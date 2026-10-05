# Week 2 Grammar Exercises

Complete this file in your own fork. Short answers are enough, but use the vocabulary from the lecture: **terminal**, **nonterminal**, **production**, **start symbol**, **derivation**, **parse tree**, **AST**, **precedence**, and **associativity**.

The Tiny Language grammar used by the coding task is in [`examples/tiny-language.ebnf`](examples/tiny-language.ebnf).

## 1. Read one production

Consider:

```bnf
<assignment> ::= <identifier> "=" <expression> ";"
```

Identify:

- the nonterminal on the left-hand side;
- the nonterminals on the right-hand side;
- the terminal symbols;
- what `::=` means.

**Your answer:**
<assignment>
<identifier> and <expression>
"="
";"
`::=` means "is defined as" or "consists of"

## 2. Legal or illegal?

Using the Tiny Language grammar, decide whether each program is syntactically valid. For each invalid example, identify the first place where the grammar can no longer match the input.

### A

```text
let radius = 10;
radius * radius
```

**Your answer:** 
Illegal after radius * radius ; needed

### B

```text
let radius = ;
radius * radius
```

**Your answer:** 
Illegal - let radius = (something needed here, as program expects some expression) ;

### C

```text
let radius = 10;
let area = 3 * radius * radius;
area + 5
```

**Your answer:** 
Illegal - also after 5 needed ;

### D

```text
10 + * 5
```

**Your answer:** 
Illegal - two expressions next to each other + and *

## 3. BNF recursion to EBNF repetition

The following BNF describes one or more comma-separated identifiers:

```bnf
<ident-list> ::= <identifier>
               | <identifier> "," <ident-list>
```

Rewrite the same idea using EBNF repetition.

**Your EBNF:**

```ebnf
<ident-list> ::= <identifier> ("," <identifier>)*
```

In one or two sentences, explain why the EBNF is shorter.

**Your answer:**
It is shorter because it uses * to express iteration directly, rather than using recursion

> TODO

## 4. A short derivation

Use this simplified grammar:

```bnf
<expression> ::= <term> "+" <term>
<term>       ::= <number>
<number>     ::= "2" | "3"
```

Write a derivation from `<expression>` to:

```text
2 + 3
```

**Your derivation:**

```text
<expression>
<term> "+" <term>
<number> "+" <term>
"2" "+" <term>
"2" "+" <number>
"2" "+" "3"
2 + 3
```

## 5. Parse tree versus AST

For:

```text
2 + 3 * 4
```

Explain why a parse tree contains grammar categories such as `expression`, `term`, and `factor`, while an AST can be reduced to something like:

```text
Add
├── Number(2)
└── Multiply
    ├── Number(3)
    └── Number(4)
```

**Your answer:**

The parse tree must include all of the grammar because it shows exatly how each production was applied

## 6. Precedence versus associativity

Explain the difference between these two questions:

1. Why is `2 + 3 * 4` normally grouped as `2 + (3 * 4)`?
2. Why is `10 - 3 - 2` normally grouped as `(10 - 3) - 2`?

Use the words **precedence** and **associativity** correctly.

**Your answer:**

Precedence determines which operators are evaluated firts and * has a higher precedence than + so it groups as 2 + (3 *4)

Associativity determines how operators of equal precedence group: - is left-associative, so 10 - 3 - 2 groups as (10 - 3) - 2
