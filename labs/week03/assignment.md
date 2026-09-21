# Week 3 Practical — Functional Programming I

## Learning goals

By the end of this practical you should be able to:

- read and evaluate basic Clojure forms;
- use `let` and explain the difference between binding and mutation;
- define named and anonymous functions;
- treat functions as values;
- work with immutable vectors and maps;
- classify simple collection tasks as `map`, `filter`, `reduce`, or a composition;
- trace intermediate values through a functional pipeline;
- write one simple recursive function with a clear base case;
- rewrite a small imperative loop as a functional transformation;
- explain where explicit mutable state disappeared and what replaced it.

The lab is deliberately incremental. Keep the REPL open and work in small steps.

---

## Part 0 — REPL warm-up

> **Reference / help**
> - [Learn Clojure — Syntax](https://clojure.org/guides/learn/syntax) — basic forms, evaluation, and useful REPL helpers such as `doc` and `source`.
> - [The Reader](https://clojure.org/reference/reader) — how Clojure reads lists, vectors, maps, sets, symbols, and other forms; useful background for the Week 2 AST connection.

Before editing the starter file, type these forms directly into the REPL. **Predict each result first.**

```clojure
(+ 2 3)
(* 4 (+ 2 3))
(max 5 9 2)
(str "Riga" " " "BS")
(inc 10)
```

Then answer mentally:

1. What determines the operation in a Clojure call?
2. Why does `(* 4 (+ 2 3))` not require an operator-precedence table?
3. How does this notation connect to the AST discussion from Week 2?

---

## Part 1 — Bindings are not assignment statements

> **Reference / help**
> - [Learn Clojure — Functions](https://clojure.org/guides/learn/functions) — see **Locals and Closures → let** for local bindings and lexical scope.
> - [Special Forms](https://clojure.org/reference/special_forms) — the language reference for `let`, `fn`, `if`, `loop`, and `recur`.

Evaluate:

```clojure
(let [price 12
      quantity 4]
  (* price quantity))
```

Then evaluate:

```clojure
(let [x 10]
  (let [x 20]
    x))
```

Explain:

- how many bindings named `x` exist;
- which binding is visible in the inner body;
- whether the value `10` was mutated.

Now open `work/week03_lab.clj` and complete `invoice-total`.

Expected examples:

```clojure
(invoice-total 12 4)
; => 48

(invoice-total 7.5 3)
; => 22.5
```

---

## Part 2 — Define pure functions

> **Reference / help**
> - [Learn Clojure — Functions](https://clojure.org/guides/learn/functions) — defining named functions with `defn`, parameters, and return values.
> - [Functional Programming](https://clojure.org/about/functional_programming) — why Clojure emphasizes immutable values and functions rather than changing local variables.

Complete these functions in your work file:

```clojure
(square 5)
; => 25

(celsius->fahrenheit 0)
; => 32.0

(celsius->fahrenheit 100)
; => 212.0
```

The conversion formula is:

```text
F = C × 9/5 + 32
```

Questions:

- What values does each function depend on?
- Does either function modify externally visible state?
- Why are these useful examples of pure functions?

---

## Part 3 — Functions as values

> **Reference / help**
> - [Learn Clojure — Functions](https://clojure.org/guides/learn/functions) — first-class functions, anonymous functions with `fn`, and the compact `#(...)` syntax.
> - Remember: passing a function means passing the function value (for example `inc`), not calling it first (for example `(inc 10)`).

Complete `apply-twice`.

Expected behavior:

```clojure
(apply-twice inc 10)
; => 12

(apply-twice square 2)
; => 16
```

Then create an anonymous doubling function and pass it directly:

```clojure
(apply-twice (fn [x] (* 2 x)) 3)
; => 12
```

Optional compact syntax:

```clojure
(apply-twice #(* 2 %) 3)
```

Explain why `apply-twice` is a **higher-order function**.

---

## Part 4 — Immutable collections

> **Reference / help**
> - [Data Structures](https://clojure.org/reference/data_structures) — official overview of Clojure's immutable/persistent lists, vectors, maps, and sets.
> - [Learn Clojure — Sequential Collections](https://clojure.org/guides/learn/sequential_colls) — vectors, lists, `conj`, `first`, `rest`, and immutability.
> - [Learn Clojure — Hashed Collections](https://clojure.org/guides/learn/hashed_colls) — **recommended if maps are still unfamiliar**: map literals, `assoc`, `dissoc`, `get`, keyword lookup, `contains?`, `keys`, and `vals`.

A small map-operation reminder (these expressions return values; they do not mutate the original map):

```clojure
(def student {:name "Ada" :score 91})

(:name student)                 ; => "Ada"   keyword lookup
(get student :score)            ; => 91
(assoc student :score 95)       ; => {:name "Ada", :score 95}
(dissoc student :score)         ; => {:name "Ada"}
(keys student)                  ; keys of the map
(vals student)                  ; values of the map
```

The starter file contains:

```clojure
(def numbers [1 2 3 4 5 6])

(def students
  [{:name "Ada"    :score 91}
   {:name "Grace"  :score 78}
   {:name "Alan"   :score 88}
   {:name "Edsger" :score 69}])
```

Try:

```clojure
(conj numbers 7)
numbers

(first numbers)
(rest numbers)

(:name (first students))
(:score (first students))
```

Verify that `conj` produces a new collection value rather than modifying `numbers` in place.

---

## Part 5 — `map`: transform values

> **Reference / help**
> - [Sequences](https://clojure.org/reference/sequences) — official sequence abstraction and sequence-library overview; `map` is listed under operations that process each item to create a new sequence.
> - [Learn Clojure — Functions](https://clojure.org/guides/learn/functions) — useful when the function passed to `map` is anonymous.

Complete `student-names` using `map`.

Expected result:

```clojure
(student-names students)
; => ("Ada" "Grace" "Alan" "Edsger")
```

Then use `map` directly in the REPL to square all values in `numbers`.

Expected result:

```clojure
(1 4 9 16 25 36)
```

State the semantic pattern in words:

```text
one input element → ______________________________
```

---

## Part 6 — `filter`: select values

> **Reference / help**
> - [Sequences](https://clojure.org/reference/sequences) — `filter` selects items using a predicate.
> - [Learn Clojure — Hashed Collections](https://clojure.org/guides/learn/hashed_colls) — keyword lookup such as `(:score student)` when the sequence contains maps.

Complete `passing-students` so that it keeps students with scores at least the supplied threshold.

Expected examples:

```clojure
(passing-students students 80)
; => ({:name "Ada", :score 91} {:name "Alan", :score 88})

(passing-students students 70)
; => ({:name "Ada", :score 91}
;     {:name "Grace", :score 78}
;     {:name "Alan", :score 88})
```

Then answer:

- What does the predicate receive?
- What does it return?
- Does `filter` transform a student record into another record, or decide whether to retain it?

---

## Part 7 — `reduce`: combine values

> **Reference / help**
> - [Sequences](https://clojure.org/reference/sequences) — lists `reduce` among the core operations that consume a sequence to construct a result.
> - The accumulator is passed from one reduction step to the next; it replaces the mutable running total common in imperative loops.

Complete `total-score` using `reduce`.

Expected result:

```clojure
(total-score students)
; => 326
```

Then complete `average-score`.

Expected result:

```clojure
(average-score students)
; => 81.5
```

Do not create a mutable running total. Let the reduction carry the accumulated value.

---

## Part 8 — Build a pipeline

> **Reference / help**
> - [Sequences](https://clojure.org/reference/sequences) — the common abstraction behind composing `filter`, `map`, `reduce`, `count`, and related operations.
> - [Clojure FAQ — collections and sequences](https://clojure.org/guides/faq) — useful clarification on the difference between data-structure operations such as `assoc` and sequence transformations such as `map` and `filter`.

Complete `names-at-or-above` by composing operations on the student collection.

Expected result:

```clojure
(names-at-or-above students 80)
; => ("Ada" "Alan")
```

Trace the intermediate values for threshold `80`:

```text
all students
    ↓ filter
?
    ↓ map
?
```

You should be able to state the exact intermediate collection before running the expression.

---

## Part 9 — Recursion

> **Reference / help**
> - [Learn Clojure — Flow Control](https://clojure.org/guides/learn/flow) — see **Recursion**, including `loop` / `recur` and the recommendation to prefer higher-order collection functions when they express the task clearly.
> - [Sequences](https://clojure.org/reference/sequences) — definitions of `first`, `rest`, `empty?`, and the sequence abstraction used in the exercise.

Complete `sum-recursive` without using `reduce` or `apply`.

Expected behavior:

```clojure
(sum-recursive [])
; => 0

(sum-recursive [1 2 3 4])
; => 10
```

Use `empty?`, `first`, and `rest`.

Before writing the recursive case, identify:

- the **base case**;
- the smaller input passed to the recursive call.

After it works, compare:

```clojure
(sum-recursive numbers)
(reduce + numbers)
```

Which expression communicates the intent of summing a collection more directly?

---

## Part 10 — Imperative → functional rewrite

> **Reference / help**
> - [Functional Programming](https://clojure.org/about/functional_programming) — functional iteration, immutable values, and recursive looping.
> - [Sequences](https://clojure.org/reference/sequences) — `map`, `filter`, `reduce`, `count`, and other building blocks for replacing explicit traversal loops.

Consider this Python code:

```python
count = 0
for x in values:
    if x % 2 == 0:
        square = x * x
        if square > 10:
            count += 1
```

Complete `count-large-even-squares` using collection transformations rather than an explicit mutable counter.

Expected examples:

```clojure
(count-large-even-squares [1 2 3 4 5 6])
; => 2

(count-large-even-squares [2 4 6 8])
; => 3
```

For `[1 2 3 4 5 6]`, be able to show every intermediate value.

---

## Part 11 — Short reflection

> **Reference / help**
> - Revisit [Functional Programming](https://clojure.org/about/functional_programming) and [Data Structures](https://clojure.org/reference/data_structures) when explaining where mutation disappeared and how immutable collection operations replace it.

At the bottom of your work file, answer these in comments using 1–3 sentences each:

1. In the Python loop above, which values are explicitly mutated?
2. In your Clojure rewrite, what replaces the mutable counter and explicit traversal loop?
3. Give one example from this lab where a function is passed as a value.
4. Give one example of an immutable collection operation that returns a new value.
5. When is explicit recursion less clear than using `map`, `filter`, or `reduce`?

---

# Completion levels

## Core

Complete Parts 0–7.

## Standard — expected complete Week 3 work

Complete Parts 0–11.

## Extension

Choose one or more:

> **Reference / help for the extensions**
> - [Learn Clojure — Flow Control](https://clojure.org/guides/learn/flow) — `loop` / `recur`.
> - [Learn Clojure — Hashed Collections](https://clojure.org/guides/learn/hashed_colls) — maps and map-building operations.
> - [Sequences](https://clojure.org/reference/sequences) — `frequencies`, `map`, `filter`, `reduce`, and the fact that many sequence-producing functions are lazy.

1. Implement `my-map` recursively for a vector or sequence.
2. Write a higher-order function `make-threshold-predicate` that returns a predicate function.
3. Reimplement `sum-recursive` with `loop` / `recur` and compare the two versions.
4. Use `frequencies` to count score categories, then explain whether this is conceptually closer to `map`, `filter`, or `reduce`.
5. Investigate the difference between the returned types of `(map inc [1 2 3])` and `[2 3 4]`. Do not worry yet about laziness in depth; Week 4 returns to sequence realization.

---

# Submission expectation

Commit your completed file:

```text
labs/week03/work/week03_lab.clj
```

to your fork. Your code should load without syntax errors, and you should be prepared to explain the intermediate values in any `map` / `filter` / `reduce` pipeline you submit.
