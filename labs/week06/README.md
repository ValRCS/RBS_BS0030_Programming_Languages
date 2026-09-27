# BS0030 Week 6 Lab — Logic Programming II

**SWI-Prolog: lists, safe search, negation, and CLP(FD) constraints**

Week 6 continues directly from Week 5. You already know facts, rules, unification, recursion, choice points, and backtracking. This practical asks you to use that execution model deliberately: decompose recursive lists, prevent cyclic search, observe goal-order effects, and replace blind generate-and-test with finite-domain constraints.

This is a guided practical and preparation for **A3: Logic and Constraint Problem in Prolog**.

## Learning goals

By the end of the lab you should be able to:

- decompose Prolog lists with `[Head|Tail]`;
- define and query recursive list relations;
- use a visited list to make graph search cycle-safe;
- explain why goal order affects practical Prolog behavior;
- use negation as failure only after generating a sufficiently instantiated candidate;
- distinguish unification `=`, arithmetic evaluation `is`, and CLP(FD) equality `#=`;
- model finite-domain variables and constraints with `library(clpfd)`;
- separate constraint posting from enumeration with `labeling/2`;
- explain how propagation can reduce search before enumeration.

## Start the Codespace

Use your fork of the public repository. Sync it first, then open or rebuild the **BS0030 Logic — SWI-Prolog** Codespace.

From the repository root:

~~~bash
bash scripts/check-logic-environment.sh
~~~

## Create your working copy

~~~bash
mkdir -p labs/week06/work
cp labs/week06/starter/week06_lab.pl labs/week06/work/
cd labs/week06
swipl
~~~

Load the file:

~~~prolog
?- [work/week06_lab].
~~~

After edits:

~~~prolog
?- make.
~~~

## Working method

For each part use:

~~~text
predict → run → request alternatives with ; → explain
~~~

Do not judge a relation only by whether one query succeeds. Test the modes requested in the assignment and consider termination as well as logical meaning.

Continue with [assignment.md](assignment.md).

## A3 preparation

Week 5 established relational modeling and the operational search model. Week 6 adds the remaining A3 foundation:

1. choose a representation that rules out invalid states where possible;
2. make recursive search safe;
3. state domains and constraints before enumeration;
4. use several queries/tests to demonstrate behavior;
5. explain both the declarative model and the operational search.

## What to commit

Commit:

~~~text
labs/week06/work/week06_lab.pl
~~~

Use a meaningful message such as:

~~~text
Complete Week 6 Prolog constraints lab
~~~

Moodle remains authoritative for announcements and submission requirements.
