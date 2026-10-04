# Week 5 Lecture — Logic Programming I: Facts, Rules, Queries, Unification, and Backtracking

BS0030 Programming Languages  
Riga Business School · Riga Technical University  
Fall 2026

## Position in the course

Weeks 3–4 treated computation as the evaluation and composition of functions over mostly immutable values. Week 4 ended with a deliberate question: what if, instead of specifying a direction from input to output, we describe **relations that must hold** and let the language search for values satisfying them?

Week 5 begins the two-week logic-programming unit using **Prolog**. The central shift is from giving an algorithm as a sequence of commands or transformations to giving a knowledge base of facts and rules, then posing queries.

The week follows the syllabus focus: **facts, rules, queries, unification, resolution, backtracking, and relations**, with practical work centered on a small knowledge base and recursive queries. Week 6 will extend this foundation to lists, larger search problems, negation/cut, and constraints.

## Learning objectives

By the end of Week 5, students should be able to:

1. explain the declarative idea behind logic programming;
2. distinguish Prolog facts, rules, and queries;
3. read and write simple predicates using atoms, variables, and compound terms;
4. explain why Prolog variables are logical variables rather than ordinary mutable storage locations;
5. trace simple unification steps and identify when unification succeeds or fails;
6. interpret a rule as a logical implication while recognizing that Prolog also gives it an operational execution strategy;
7. explain goal reduction/resolution at an introductory level;
8. predict how Prolog searches clauses and goals using depth-first, left-to-right execution;
9. explain backtracking and use `;` to request alternative solutions;
10. define simple recursive relations such as `ancestor/2`;
11. distinguish relational programming from a one-directional function;
12. recognize how clause and goal ordering can affect termination and performance even when the intended logical relation appears similar.

---

# 1. A new view of computation

In imperative programming we often write:

```text
state → command → changed state → command → changed state
```

In functional programming we emphasized:

```text
input values → functions → output values
```

Logic programming asks us to try another model:

```text
facts + rules + query → search for substitutions that make the query true
```

Instead of saying exactly **how to compute** an answer, we describe relationships and ask what follows from them.

This is declarative in an important sense, but not magical: Prolog still has an execution strategy, and programmers must understand it.

---

# 2. Start with facts

A Prolog program can begin as a small knowledge base:

```prolog
parent(alice, bob).
parent(bob, clara).
parent(alice, david).
parent(david, eva).
```

Each line is a **fact**.

Read:

```prolog
parent(alice, bob).
```

as:

> Alice is a parent of Bob.

`parent` is a predicate name. Here it has arity 2, so we may write `parent/2` when referring to the predicate itself.

The lowercase names `alice` and `bob` are atoms.

---

# 3. Queries ask whether or how something is true

At a Prolog prompt:

```prolog
?- parent(alice, bob).
true.
```

A false query:

```prolog
?- parent(clara, alice).
false.
```

But queries become more interesting with variables:

```prolog
?- parent(alice, X).
X = bob ;
X = david.
```

We did not write a loop over all people. We asked for values of `X` that satisfy the relation.

The semicolon asks Prolog to continue searching for another solution.

---

# 4. Prolog variables are not Python variables

Compare Python:

```python
x = 10
x = 20
```

The name `x` can denote different values at different times.

Now Prolog:

```prolog
?- X = 10.
X = 10.
```

Within a particular proof/search branch, a logical variable becomes constrained by unification. We do not normally think of it as a mutable box receiving assignment after assignment.

This distinction matters:

> `=` in introductory Prolog is **unification**, not ordinary imperative assignment.

Variables begin with an uppercase letter or underscore:

```prolog
X
Person
Child
_Result
```

Atoms normally begin lowercase:

```prolog
alice
riga
computer_science
```

---

# 5. Terms: Prolog's basic data model

Prolog programs manipulate **terms**.

Important categories include:

```text
atoms       alice, red, riga
numbers     42, 3.14
variables   X, Person, _Temp
compound    parent(alice, bob)
            point(3, 4)
            course(bs0030, programming_languages)
```

A compound term has a functor and arguments.

For example:

```prolog
book(author(ursula_le_guin), title(the_dispossessed))
```

is structured data. Prolog's syntax makes symbolic tree-like structures natural.

This connects back to Week 2: terms have syntax, internal structure, and matching rules. Here that structure becomes central to execution.

---

# 6. Rules derive new relationships

Facts alone record explicit relationships. Rules let us derive others.

```prolog
child(Child, Parent) :-
    parent(Parent, Child).
```

Read `:-` approximately as **if** when reading a clause declaratively:

> `Child` is a child of `Parent` if `Parent` is a parent of `Child`.

Operationally, when Prolog selects this rule during SLD resolution, its body becomes an ordered sequence of subgoals that Prolog tries from left to right.

