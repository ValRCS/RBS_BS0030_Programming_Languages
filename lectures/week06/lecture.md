# Week 6 Lecture — Logic Programming II: Lists, Search, Control, and Constraints

BS0030 Programming Languages  
Riga Business School · Riga Technical University  
Fall 2026

## Position in the course

Week 5 established Prolog's basic computational model: facts and rules describe relations; queries are solved through unification, goal reduction, depth-first search, and backtracking. Week 6 uses that model for nontrivial computation.

The central progression is:

```text
relations → recursive list relations → generate-and-test search → control → constraint solving
```

The aim is not to collect Prolog tricks. It is to understand how representation, goal ordering, search, pruning, and constraints change the behavior of a declarative program.

Week 7 will move from logic programming to SQL and relational programming, providing an important comparison between two declarative traditions.

## Learning objectives

By the end of Week 6, students should be able to:

1. read Prolog list notation and its underlying head-tail structure;
2. define recursive predicates over lists using base and recursive clauses;
3. trace `member/2`, `append/3`, and similar relations under backtracking;
4. distinguish checking, generating, and partially instantiated uses of a relation;
5. formulate finite search problems as candidate generation plus constraints;
6. explain why representation and goal order affect search-space size and termination;
7. explain Prolog's negation as failure and distinguish it from classical logical negation;
8. explain what cut (`!`) does operationally and why careless cuts damage declarative meaning;
9. distinguish ordinary arithmetic evaluation from unification;
10. use CLP(FD) constraints to model finite-domain problems;
11. explain the difference between generate-and-test and constraint propagation;
12. model a small scheduling, coloring, or N-Queens problem declaratively;
13. compare Prolog's search model with functional and imperative approaches studied earlier.

---

# 1. Retrieval: what actually happened in Week 5?

Given:

```prolog
parent(alice, bob).
parent(bob, clara).

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

What does Prolog do with:

```prolog
?- ancestor(alice, Who).
```

A useful operational summary is:

```text
query
  ↓
unify with a clause head
  ↓
replace goal by clause body
  ↓
solve goals left-to-right
  ↓
backtrack at choice points
```

Today we deliberately create larger search spaces and learn how to control them.

---

# 2. Lists are recursive terms

Prolog list notation:

```prolog
[]
[alice]
[alice, bob, clara]
```

The key structural form is:

```prolog
[Head | Tail]
```

For example:

```prolog
[alice, bob, clara] = [alice | [bob, clara]]
```

and recursively:

```text
[alice | [bob | [clara | []]]]
```

This should look familiar after Clojure: recursive sequence processing again depends on a base case and a smaller remainder. The execution model, however, is different.

---

# 3. Unification can decompose a list

```prolog
?- [H | T] = [10, 20, 30].
H = 10,
T = [20, 30].
```

A more structured pattern:

```prolog
?- [A, B | Rest] = [10, 20, 30, 40].
A = 10,
B = 20,
Rest = [30, 40].
```

The syntax is not a special assignment operation. Ordinary unification matches recursive term structure.

---

# 4. Define membership relationally

A classic definition:

```prolog
member_of(X, [X | _]).
member_of(X, [_ | Tail]) :-
    member_of(X, Tail).
```

Base/direct case: `X` is the head.

Recursive case: if it is not obtained at this position, search the tail.

Check membership:

```prolog
?- member_of(20, [10, 20, 30]).
true.
```

Generate members:

```prolog
?- member_of(X, [10, 20, 30]).
X = 10 ;
X = 20 ;
X = 30.
```

One relation supports both checking and enumeration.

---

# 5. Trace `member_of/2`

For:

```prolog
?- member_of(20, [10, 20, 30]).
```

The first clause cannot unify `20` with the first head `10`. Prolog tries the recursive clause:

```text
member_of(20, [10,20,30])
        ↓
member_of(20, [20,30])
        ↓
first clause succeeds
```

This is recursion plus clause selection plus unification. There is no explicit loop counter.

---

# 6. `append/3` reveals relational programming

```prolog
append_to([], Ys, Ys).
append_to([X | Xs], Ys, [X | Zs]) :-
    append_to(Xs, Ys, Zs).
