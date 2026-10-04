# Midterm preparation: Week 8

The midterm covers **Weeks 1–7**. It accounts for **20% of the course grade**. Week 8 introduces no new paradigm. Moodle is authoritative for the examination date, duration, permitted aids and submission procedure.

| Unit | Be able to explain and do |
| --- | --- |
| Weeks 1–2 | Language versus implementation, execution models, syntax versus semantics, grammar, precedence, ASTs, scope and introductory types |
| Weeks 3–4 | Pure transformations, higher-order functions, recursion, closures, persistent values, laziness and effects |
| Weeks 5–6 | Facts/rules/queries, terms, unification, ordered search, backtracking, recursive lists, cycle avoidance, negation/cut and finite-domain constraints |
| Week 7 | Keys, joins, row grain, duplicates, grouping, WHERE/HAVING, NULL, outer joins and subqueries |

## Separate practice prompts

1. Draw the AST for `3 * (5 + 1)` and explain how parentheses alter grouping.
2. Write a function factory that captures a discount rate. Explain lexical scope without using a global variable.
3. For `[10 30 50]`, compose a filter above 20 and a doubling map. Explain whether the original collection changes.
4. Trace `append(A,B,[red,blue])` through all splits. Distinguish a relation from a one-way function.
5. Give an example where applying negation to a free variable prevents the intended enumeration.
6. Describe a two-variable CLP(FD) model and distinguish posting constraints from labeling.
7. On the Week 7 fixture, report every book's active-loan count, including zero. Explain your join and COUNT expression.
8. Compare a constraint schedule with a grouped report: which models express their requirements directly, and what must the programmer still check?

These are practice tasks, not the confidential paper. Use the weekly labs to check reasoning, then attempt a fresh example without consulting the answer. Explain the mechanism behind every predicted output. Kotlin, Go and promise syntax are outside this midterm's scope.

## Preparation method

Revise concepts and worked traces rather than memorize surface syntax. For each model, identify the data representation, evaluation/control strategy, state or binding behavior, and one failure mode. Revisit relevant Sebesta 12e chapters and section titles through the lecture references; the Global edition may have different page numbers. Use official language documentation for implementation-specific details.
