# Week 8: Midterm Preparation and SQL Consolidation

BS0030 Programming Languages, Fall 2026

## Continuity

Week 7 completed the first-half sequence with relational queries.

## Midterm Preparation and SQL Consolidation

Week 8, BS0030 Programming Languages

**Assessment scope: Weeks 1–7. No new paradigm.**

## First-half course map

| Weeks | Model | Explain with an example |
| --- | --- | --- |
| 1–2 | imperative and language design | updates, grammar, AST |
| 3–4 | functional | values, closures, laziness |
| 5–6 | logic | unification, search, constraints |
| 7 | relational | joins, groups, NULL |

## A reasoning answer

1. State the result or identify the defect.
2. Trace the relevant language mechanism.
3. State assumptions about data or evaluation.
4. Give a correction or justify a design choice.

An unexplained output prediction provides incomplete evidence.

## Grammar and meaning

```text
expr = term, { "+", term } ;
term = atom, { "*", atom } ;
atom = number | "(", expr, ")" ;
```

Sketch the AST for `2 + 3 * 4`.
Which grammar level gives multiplication precedence?

## Functional retrieval

```clojure
(defn multiplier [factor]
  (fn [x] (* factor x)))
(let [times3 (multiplier 3)] (times3 5))
```

What result follows, and what context does the closure capture?

## Logic retrieval

```prolog
member_of(X, [X|_]).
member_of(X, [_|T]) :- member_of(X, T).
```

Trace `member_of(X, [a,b])` through both answers.
What does backtracking undo?

## Constraints and enumeration

```prolog
:- use_module(library(clpfd)).
X in 1..3, Y in 1..3, X #< Y.
```

What does propagation establish?
What additional goal enumerates concrete pairs?

## SQL consolidation

```sql
SELECT m.id, COUNT(l.id)
FROM member AS m
LEFT JOIN loan AS l
  ON l.member_id = m.id AND l.returned = 0
GROUP BY m.id;
```

Why does a member with no active loans receive zero?

## Comparing with criteria

For each proposed model, discuss:

- the problem representation;
- control and evaluation;
- state and effects;
- correctness risks;
- the reason it suits the stated task.

## Assessment instructions

- Follow the timing and permitted aids announced in Moodle.
- Work individually under the stated assessment rules.
- Explain predictions and show intermediate reasoning.
- Raise ambiguities with the instructor.
- External AI assistance requires explicit assessment permission.

## Reflection after assessment

Which explanation was hardest?

- syntax or static semantics;
- a closure or lazy evaluation;
- search and binding restoration;
- duplicate rows or NULL;
- selecting a suitable model.

## Week 9 and further study

Kotlin: classes, interfaces, encapsulation and composition.

[Midterm preparation guide](../../assessments/midterm-preparation.md)

Revisit the first-half readings by concept rather than reading
every chapter again. Practise explaining one program per model.

## Further reading in Sebesta

Revisit Chapters 1, 3–6, 9.12, 15 and 16 selectively using the preparation guide.

## Next unit

Week 9 introduces objects and interfaces as another way to organize computation.
