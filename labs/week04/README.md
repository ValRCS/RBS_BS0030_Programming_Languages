# BS0030 Week 4 Lab — Assignment A2

**Functional Programming II — persistent data, closures, composition, laziness, and effects**

This practical is **A2: Functional Data Processing in Clojure (7% of the final course grade)**.

Week 3 introduced Clojure through values, functions, immutable collections, map, filter, reduce, and recursion. Week 4 turns those ideas into one coherent functional program.

The central design rule is:

~~~text
ordinary data → immutable values
business logic → composable transformations
environmental interaction → explicit boundaries
~~~

## Before you start

Use **your fork** of ValRCS/RBS_BS0030_Programming_Languages. Your fork is your permanent course repository; a Codespace is a disposable development environment.

1. Open your fork on GitHub.
2. Create or reopen a Codespace.
3. Choose the **BS0030 Functional — Clojure** Dev Container configuration.
4. Wait for the environment to finish building.

Verify the functional environment from the repository root:

~~~bash
bash scripts/check-functional-environment.sh
~~~

Week 4 pins Clojure to **1.12.6** in labs/week04/deps.edn, matching Week 3.

## Create your Week 4 work area

The `starter/` directory contains the course-provided starting point. **Do not edit it directly.** Copy it into `work/` and make your changes there.

From the repository root:

~~~bash
cp labs/week04/starter/week04_a2.clj labs/week04/work/
cd labs/week04
~~~

If work/week04_a2.clj already exists, do not overwrite it.

## Start a REPL

From labs/week04:

~~~bash
clojure
~~~

Load your working file:

~~~clojure
(load-file "work/week04_a2.clj")
~~~

Reload the same file after edits. Exit with Ctrl+D.

## One dataset, several functional ideas

The whole assignment uses one vector of student records. Each record is an immutable map with flat and nested data:

~~~clojure
{:id 1
 :name " Ada Lovelace "
 :score 91
 :active true
 :group :a
 :stats {:attempts 2 :late 0}}
~~~

Do not replace the dataset with unrelated mini-exercises. The point is to see how persistent updates, closures, composed transformations, lazy sequence processing, aggregation, and effect separation cooperate in one program.

## Recommended working rhythm

For each part:

1. **Predict** the result or intermediate value.
2. Implement one small function.
3. Reload the file.
4. Evaluate a small example in the REPL.
5. Inspect intermediate values.
6. Explain the result using Week 4 vocabulary.

If a pipeline works but you cannot explain what value exists after each stage, the task is not complete.

## Continue with the assignment

Read [assignment.md](assignment.md) for the full specification, completion levels, assessment criteria, and submission expectations.

Your main working file is:

~~~text
labs/week04/work/week04_a2.clj
~~~

When finished, commit your Week 4 work to **your fork**. Moodle remains the official place for assignment instructions, deadlines, and final submission confirmation.

> **Course workflow:** Codespace = disposable laboratory. GitHub fork = permanent course portfolio.

## Reading connection

Sebesta Chapter 15 provides conceptual background on functional programming through Lisp/Scheme and other functional languages. For exact Clojure behavior and library functions, use the Week 4 materials and official Clojure documentation.
