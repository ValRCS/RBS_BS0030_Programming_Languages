;; BS0030 Week 3 Lab
;; Functional Programming I — student starter
;;
;; Copy this file to labs/week03/work/week03_lab.clj before editing.
;; Reload from a REPL with:
;;   (load-file "work/week03_lab.clj")

;; -----------------------------------------------------------------------------
;; Shared data
;; -----------------------------------------------------------------------------

(def numbers [1 2 3 4 5 6])

(def students
  [{:name "Ada"    :score 91}
   {:name "Grace"  :score 78}
   {:name "Alan"   :score 88}
   {:name "Edsger" :score 69}])

;; -----------------------------------------------------------------------------
;; Part 1 — bindings
;; -----------------------------------------------------------------------------

(defn invoice-total [price quantity]
  (* price quantity))
  nil)

;; -----------------------------------------------------------------------------
;; Part 2 — pure functions
;; -----------------------------------------------------------------------------

(defn square [x]
  ;; TODO
  nil)

(defn celsius->fahrenheit [c]
  ;; TODO: F = C * 9/5 + 32
  nil)

;; -----------------------------------------------------------------------------
;; Part 3 — functions as values
;; -----------------------------------------------------------------------------

(defn apply-twice [f x]
  ;; TODO: apply f to x twice.
  nil)

;; -----------------------------------------------------------------------------
;; Part 5 — map
;; -----------------------------------------------------------------------------

(defn student-names [student-coll]
  (map (:name student-coll)))

;; -----------------------------------------------------------------------------
;; Part 6 — filter
;; -----------------------------------------------------------------------------

(defn passing-students [student-coll threshold]
  ;; TODO: keep students whose :score is >= threshold.
  (filter #(>= (:score %) threshold) student-coll))

;; -----------------------------------------------------------------------------
;; Part 7 — reduce
;; -----------------------------------------------------------------------------

(defn total-score [student-coll]
  ;; TODO: sum all :score values using reduce.
  nil)

(defn average-score [student-coll]
  ;; TODO: return the arithmetic mean.
  ;; You may assume the lab dataset is non-empty.
  nil)

;; -----------------------------------------------------------------------------
;; Part 8 — pipeline
;; -----------------------------------------------------------------------------

(defn names-at-or-above [student-coll threshold]
  ;; TODO: filter by score, then map to names.
  nil)

;; -----------------------------------------------------------------------------
;; Part 9 — recursion
;; -----------------------------------------------------------------------------

(defn sum-recursive [xs]
  ;; TODO: use empty?, first, rest, and recursion.
  ;; Do not use reduce or apply in this function.
  nil)

;; -----------------------------------------------------------------------------
;; Part 10 — imperative -> functional rewrite
;; -----------------------------------------------------------------------------

(defn count-large-even-squares [values]
  ;; TODO:
  ;; 1. keep even values;
  ;; 2. square them;
  ;; 3. keep squares > 10;
  ;; 4. count the result.
  nil)

;; -----------------------------------------------------------------------------
;; Part 11 — reflection
;; -----------------------------------------------------------------------------

;; 1. In the Python loop from assignment.md, which values are explicitly mutated?
;; ANSWER:
;;
;; 2. In your Clojure rewrite, what replaces the mutable counter and explicit
;;    traversal loop?
;; ANSWER:
;;
;; 3. Give one example from this lab where a function is passed as a value.
;; ANSWER:
;;
;; 4. Give one example of an immutable collection operation that returns a new
;;    value.
;; ANSWER:
;;
;; 5. When is explicit recursion less clear than map, filter, or reduce?
;; ANSWER:
