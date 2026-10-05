# A2 — Functional Data Processing in Clojure

**BS0030 Programming Languages — Week 4**  
**Weight: 7% of final course grade**

## Purpose

This assignment assesses whether you can design a small program around **immutable values and composable transformations**, rather than merely reproduce Clojure syntax.

You will work with one vector of student records throughout the assignment. The completed program should demonstrate:

- persistent immutable updates;
- a readable thread-last data-processing pipeline;
- a closure that captures configuration;
- a reusable transformation built with comp;
- aggregation over a collection;
- observation of lazy evaluation;
- separation of pure transformation logic from visible effects.

The assignment intentionally extends Week 3. You should reuse map, filter, reduce, lexical bindings, and pure functions rather than relearn them.

---

## Shared dataset

The starter file defines:

~~~clojure
(def students
  [{:id 1 :name " Ada Lovelace "    :score 91 :active true  :group :a
    :stats {:attempts 2 :late 0}}
   {:id 2 :name "Grace Hopper"      :score 58 :active true  :group :b
    :stats {:attempts 3 :late 1}}
   {:id 3 :name "Alan Turing"       :score 88 :active false :group :a
    :stats {:attempts 1 :late 0}}
   {:id 4 :name " Edsger Dijkstra " :score 76 :active true  :group :b
    :stats {:attempts 2 :late 0}}
   {:id 5 :name "Barbara Liskov"    :score 84 :active true  :group :a
    :stats {:attempts 1 :late 0}}
   {:id 6 :name "John McCarthy"     :score 67 :active true  :group :c
    :stats {:attempts 2 :late 1}}])
~~~

Treat this as ordinary immutable input data. Do not mutate or replace the shared definition simply to make a task easier.

---

## Part 0 — Retrieval and prediction

Before implementing new functions, answer these orally or in your notes:

1. What is the difference between a binding and mutation?
2. What does map produce conceptually?
3. What does filter do?
4. What does reduce do?
5. What makes a function pure?
6. If conj produces a new vector, why does the original vector remain usable?

Then evaluate:

~~~clojure
(def original (first students))
(def changed  (assoc original :score 95))

(:score original)
(:score changed)
~~~

Predict both results before evaluation.

---

## Part 1 — Persistent immutable updates