Another rule:

```prolog
grandparent(Grandparent, Grandchild) :-
    parent(Grandparent, Parent),
    parent(Parent, Grandchild).
```

The comma means conjunction: both subgoals must succeed.

---

# 7. Rules are not functions

A Python function might encode one direction:

```python
def children_of(parent, pairs):
    return [child for p, child in pairs if p == parent]
```

A Prolog relation can often be queried in several modes:

```prolog
?- parent(alice, X).
```

Find Alice's children.

```prolog
?- parent(X, clara).
```

Find Clara's parent(s).

```prolog
?- parent(X, Y).
```

Enumerate known parent-child pairs.

```prolog
?- parent(alice, clara).
```

Test a fully specified proposition.

This multi-directional use is one of the most important conceptual differences from ordinary functions.

---

# 8. Unification: making terms agree

**Unification** attempts to make two terms identical by finding consistent substitutions for variables.

Simple case:

```prolog
?- X = alice.
X = alice.
```

Two variables:

```prolog
?- X = Y.
X = Y.
```

Structured terms:

```prolog
?- parent(X, bob) = parent(alice, Y).
X = alice,
Y = bob.
```

The outer functors and arities match, so Prolog recursively unifies corresponding arguments.

---

# 9. When unification fails

Different atoms:

```prolog
?- alice = bob.
false.
```

Different structures:

```prolog
?- point(1, 2) = line(1, 2).
false.
```

Conflicting requirements:

```prolog
?- pair(X, X) = pair(alice, bob).
false.
```

Why? The first argument would require `X = alice`; the second would require the same `X = bob`. Those constraints are inconsistent.

Unification is therefore not merely textual matching. It is a consistency process over structured terms.

---

# 10. Trace a query as goal reduction

Given:

```prolog
parent(alice, bob).
parent(bob, clara).

grandparent(X, Z) :-
    parent(X, Y),
    parent(Y, Z).
```

Ask:

```prolog
?- grandparent(alice, clara).
```

Conceptually:

```text
goal: grandparent(alice, clara)

match rule head:
grandparent(X, Z)

substitution:
X = alice
Z = clara

new goals:
parent(alice, Y), parent(Y, clara)
```

The first subgoal can match `parent(alice, bob)`, giving `Y = bob`. The second becomes `parent(bob, clara)`, which is a fact. The query succeeds.

This is the Week 5 intuition behind **SLD resolution**: select a goal, unify it with a clause head, and replace it with that clause's body under the resulting substitution. Prolog repeats this process until all goals are satisfied or the current branch fails.

---

# 11. Search matters

Suppose:

```prolog
likes(anna, tea).
likes(anna, coffee).
likes(ben, coffee).
```

Query:

```prolog
?- likes(anna, X).
```

Prolog tries clauses in program order. The first solution is:

```prolog
X = tea
```

If we request another solution with `;`, Prolog returns to a previous choice point and tries another matching clause:

```prolog
X = coffee
```

That return to an earlier choice and exploration of an alternative is **backtracking**.

---

# 12. Backtracking is systematic undo-and-try-again

A useful operational picture:

```text
choose a matching clause
        ↓
try to satisfy remaining goals
        ↓
      success? ── yes → report solution
        │
        no
        ↓
restore earlier variable bindings
        ↓
try next available alternative
```

The restoration is crucial. Bindings made in a failed search branch do not permanently contaminate other branches.

This differs sharply from ordinary mutable state, where undoing speculative changes may require explicit code.

---

# 13. Conjunction: all goals must hold

Given:

```prolog
student(anna).
student(ben).
passed(anna, programming_languages).
passed(ben, algorithms).
```

Query:

```prolog
?- student(X), passed(X, programming_languages).
X = anna.
```

For this ordinary Prolog program, the selected goal is the leftmost one:

1. find a solution for `student(X)`;
2. with that binding, try `passed(X, programming_languages)`;
3. if it fails, backtrack to find another `student(X)`;
4. continue until a solution is found or alternatives are exhausted.

The declarative reading is conjunction. The operational reading includes a definite search order.

---

# 14. Recursion defines transitive relationships

Direct parenthood is not enough to define ancestry.

Base case:

```prolog
ancestor(X, Y) :-
    parent(X, Y).
```

Recursive case:

```prolog
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).
```

Now, from:

```prolog
parent(alice, bob).
parent(bob, clara).
parent(clara, daniel).
```

we can ask:

```prolog
?- ancestor(alice, daniel).
true.
```

The recursive relation expresses reachability through **one or more parent edges**. The base clause handles direct parenthood; the recursive clause follows one parent edge and then continues the ancestry relation from the intermediate person.

---

# 15. Compare recursion in Clojure and Prolog

Clojure recursion from Week 3 might say:

