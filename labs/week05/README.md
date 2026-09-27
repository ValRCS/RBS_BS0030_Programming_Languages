# BS0030 Week 5 Lab — Logic Programming I

**SWI-Prolog: facts, rules, queries, unification, resolution, recursion, and backtracking**

Week 5 changes the computational model. Instead of primarily evaluating expressions from inputs to outputs, you will describe **relations** and ask SWI-Prolog to find substitutions that satisfy them.

This is a guided practical, not A3. Its purpose is to establish the execution model needed for the Week 6 logic/constraint work. It also starts building the exact habits A3 will require: **model a problem as relations, write recursive predicates, pose multiple queries, observe search behavior, and explain why the model works**. Week 5 stops before constraint solving itself.

## Learning goals

By the end of the lab you should be able to:

- create and query a small Prolog knowledge base;
- distinguish atoms, variables, facts, rules, and queries;
- predict simple unification success or failure;
- define derived relations and query them in several modes;
- define recursive `ancestor/2`;
- manually trace goal reduction and variable substitutions;
- explain where a choice point occurs and how backtracking restores bindings;
- recognize why clause and goal order can affect operational behavior;
- model a small problem relationally and test it through multiple query modes;
- identify where plain recursive search becomes insufficient and motivate the Week 6 move toward safer search and constraints.

## Start the Codespace

Use **your fork** of the public course repository.

1. Sync your fork with the upstream course repository.
2. Create a new Codespace, or rebuild an existing one.
3. Select **BS0030 Logic — SWI-Prolog**.
4. Wait for the container to finish building.
5. From the repository root run:

~~~bash
bash scripts/check-logic-environment.sh
~~~

You should see the SWI-Prolog version and:

~~~text
SWI-Prolog smoke test: OK
~~~

## Create your working copy

The `starter/` directory is course-provided. Do not edit it directly.

From the repository root:

~~~bash
mkdir -p labs/week05/work
cp labs/week05/starter/week05_lab.pl labs/week05/work/
cd labs/week05
~~~

If your working file already exists, do not overwrite it.

## Start SWI-Prolog

From `labs/week05`:

~~~bash
swipl
~~~

Load your file:

~~~prolog
?- [work/week05_lab].
~~~

After editing the file, reload changed source files with:

~~~prolog
?- make.
~~~

Exit with:

~~~prolog
?- halt.
~~~

**Important:** source files contain facts and rules. Enter `?- ...` queries at the SWI-Prolog prompt, not in the source file.

## Working method

For each task: **predict → query → inspect all answers → explain**. When a query has another solution, SWI-Prolog displays a prompt where `;` requests the next answer.

Keep the Week 5 mental model visible:

~~~text
selected goal
    ↓
unify with a compatible clause head
    ↓
apply substitution
    ↓
replace goal by body subgoals
    ↓
continue depth-first
    ↓
failure → restore bindings → try next choice
~~~

Continue with [assignment.md](assignment.md).

## A3 preparation path

The syllabus assignment **A3: Logic and Constraint Problem in Prolog** will require more than correct syntax. Week 5 begins its foundation by making you practice five pieces of evidence that will carry forward:

1. a clear relational representation of a problem;
2. derived predicates rather than duplicated facts;
3. recursion and search that you can trace;
4. several queries that demonstrate how the model behaves;
5. an explanation of both declarative meaning and operational behavior.

The final route problem intentionally reaches the boundary of this week's tools. A cycle exposes a weakness in naive recursive search; **Week 6 starts from that problem** and develops richer techniques before A3 asks you to apply logic and constraints in a more substantial model.

## What to commit

Commit your completed working file:

~~~text
labs/week05/work/week05_lab.pl
~~~

Use a meaningful message such as:

~~~text
Complete Week 5 Prolog lab
~~~

Moodle remains authoritative for announcements and any submission requirements.
