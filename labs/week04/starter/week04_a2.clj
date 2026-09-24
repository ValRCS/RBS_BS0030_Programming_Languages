;; BS0030 Week 4 — A2 Functional Data Processing
;; Student starter
;;
;; Copy this file to labs/week04/work/week04_a2.clj before editing.
;; Reload from a REPL with:
;;   (load-file "work/week04_a2.clj")

(require '[clojure.string :as str])

;; -----------------------------------------------------------------------------
;; Shared immutable dataset
;; -----------------------------------------------------------------------------

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

;; -----------------------------------------------------------------------------
;; Part 1 — persistent immutable updates
;; -----------------------------------------------------------------------------

(defn update-score [student new-score]
  ;; TODO: return a new student map with :score replaced.
  nil)

(defn record-attempt [student]
  ;; TODO: increment [:stats :attempts] without mutating the input map.
  nil)

;; -----------------------------------------------------------------------------
;; Part 2 — closure
;; -----------------------------------------------------------------------------

(defn minimum-score-checker [minimum]
  ;; TODO: return a function that accepts one student map and checks
  ;; whether (:score student) is >= the captured minimum.
  nil)

;; -----------------------------------------------------------------------------
;; Part 3 — composition
;; -----------------------------------------------------------------------------

(def normalize-name
  ;; TODO: define with comp.
  ;; Required behavior:
  ;; " Ada Lovelace " -> "ADA LOVELACE"
  identity)

;; -----------------------------------------------------------------------------
;; Part 4 — main thread-last pipeline
;; -----------------------------------------------------------------------------

(defn eligible-names [student-coll minimum]
  ;; TODO:
  ;; 1. keep active students
  ;; 2. keep students accepted by (minimum-score-checker minimum)
  ;; 3. extract names
  ;; 4. normalize names
  ;; 5. sort
  ;; 6. return a vector
  ;;
  ;; Use ->> for the main pipeline.
  nil)

;; -----------------------------------------------------------------------------
;; Part 5 — aggregation and pure report construction
;; -----------------------------------------------------------------------------

(defn average-score [student-coll]
  ;; TODO:
  ;; - return 0.0 for an empty collection
  ;; - otherwise calculate the arithmetic mean of :score values
  nil)

(defn build-report [student-coll minimum]
  ;; TODO: return
  ;; {:minimum-score minimum
  ;;  :active-count ...
  ;;  :average-active-score ...
  ;;  :eligible-names [...]}
  ;;
  ;; Keep this function pure: no println, slurp, spit, time, randomness, etc.
  nil)

;; -----------------------------------------------------------------------------
;; Part 6 — laziness experiment
;; -----------------------------------------------------------------------------

(defn traced-scores [student-coll]
  ;; Intentionally effectful INSIDE a lazy map for observation.
  ;; Do not copy this design into build-report.
  (map (fn [student]
         (println "realizing student" (:id student))
         (:score student))
       student-coll))

;; Suggested REPL experiment:
;;
;; (def observed (traced-scores students))
;; (first observed)
;; (doall observed)
;; (first observed)
;;
;; Record what you observe in the reflection at the bottom of this file.
;; Clojure may realize sequence elements in chunks, so do not assume that
;; exactly one println must occur for one requested element.

;; -----------------------------------------------------------------------------
;; Part 7 — effectful shell
;; -----------------------------------------------------------------------------

(defn print-report! [report]
  ;; TODO: print the values from the report map.
  ;; Keep all printing here rather than in the pure transformation functions.
  nil)

;; -----------------------------------------------------------------------------
;; Part 8 — integration examples
;; -----------------------------------------------------------------------------

;; After implementation, these should be useful checks:
;;
;; (eligible-names students 70)
;; => ["ADA LOVELACE" "BARBARA LISKOV" "EDSGER DIJKSTRA"]
;;
;; (build-report students 70)
;; => {:minimum-score 70
;;     :active-count 5
;;     :average-active-score 75.2
;;     :eligible-names ["ADA LOVELACE" "BARBARA LISKOV" "EDSGER DIJKSTRA"]}
;;
;; (print-report! (build-report students 70))

;; -----------------------------------------------------------------------------
;; Part 9 — reflection (1–3 sentences for each)
;; -----------------------------------------------------------------------------

;; 1. Persistent values and mutable aliases:
;;
;; TODO
;;
;; 2. What binding does your closure capture, and why is that useful?
;;
;; TODO
;;
;; 3. What did you observe in the laziness experiment?
;;
;; TODO
;;
;; 4. Which functions form your functional core, and which function is
;;    the effectful shell?
;;
;; TODO