```

Conventional use:

```prolog
?- append_to([1,2], [3,4], Z).
Z = [1,2,3,4].
```

But also:

```prolog
?- append_to(X, Y, [1,2,3]).
X = [],        Y = [1,2,3] ;
X = [1],       Y = [2,3] ;
X = [1,2],     Y = [3] ;
X = [1,2,3],   Y = [].
```

A relation that looks like concatenation in one mode becomes a splitter in another.

---

# 7. Modes matter even without function signatures

We can describe common intended uses informally:

```text
member_of(+Item, +List)   check
member_of(-Item, +List)   generate elements
append_to(+A, +B, -C)     concatenate
append_to(-A, -B, +C)     generate splits
```

`+` and `-` here are documentation conventions, not part of the predicate call.

A declarative relation may support multiple modes, but not every mode has the same termination or performance behavior.

This is a more precise claim than saying “Prolog predicates are reversible.”

---

# 8. Search problems: generate candidates, then test them

Suppose three tasks `a`, `b`, and `c` must occupy three distinct slots.

A direct finite search idea:

```prolog
slot(1).
slot(2).
slot(3).

schedule(A, B, C) :-
    slot(A), slot(B), slot(C),
    A \= B,
    A \= C,
    B \= C.
```

Operationally:

```text
generate A
generate B
generate C
reject inconsistent combinations
```

This is **generate and test**.

For tiny spaces it is clear and useful. For large spaces it may do enormous amounts of unnecessary work.

---

# 9. Goal order changes the amount of search

Compare the idea:

```prolog
candidate(X),
expensive_relation(X),
selective_test(X).
```

with:

```prolog
candidate(X),
selective_test(X),
expensive_relation(X).
```

If `selective_test/1` rejects most candidates cheaply, the second ordering may explore far less work.

Declarative reading asks:

> What must be true?

Operational reading asks:

> In what order will Prolog try to establish it?

Week 5 introduced this distinction. Week 6 makes it an engineering concern.

---

# 10. A graph-coloring model

Consider a triangle graph. Adjacent vertices must have different colors.

```prolog
color(red).
color(green).
color(blue).

triangle(A, B, C) :-
    color(A),
    color(B),
    color(C),
    A \= B,
    B \= C,
    A \= C.
```

Query:

```prolog
?- triangle(A, B, C).
```

Prolog searches assignments. Backtracking is no longer an incidental implementation detail; it is doing useful combinatorial work for us.

But we are still enumerating candidates before rejecting many of them.

---

# 11. Failure can be useful control flow

In Prolog, failure means a branch cannot prove its current goals. Failure triggers backtracking.

That gives a distinctive programming pattern:

```text
make a choice
  ↓
try constraints/goals
  ↓
fail? → undo bindings → try another choice
```

Imperative code often requires explicit loops, conditionals, temporary state, and undo logic for the same search pattern.

Prolog packages this mechanism into the execution model.

---

# 12. Negation as failure

Prolog commonly writes negation as:

```prolog
\+ Goal
```

Operational meaning:

> Try `Goal`. If it can be proven, `\+ Goal` fails. If `Goal` cannot be proven, `\+ Goal` succeeds.

Example:

```prolog
bird(robin).
bird(penguin).
can_fly(robin).

flightless(X) :-
    bird(X),
    \+ can_fly(X).
```

Then:

```prolog
?- flightless(penguin).
true.
```

This does **not** establish a classical theorem that penguins cannot fly. It establishes failure to prove `can_fly(penguin)` from the current program.

---

# 13. The closed-world assumption needs care

A typical Prolog program often treats what cannot be proven as false for a query using negation as failure.

If our database says only:

```prolog
registered(alice).
```

then:

```prolog
?- \+ registered(bob).
true.
```

But the program may simply lack information about Bob.

Therefore distinguish:

```text
not known to be true
```

from:

```text
known to be false
```

This distinction matters in databases, knowledge representation, policy systems, and incomplete real-world data.

---

# 14. Negation works best with sufficiently instantiated goals

Consider:

```prolog
student(alice).
student(bob).
passed(alice).
```

Good pattern:

```prolog
needs_retry(X) :-
    student(X),
    \+ passed(X).