> **Reference / help**
> - [Clojure Data Structures](https://clojure.org/reference/data_structures) — persistent maps and vectors, associative operations, and immutable collection behavior.
> - [Learn Clojure — Hashed Collections](https://clojure.org/guides/learn/hashed_colls) — practical examples of map lookup and update operations.

Complete:

~~~clojure
(update-score student new-score)
(record-attempt student)
~~~

Requirements:

- update-score returns a new student map whose :score is replaced;
- record-attempt increments [:stats :attempts];
- neither function may alter the input map.

Examples:

~~~clojure
(def ada (first students))
(def ada2 (update-score ada 95))
(def ada3 (record-attempt ada))

(:score ada)
; => 91

(:score ada2)
; => 95

(get-in ada [:stats :attempts])
; => 2

(get-in ada3 [:stats :attempts])
; => 3
~~~

Be prepared to explain **which versions remain accessible** and why this is persistence rather than disk persistence.

---

## Part 2 — A closure that captures configuration

> **Reference / help**
> - [Learn Clojure — Functions](https://clojure.org/guides/learn/functions) — local bindings, lexical scope, functions as values, and closures.

Complete:

~~~clojure
(minimum-score-checker minimum)
~~~

It must return a function that accepts one student record and reports whether the student's score is at least minimum.

Example:

~~~clojure
(def score-at-least-70? (minimum-score-checker 70))

(score-at-least-70? (first students))
; => true

(score-at-least-70? (second students))
; => false
~~~

The returned function must use the captured minimum binding. Do not hard-code 70.

**Explain:** after minimum-score-checker returns, where does the returned function obtain the value of minimum?

---

## Part 3 — Composition for reusable name normalization

> **Reference / help**
> - [Clojure `comp`](https://clojuredocs.org/clojure.core/comp) — composing functions; remember that the rightmost function receives the original input first.
> - [Clojure String API](https://clojure.github.io/clojure/clojure.string-api.html) — `trim`, `upper-case`, and related string functions.

The starter explicitly requires `clojure.string` as `str`.

Define normalize-name using **comp** so that it:

1. trims leading/trailing whitespace;
2. converts the remaining name to uppercase.

Examples:

~~~clojure
(normalize-name " Ada Lovelace ")
; => "ADA LOVELACE"

(normalize-name "Grace Hopper")
; => "GRACE HOPPER"
~~~

Do not write this part as one ad-hoc anonymous function. The purpose is to demonstrate function composition.

**Explain:** in what order do str/trim and str/upper-case actually run?

---

## Part 4 — The main thread-last pipeline

> **Reference / help**
> - [Threading Macros Guide](https://clojure.org/guides/threading_macros) — especially `->>` for functions whose collection argument appears last.
> - [Sequences](https://clojure.org/reference/sequences) — `filter`, `map`, `sort`, and the sequence abstraction.

Complete:

~~~clojure
(eligible-names student-coll minimum)
~~~

The result must contain normalized names of students who are:

- active; and
- at or above the supplied minimum score.

The names must be sorted and returned as a vector.

Use:

- the closure from Part 2;
- filter;
- map;
- sort;
- a **thread-last pipeline ->>**.

Example:

~~~clojure
(eligible-names students 70)
; => ["ADA LOVELACE" "BARBARA LISKOV" "EDSGER DIJKSTRA"]
~~~

At a minimum of 60, John McCarthy should also be included. Alan Turing must remain excluded because :active is false.

For code defence, be able to rewrite the pipeline conceptually as nested calls and identify the intermediate value after every stage.

---

## Part 5 — Aggregation

> **Reference / help**
> - [Sequences](https://clojure.org/reference/sequences) — collection-processing functions including `map`, `filter`, and `reduce`.

Complete:

~~~clojure
(average-score student-coll)
~~~

Requirements:

- use collection operations rather than an explicit mutable accumulator;
- return 0.0 for an empty collection;
- otherwise return a numeric average.

Examples:

~~~clojure
(average-score students)
; => approximately 77.33333333333333

(average-score [])
; => 0.0
~~~

Then complete:

~~~clojure
(build-report student-coll minimum)
~~~

It must return a map with this shape:

~~~clojure
{:minimum-score minimum
 :active-count ...
 :average-active-score ...
 :eligible-names [...]}
~~~

For the supplied dataset and minimum 70:

~~~clojure
(build-report students 70)
; => {:minimum-score 70
;     :active-count 5
;     :average-active-score 75.2
;     :eligible-names ["ADA LOVELACE" "BARBARA LISKOV" "EDSGER DIJKSTRA"]}
~~~

build-report should remain pure: same input values, same result, no printing or file access.

---

## Part 6 — Observe laziness rather than memorizing a definition

> **Reference / help**
> - [Sequences](https://clojure.org/reference/sequences) — sequence operations and lazy sequence behavior.
> - [Lazy Sequences](https://clojure.org/reference/lazy) — how deferred sequence computation is produced and realized.

The starter includes `traced-scores`, which deliberately places a `println` inside a lazy `map` so that realization becomes visible.

In the REPL evaluate, one form at a time:

~~~clojure
(def observed (traced-scores students))
~~~

Record whether anything prints.

Then:

~~~clojure
(first observed)
~~~

Record what prints and what value is returned.

Then:

~~~clojure
(doall observed)
~~~

Record what additional work becomes visible.

Finally evaluate (first observed) again and observe whether the already-realized portion is recomputed.

### Important precision point

Do **not** assume that requesting one value necessarily causes exactly one element's work to become visible. Clojure sequence processing may realize data in chunks. The conceptual question is:

> Which operation describes deferred work, and which operation forces some or all of that work to be realized?

Your short reflection must mention what you actually observed.

---

## Part 7 — Functional core, effectful shell

> **Reference / help**
> - [Functional Programming in Clojure](https://clojure.org/about/functional_programming) — immutable values, pure functions, and controlled state/effects.

Complete:

~~~clojure
(print-report! report)
~~~

This function is intentionally effectful: it should print the report.

The architectural separation is:

~~~text
students + threshold
        ↓
   build-report        PURE
        ↓
    report map
        ↓
   print-report!       EFFECT
~~~

Do not insert printing into eligible-names, average-score, or build-report.

A minimal acceptable output is:

~~~text
Minimum score: 70
Active students: 5
Average active score: 75.2
Eligible names: ADA LOVELACE, BARBARA LISKOV, EDSGER DIJKSTRA
~~~

Exact spacing is not assessed, but the values must come from the report map rather than be hard-coded.

---

## Part 8 — Integration check

Evaluate:

~~~clojure
(def report70 (build-report students 70))
report70
(print-report! report70)
~~~

Then change only the threshold:

~~~clojure
(build-report students 60)
~~~

Your design should adapt through ordinary function arguments. You should not need to rewrite the pipeline.

---

## Part 9 — Short reflection

At the bottom of your working file, add comments answering all four prompts in **1–3 sentences each**:

1. How do persistent values reduce the reasoning problems caused by mutable aliases?
2. What binding does your closure capture, and why is that useful?
3. What did you observe in the laziness experiment? Distinguish creating a lazy sequence from realizing it.
4. Which functions form your functional core, and which function is the effectful shell?

Use your own program as evidence rather than giving dictionary definitions.

---

# Completion levels

## Core — minimum acceptable evidence

A Core submission must correctly demonstrate:

- immutable update of flat and nested data;
- original versions remaining unchanged;
- an active-student filtering pipeline;
- normalized and sorted output names using ->>;
- basic correctness on the supplied dataset.

A submission that does only these tasks demonstrates the central Week 4 idea but does **not** yet contain all expected A2 evidence.

## Standard — expected complete A2

A Standard submission includes all Core work plus:

- minimum-score-checker implemented as a closure;
- normalize-name implemented with comp;
- aggregation through average-score;
- a pure integrated build-report;
- the laziness experiment and written observation;
- an effectful print-report! kept outside the pure core;
- all four reflection answers;
- code that can be explained and modified during defence.

This is the expected complete assignment.

## Extension — optional

Choose one or more only after Standard is complete:

- produce per-group averages using group-by;
- compare map with mapv and explain realization behavior;
- return both eligible and ineligible groups from one pure transformation;
- add a second closure, for example an active-group predicate factory;
- write the report to a file while keeping file I/O in a separate shell function;
- investigate how chunking affects the laziness experiment.

Do not add transducers, Java interop, macros, or external libraries merely to make the submission look advanced.

---

# Assessment evidence

A2 is worth **7% of the final course grade**. The following 100-point rubric is used as the evidence structure for the assignment:

| Area | Points |
|---|---:|
| Persistent immutable updates and version reasoning | 15 |
| Correct, readable ->> pipeline | 20 |
| Closure and captured configuration | 10 |
| Function composition with comp | 10 |
| Aggregation and pure report construction | 15 |
| Laziness experiment and explanation | 10 |
| Functional core / effectful shell separation | 10 |
| Explanation, code quality, and ability to defend/modify the solution | 10 |
| **Total** | **100** |

Correct output alone is insufficient if the submitted design bypasses the paradigm concepts the assignment is meant to assess.

---

# Submission expectation

Commit your completed file:

~~~text
labs/week04/work/week04_a2.clj
~~~

to **your course fork**.

Use a meaningful commit message, for example:

~~~text
Complete A2 functional data processing
~~~

Moodle is the official assignment/submission channel. Follow the deadline and any final submission instructions published there.

You may use documentation and permitted external assistance, but you must be able to explain, debug, and modify every significant part of the submitted solution.