```clojure
(defn factorial [n]
  (if (zero? n)
    1
    (* n (factorial (dec n)))))
```

The function has an obvious input-output direction.

Prolog recursion often describes a relation:

```prolog
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

The emphasis is not “call the function with X and calculate Y.” It is “these conditions characterize when `ancestor(X,Y)` holds.”

Yet Prolog still executes the clauses in an order. Declarative meaning and operational behavior coexist.

---

# 16. Clause order can change operational behavior

Consider the sensible version:

```prolog
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
```

Now imagine placing poorly structured recursion first:

```prolog
bad_ancestor(X, Y) :-
    bad_ancestor(X, Z),
    parent(Z, Y).

bad_ancestor(X, Y) :-
    parent(X, Y).
```

A human may see an intended recursive relationship, but Prolog's depth-first search can descend into the first recursive goal indefinitely before reaching useful facts.

Therefore:

> Declarative programming does not mean execution order is irrelevant.

It means the programmer describes relations at a higher level while still respecting the language's search semantics.

---

# 17. Goal order also matters

Suppose we want people who are students and passed a course:

```prolog
successful_student(X) :-
    student(X),
    passed(X, programming_languages).
```

For a finite knowledge base, this is straightforward.

In larger or recursive predicates, placing a goal that strongly constrains variables earlier can reduce the search space. Conversely, calling a broad generator before a selective relation can create unnecessary work.

This anticipates a recurring course theme:

- Clojure: evaluation strategy and laziness matter;
- Prolog: search order and goal order matter;
- SQL: query optimizers may reorder relational operations;
- Go/JavaScript: scheduling and event order matter.

Languages differ partly in **who controls execution order and how explicitly**.

---

# 18. Anonymous variables

Sometimes a value must exist but we do not care what it is.

```prolog
?- parent(alice, _).
true.
```

The anonymous variable `_` means roughly:

> there is some value here, but do not bind a reusable name for me.

A named variable beginning with underscore can be useful when a value is intentionally unused but still worth documenting:

```prolog
_Child
```

Do not use the same conceptual model for `_` as a normal named variable: each anonymous `_` occurrence is independent.

---

# 19. A richer knowledge base

```prolog
course(bs0030, programming_languages).
course(bs0013, data_structures).

enrolled(anna, bs0030).
enrolled(ben, bs0030).
enrolled(ben, bs0013).

completed(anna, algorithms).
completed(ben, algorithms).
completed(ben, programming_basics).
```

We can define:

```prolog
takes_programming_languages(Student) :-
    enrolled(Student, bs0030).
```

And query:

```prolog
?- takes_programming_languages(X).
X = anna ;
X = ben.
```

The point is not that this database is sophisticated. The point is that code and data cooperate through the same relational machinery.

---

# 20. A relation can expose missing information

Suppose:

```prolog
teaches(valdis, bs0030).
teaches(alex, bs0013).

enrolled(anna, bs0030).
enrolled(ben, bs0013).
```

Define:

```prolog
instructor_of(Instructor, Student) :-
    teaches(Instructor, Course),
    enrolled(Student, Course).
```

Then all of these are meaningful:

```prolog
?- instructor_of(valdis, anna).
?- instructor_of(Instructor, anna).
?- instructor_of(valdis, Student).
?- instructor_of(Instructor, Student).
```

The same relation supports checking, lookup in either direction, and enumeration.

This is the practical meaning of relational thinking.

---

# 21. Prolog is declarative, but the database analogy has limits

Facts may resemble database rows, and queries may resemble database queries. That comparison is useful but incomplete.

Prolog adds:

- recursive rules;
- logical variables;
- unification of structured terms;
- proof search and backtracking;
- predicates that can be used in multiple modes.

Week 7 will move to SQL, where relations and declarative querying are central but execution, variable semantics, recursion, and the underlying computational model differ substantially.

Do not collapse “declarative” into one single paradigm.

---

# 22. Common beginner misconception: `=` means assignment

Wrong mental model:

```text
X = alice
```

means “store `alice` into mutable variable X.”

Better mental model:

```text
Make the two terms consistent.
If X is unconstrained, X may become bound to alice.
If X is already constrained incompatibly, unification fails.
```

Example:

```prolog
?- X = alice, X = alice.
X = alice.