```

The positive goal first generates a concrete student; then negation checks that student.

Reversing the goals can give surprising behavior:

```prolog
bad_retry(X) :-
    \+ passed(X),
    student(X).
```

Because `passed(X)` can succeed for some `X`, the initial negated goal fails before `student/1` gets a chance to enumerate candidates.

Again: goal order is semantically consequential in practical Prolog.

---

# 15. Cut commits to choices

The cut operator is:

```prolog
!
```

When execution passes a cut, Prolog commits to choices made since entering the current predicate and discards relevant alternatives.

A familiar example:

```prolog
max(X, Y, X) :-
    X >= Y, !.
max(_, Y, Y).
```

Once `X >= Y` succeeds and the cut is crossed, Prolog does not later backtrack into the second clause for that call.

Cut is an operational search-control device. It is not a logical connective in the same sense as conjunction.

---

# 16. Why cut deserves suspicion

Cut can:

- improve efficiency by pruning alternatives known to be irrelevant;
- encode deterministic choice;
- prevent unwanted duplicate solutions.

But it can also:

- make clause order more significant;
- make predicates work in fewer modes;
- hide incorrect logic by suppressing alternatives;
- make code harder to reason about declaratively.

Rule of thumb for this course:

> First make the relation correct and understandable. Add cut only when you can explain exactly which choice points it removes and why removing them preserves the intended behavior.

---

# 17. Unification is not arithmetic evaluation

This is a common source of errors:

```prolog
?- X = 2 + 3.
X = 2+3.
```

Unification binds `X` to a structured term. It does not automatically calculate the expression.

Arithmetic evaluation uses `is`:

```prolog
?- X is 2 + 3.
X = 5.
```

But `is` is directional:

```prolog
?- 5 is X + 3.
```

cannot solve backwards for an unbound `X` in the way a mathematical equation would.

This is exactly where constraint logic programming becomes useful.

---

# 18. Constraints: state relationships before all values are known

SWI-Prolog provides finite-domain constraints through `library(clpfd)`:

```prolog
:- use_module(library(clpfd)).
```

Now we can write:

```prolog
?- X in 1..10, X + 3 #= 8.
X = 5.
```

Constraint operators include:

```text
#=    equal
#\=   not equal
#<    less than
#=<   less than or equal
#>    greater than
#>=   greater than or equal
```

Unlike ordinary `is`, constraints can often propagate information through partially known relationships.

---

# 19. Constraint propagation reduces possibilities

Suppose:

```prolog
X in 1..10,
Y in 1..10,
X + Y #= 10,
X #< Y.
```

The solver does not need to blindly enumerate all integer pairs before learning anything. Constraints reduce the possible domains.

Conceptually:

```text
initial domains
X ∈ 1..10, Y ∈ 1..10
        ↓
X + Y = 10
        ↓
X < Y
        ↓
smaller compatible domains
```

This is **constraint propagation**.

Search may still be needed, but propagation can make the search dramatically smaller.

---

# 20. Separate modeling from enumeration

A useful CLP(FD) pattern is:

```prolog
problem(Vars) :-
    Vars ins 1..N,
    constraints(Vars).
```

Then request concrete assignments with labeling:

```prolog
label(Vars).
```

This separates two concerns:

1. describe domains and relationships;
2. choose concrete values by search.

That separation is one of the clearest examples of declarative problem modeling in the course.

---

# 21. N-Queens: the problem

Place N queens on an N×N chessboard so that no two attack one another.

A compact representation is a list:

```text
Queens = [Q1, Q2, ..., QN]
```

List position = column.  
Value = row occupied by the queen.

Then we need:

- every row value in `1..N`;
- all row values different;
- diagonal constraints.

Representation already removes one whole class of invalid states: there is exactly one queen per column.

---

# 22. N-Queens with CLP(FD)

```prolog
:- use_module(library(clpfd)).

n_queens(N, Queens) :-
    length(Queens, N),
    Queens ins 1..N,
    all_distinct(Queens),
    safe_diagonals(Queens),
    labeling([ff], Queens).
```

One possible diagonal relation:

```prolog
safe_diagonals([]).
safe_diagonals([Q | Qs]) :-
    safe_from(Q, Qs, 1),
    safe_diagonals(Qs).

