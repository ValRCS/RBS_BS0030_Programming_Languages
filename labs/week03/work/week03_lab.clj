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

;; -----------------------------------------------------------------------------
;; Part 2 — pure functions
;; -----------------------------------------------------------------------------

(defn square [x]
  ;; TODO
  (* x x))

(defn celsius->fahrenheit [c]
  ;; TODO: F = C * 9/5 + 32
  (+ (* c 9/5) 32)
)
;; -----------------------------------------------------------------------------
;; Part 3 — functions as values
;; -----------------------------------------------------------------------------

(defn apply-twice [f x]
  ;; TODO: apply f to x twice.
  (f (f x)))

;; -----------------------------------------------------------------------------
;; Part 5 — map
;; -----------------------------------------------------------------------------

(defn student-names [student-coll]
  (map :name student-coll))

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
  (reduce + (map :score student-coll)))

(defn average-score [student-coll]
  ;; TODO: return the arithmetic mean.
  ;; You may assume the lab dataset is non-empty.
  (/ (double (total-score student-coll)) (count student-coll)))

;; -----------------------------------------------------------------------------
;; Part 8 — pipeline
;; -----------------------------------------------------------------------------

(defn names-at-or-above [student-coll threshold]
  ;; TODO: filter by score, then map to names.
  (map :name  (passing-students student-coll threshold)))

;; -----------------------------------------------------------------------------
;; Part 9 — recursion
;; -----------------------------------------------------------------------------

(defn sum-recursive [xs]
  ;; TODO: use empty?, first, rest, and recursion.
  ;; Do not use reduce or apply in this function.
  (if (empty? xs)
    0
    (+ (first xs) (sum-recursive (rest xs)))))

;; -----------------------------------------------------------------------------
;; Part 10 — imperative -> functional rewrite
;; -----------------------------------------------------------------------------

(defn count-large-even-squares [values]
  ;; TODO:
  ;; 1. keep even values;
  ;; 2. square them;
  ;; 3. keep squares > 10;
  ;; 4. count the result.
  (count 
    (filter 
      #(> % 10) 
        (map square 
        (filter even? values)))))

;; -----------------------------------------------------------------------------
;; Part 11 — reflection
;; -----------------------------------------------------------------------------

;; 1. In the Python loop from assignment.md, which values are explicitly mutated?
;; ANSWER: count is mutated with count += 1. x and square ar also reasigned as they pass through the loop
;;
;; 2. In your Clojure rewrite, what replaces the mutable counter and explicit
;;    traversal loop?
;; ANSWER: filter and map are used for looping, count gives the final number so no counter is needed
;;
;; 3. Give one example from this lab where a function is passed as a value.
;; ANSWER: sqare is passed to map in count-large-even-squares
;;
;; 4. Give one example of an immutable collection operation that returns a new
;;    value.
;; ANSWER: map returns a new collection with the transformation applied to each element.
;;
;; 5. When is explicit recursion less clear than map, filter, or reduce?
;; ANSWER: When the task is a common pattern like summing (reduce + numbers) is clearer that sum-recursive
