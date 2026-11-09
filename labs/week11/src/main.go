// BS0030 Week 11 student starter. Copy into labs/week11/work/main.go.
// Complete TODOs; keep tests as an independent correctness contract.
package main

import "fmt"

type Result struct {
    Index int
    Value int
}

func sequentialSquares(values []int) ([]int, int) {
    ordered := make([]int, len(values))
    total := 0
    for i, n := range values {
        ordered[i] = n * n
        total += ordered[i]
    }
    return ordered, total
}

// concurrentSquares launches one goroutine per input, sends indexed results
// over a channel, and lets ONLY the collector mutate ordered and total.
// Week 11: no worker pool, select or cancellation yet (those are Week 12).
func concurrentSquares(values []int) ([]int, int) {
    // TODO: create a channel of Result.
    // TODO: launch one worker per input, passing index and value explicitly.
    // TODO: receive exactly len(values) results and restore input order.
    // TODO: compute total in the collector, never in workers.
    // Hint: the empty input must return an empty slice and zero total.
    return sequentialSquares(values) // REPLACE: sequential placeholder
}

func main() {
    values := []int{1, 2, 3, 4}
    ordered, total := concurrentSquares(values)
    fmt.Println(ordered, total) // [1 4 9 16] 30
}
