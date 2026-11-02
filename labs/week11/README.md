# Week 11: Go concurrency and channels — start A6

## Environment

Use the BS0030 **Go** Codespace from your student fork. Verify with `go version`. Copy [src/main.go](src/main.go) and [tests/main_test.go](tests/main_test.go) into `labs/week11/work/`. Modify the copied source; keep the supplied files unchanged for comparison.

From `labs/week11/work/`:

```bash
go run main.go
GO111MODULE=off go test -v
GO111MODULE=off go test -race -count=10
go run -race main.go
```

These module-free commands work without a `go.mod` for this introductory exercise. For PowerShell, use `$env:GO111MODULE="off"` before running `go test`. Do not infer correctness solely from passing tests: the starter's sequential placeholder intentionally returns the right values.

## Link to Week 10

Kotlin's encapsulation organizes state but does not itself make simultaneous updates safe. Go's goroutines provide independent execution; channels transfer results and coordinate completion. Distinguish **concurrency** from simultaneous **parallelism**.

## Workshop: 90 minutes

1. **10 min:** run the sequential baseline for `[1,2,3,4]`, expecting ordered squares `[1,4,9,16]` and total `30`. Identify the sole owner of the total.
2. **20 min:** replace the sequential placeholder in `concurrentSquares` with one goroutine per input and an unbuffered channel of `Result`. Explicitly pass index and value to each worker. Workers send; they do not mutate the total.
3. **15 min:** collect indexed results into input order. Explain why arrival order is unspecified.
4. **20 min:** receive exactly one result per input, including zero results for empty input. Separately discuss a single-sender stream whose sender closes its own channel. Do not let individual workers close a shared channel.
5. **15 min:** diagnose this deadlock in a **separate scratch program**: `ch := make(chan int); ch <- 1; fmt.Println(<-ch)`. Repair using a sending goroutine or a capacity-one buffer. Do not place broken code in the assessed program.
6. **10 min:** run tests and the race detector; explain why a clean run does not prove correctness under all schedules.

**Core:** correct message-passing and sum. **Standard:** indices, empty input, completion explanation and race-detector evidence. **Extension:** compare collector-owned state with a mutex-protected aggregate; no speedup is required.

## Evidence and submission

Follow [portfolio instructions](../../submission.md) and Moodle deadlines. Commit completed code, tests, reproducible commands and a brief explanation of ownership, ordering, completion, and race versus deadlock.

This is the Week 11 **foundation** of A6. Week 12 adds bounded worker pools, buffered channels and cancellation. See [the lecture](../../lectures/week11/lecture.md).
