# Week 12: Bounded cancellable pipeline and A6

## Environment and portfolio

Use the **BS0030 Go** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
go version
```

Commit your source and explanations under `labs/week12/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Build a fixed-worker pipeline

Create `labs/week12/work/`. Copy your own sequential baseline and begin with this worker shape inside a Go program:

```go
func worker(ctx context.Context, jobs <-chan int,
    results chan<- int, wg *sync.WaitGroup) {
    defer wg.Done()
    for {
        select {
        case <-ctx.Done(): return
        case n, ok := <-jobs:
            if !ok { return }
            select {
            case <-ctx.Done(): return
            case results <- n*n:
            }
        }
    }
}
```

Import context and sync. Implement the producer, collector and single results-closing coordinator. Add positive-worker-count validation. Use immutable integer messages for the core task.

## Workshop sequence (90 minutes)

1. **15 min:** draw ownership of jobs, results and aggregation.
2. **25 min:** implement normal completion with 3 workers and bounded channels.
3. **20 min:** add context cancellation to both producer sends and worker edges.
4. **20 min:** test empty input, one worker, many inputs and early cancellation. Wait for complete shutdown.
5. **10 min:** explain the sequential/concurrent trade-off and complete A6.

In the working directory initialize a module once with `go mod init example.edu/bs0030/week12`. Run `go test -race ./...` for your test files and `go run -race .` for the demonstration.

Core: bounded workers and normal completion. Standard: full A6 including cancellation and tests. Extension: indexed per-item errors with a documented fail-fast policy. Speedup is not a grading requirement.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 12 lecture](../../lectures/week12/lecture.md). Week 13 contrasts these independently progressing goroutines with event-driven JavaScript callbacks.
