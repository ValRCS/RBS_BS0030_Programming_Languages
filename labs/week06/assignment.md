# Week 6 Practical — Search and Constraints

Work in `labs/week06/work/week06_lab.pl`. Complete the TODO sections in order.

## Part 1 — Recursive lists

Complete `member_of/2` and `append_to/3`.

Test at least:

~~~prolog
?- member_of(20, [10,20,30]).
?- member_of(X, [10,20,30]).
?- append_to([1,2], [3,4], Z).
?- append_to(A, B, [1,2,3]).
~~~

In a source comment, explain why the last query demonstrates that a Prolog relation is not simply a one-direction function.

## Part 2 — Repair the Week 5 route search

The supplied graph contains a cycle. Complete `route/3` using a visited list so that a node already on the current path is not revisited.

Required behavior:

~~~prolog
?- route(riga, vilnius, Path).
Path = [riga, kaunas, vilnius] ;
...

?- route(riga, berlin, _).
false.
~~~

The exact order of valid paths may depend on clause/fact order.

Add a comment answering: **what can happen to naive depth-first reachability on a cyclic graph, and what invariant does the visited list establish?**

## Part 3 — Goal order and negation as failure

Complete:

~~~prolog
needs_retry(Student) :-
    student(Student),
    \+ passed(Student).
~~~

Test:

~~~prolog
?- needs_retry(X).
~~~

Then inspect the deliberately bad ordering in `bad_needs_retry/1`.

In comments explain why generating `Student` before applying `\+ passed(Student)` matters. Use the phrase **negation as failure** and distinguish it from classical logical negation.

## Part 4 — Three meanings that look like equality

Run:

~~~prolog
?- X = 2 + 3.
?- X is 2 + 3.
~~~

Then:

~~~prolog
?- X in 1..10, X + 3 #= 8.
~~~

Add a short comment distinguishing `=` (unification), `is` (arithmetic evaluation), and `#=` (finite-domain constraint equality).

## Part 5 — Constraint propagation before labeling

Complete `pair_sum/2` so that both variables are in `1..10`, sum to 10, and `X #< Y`.

First query without labeling:

~~~prolog
?- pair_sum(X, Y).
~~~

Then enumerate:

~~~prolog
?- pair_sum(X, Y), labeling([], [X,Y]).
~~~

Record what changes between the two queries.

## Part 6 — Small scheduling problem

Three tasks `a`, `b`, and `c` must occupy distinct slots 1..3. Task `a` must occur before `c`; task `b` cannot use slot 1.

Complete `schedule/3` with CLP(FD), keeping constraint posting separate from labeling.

~~~prolog
?- schedule(A, B, C), labeling([], [A,B,C]).
~~~

Request all solutions and verify them.

## Extension — N-Queens

If the core work is complete, implement or finish `n_queens/2`. Represent the board as a list where list position is a column and the value is the queen's row. Use domains, `all_distinct/1`, diagonal constraints, and labeling.

~~~prolog
?- n_queens(4, Qs).
~~~

Be able to identify the variables, domains, constraints, and point where enumeration begins.

## Completion check

Your file should contain working implementations for Parts 1–6 and concise comments answering the reflection prompts. The extension is optional unless announced otherwise in Moodle.