?- X = alice, X = bob.
false.
```

The second conjunction is inconsistent; Prolog does not simply overwrite `X` with `bob`.

---

# 23. Common beginner misconception: Prolog “understands” the domain

Given:

```prolog
parent(alice, bob).
```

Prolog does not independently know that parenthood implies age differences, family law, gender, biology, or anything else.

It knows only the facts and rules represented in the program plus the semantics of Prolog itself.

If we need grandparenthood, ancestry, siblinghood, prerequisites, route reachability, or another concept, we must represent the relevant relation correctly.

Logic programming automates inference **within a formalized model**. It does not replace modeling.

---

# 24. Common beginner misconception: declarative means no debugging

A Prolog program can be logically plausible and operationally poor.

Problems include:

- wrong argument order;
- overly general clauses;
- missing base cases;
- recursion before useful constraints;
- accidental infinite search;
- unexpected duplicate solutions;
- misunderstanding variable scope;
- assuming only one solution exists.

Debugging therefore asks two kinds of questions:

```text
Declarative: Is this the relation I intended?
Operational: How will Prolog search for proofs?
```

Both matter.

---

# 25. Practical pattern: build a knowledge base incrementally

For Week 5 practical work, use a disciplined cycle:

1. write a few ground facts;
2. query those facts directly;
3. introduce one variable into a query;
4. inspect all solutions;
5. add one simple derived rule;
6. test the rule in more than one query mode;
7. add a recursive rule with a clear base case;
8. test positive and negative cases;
9. deliberately request alternative solutions;
10. only then enlarge the knowledge base.

This reduces the number of concepts changing at once and makes search behavior observable.

---

# 26. Worked example: routes as relations

Facts:

```prolog
edge(riga, jelgava).
edge(jelgava, siauliai).
edge(siauliai, kaunas).
edge(riga, sigulda).
```

Direct reachability:

```prolog
reachable(X, Y) :- edge(X, Y).
```

Recursive reachability:

```prolog
reachable(X, Y) :-
    edge(X, Z),
    reachable(Z, Y).
```

Queries:

```prolog
?- reachable(riga, kaunas).
true.

?- reachable(riga, Destination).
```

The second query asks Prolog to enumerate destinations supported by the relation and search strategy.

For now assume the graph is acyclic. Cycles introduce a termination problem that we will treat as a search-design issue rather than pretending recursion alone solves it.

---

# 27. What Prolog is doing conceptually

A useful simplified model is:

```text
1. Select the leftmost current goal.
2. Try program clauses for that predicate in source order.
3. Unify the selected goal with a compatible clause head.
4. Apply the resulting substitution to the current goals.
5. Replace the selected goal with the clause body's subgoals.
6. Continue depth-first using the same leftmost selection rule.
7. If a branch fails, backtrack to the most recent choice point and restore the earlier bindings.
8. Report the query-variable bindings when no goals remain.
```

Real implementations contain many details and optimizations, but this model is sufficient for tracing Week 5 programs.

---

# 28. Functional versus logic programming

| Question | Functional (Clojure) | Logic (Prolog) |
| --- | --- | --- |
| Central abstraction | function | relation/predicate |
| Typical program | expressions and transformations | facts and rules |
| Variables | lexical bindings | logical variables/unification |
| Main control idea | evaluation/composition | proof search/backtracking |
| Multiple answers | usually represented explicitly as data | naturally explored as alternative solutions |
| Direction | functions normally map inputs to outputs | relations may support several query modes |
| Recursion | computes values | can define recursive relations/search |

Neither paradigm eliminates operational concerns. They expose different ones.

---

# 29. Connection back to Week 2

Week 2 separated syntax, semantics, scope, and types. Prolog gives us new examples for each category.

**Syntax:** clauses end with `.`, variables begin uppercase, rules use `:-`.

**Semantics:** a clause expresses a logical relationship and participates in proof search.

**Scope:** variables in a clause are local to that clause invocation; the same spelling in a separate clause does not create a shared mutable variable.

**Data model:** terms are recursively structured and unification works over their structure.

This is why learning programming languages is more than collecting syntax. Familiar words such as “variable” can denote substantially different semantic mechanisms.

---

# 30. Week 5 checklist

You should now be able to read:

```prolog
parent(alice, bob).
parent(bob, clara).

ancestor(X, Y) :-
    parent(X, Y).

ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).
```

and explain:

- which clauses are facts and which are rules;
- what `X`, `Y`, and `Z` mean;
- how a query unifies with a rule head;
- how rule bodies create subgoals;
- where alternatives create choice points;
- why backtracking can produce several answers;
- why recursion and clause order affect search.

If those explanations are clear, the core conceptual objective of Week 5 has been achieved.

---

# 31. Looking ahead to Week 6

Week 5 establishes the execution model. Week 6 uses it for larger problems.

We will add:

- lists and recursive list predicates;
- explicit search over candidate solutions;
- larger combinatorial problems such as graph coloring, N-Queens, or scheduling;
- the subtleties of negation as failure;
- `cut` and its effect on the search tree;
- constraints as a more powerful way to narrow solution spaces.

The progression is deliberate:

```text
Week 5: understand relations + unification + search
Week 6: engineer larger searches and constraints
```

Before using Prolog as a compact solver, we first need to understand what it is actually doing.