safe_from(_, [], _).
safe_from(Q, [R | Rs], D) :-
    Q #\= R + D,
    Q #\= R - D,
    D1 #= D + 1,
    safe_from(Q, Rs, D1).
```

The important lesson is not memorizing this code. It is identifying **variables, domains, constraints, and search**.

---

# 23. Model first, search second

For a constraint problem ask:

1. What are the unknowns?
2. What domain can each unknown take?
3. Which combinations are illegal?
4. Can representation eliminate invalid states before search?
5. Which constraints can propagate information early?
6. When do we actually need enumeration?

This is useful beyond Prolog. Constraint programming, SAT/SMT solving, optimization, scheduling, and configuration systems all reward careful modeling.

---

# 24. Generate-and-test versus constraints

Generate-and-test:

```text
generate complete candidate
          ↓
      test it
          ↓
 reject or accept
```

Constraint approach:

```text
state domains + relationships
          ↓
 propagate restrictions
          ↓
 search remaining choices
```

The difference is not “search versus no search.” Constraint systems often still search. The important difference is how much impossible space can be removed **before** or **during** enumeration.

---

# 25. Representation is part of the algorithm

For N-Queens, using one list element per column means we never generate boards containing two queens in the same column.

Compare two possible representations:

```text
N×N Boolean board
```

versus:

```text
list of N row positions
```

The second representation encodes an invariant structurally.

This connects to earlier course themes:

- Week 2: syntax trees encode structure;
- Clojure: persistent data structures influence operations;
- Prolog: term representation shapes unification and search;
- later Kotlin: types and domain models encode invariants.

---

# 26. Debugging Prolog requires two questions

When a predicate is wrong, ask both:

### Declarative question

> Does the relation state the intended conditions?

### Operational question

> How will Prolog search those conditions with these arguments?

Typical bugs include:

- missing or incorrect base cases;
- recursion that does not structurally progress;
- overly broad generators;
- constraints placed too late;
- negation on insufficiently instantiated variables;
- cuts that prune valid solutions;
- accidental use of `=` where arithmetic or constraints were intended.

---

# 27. Practical strategy for Week 6

For each problem:

```text
1. write a tiny instance
2. identify variables and terms
3. write the relation without optimization
4. query it in intended modes
5. inspect alternative solutions with ;
6. trace unexpected failure/nontermination
7. add constraints or improve goal order
8. only then consider pruning with cut
```

Small experiments are especially valuable in a language whose search behavior may be unfamiliar.

---

# 28. From Prolog to SQL

Both Prolog and SQL are often called declarative, but they are not the same model.

Prolog emphasizes:

```text
logical terms + rules + unification + proof search
```

SQL emphasizes:

```text
relations/tables + set/bag operations + declarative queries + optimizer
```

In Prolog, programmers must often understand clause and goal order because the default search strategy is visible operationally. In SQL, the database optimizer normally has much greater freedom to choose a physical execution plan.

Week 7 asks what “declarative” means in this second setting.

---

# 29. Paradigm comparison so far

| Model | Primary abstraction | Programmer expresses | Execution concern |
| --- | --- | --- | --- |
| Imperative | mutable state | commands | order of updates |
| Functional | values/functions | transformations | evaluation/recursion/laziness |
| Logic | relations | facts, rules, constraints | unification and search |

The same problem can look radically different because each paradigm makes different information explicit.

---

# 30. Week 6 takeaways

1. Lists are recursive terms that unification can construct and decompose.
2. Recursive predicates can check or generate solutions depending on their instantiation mode.
3. Backtracking turns nondeterministic choices into systematic search.
4. Goal and clause order affect termination and performance.
5. Negation as failure means failure to prove, not classical negation.
6. Cut prunes search and must be used deliberately.
7. CLP(FD) constraints express relationships among partially known finite-domain values.
8. Constraint propagation can reduce search before labeling enumerates solutions.
9. Representation is part of solving the problem.
10. “Declarative” does not mean “execution behavior does not matter.”

## Preparation for Week 7

Keep one question in mind:

> If both Prolog and SQL are declarative, why does SQL usually let the implementation choose much more of the execution order?

That question will connect logic programming to relational programming and query optimization.

