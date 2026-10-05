# Week 11: Go channels: start A6

## Environment and portfolio

Use the **BS0030 Go** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
go version
```

Commit your source and explanations under `labs/week11/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Sequential baseline

Create `labs/week11/work/`, save this as `main.go`, and run `go run main.go` from that folder:

```go
package main
import "fmt"
func main() {
    values := []int{1, 2, 3, 4}
    total := 0
    for _, n := range values { total += n*n }
    fmt.Println(total) // 30
}
```

## Workshop sequence (90 minutes)

1. **10 min:** predict the baseline and identify the sole owner of total.
2. **20 min:** launch workers that send squared values. Collect exactly one result per input without a shared worker-written total.
3. **15 min:** attach input indices and reconstruct input order.
4. **20 min:** replace the known receive count with a sole-producer closed stream. Explain who closes it.
5. **15 min:** repair a separate one-goroutine unbuffered deadlock example. Do not mix broken code into the working program.
6. **10 min:** run the race detector and explain what it can and cannot establish.

```bash
go run -race main.go
```

Core: correct values and a completion protocol. Standard: indexed results, closure explanation and clean race-detector evidence. Extension: contrast a mutex-protected aggregate with the message-passing aggregate.

Start A6 now; Week 12 adds a bounded pool and cancellation. Retain the sequential baseline and avoid using sleep as a completion protocol.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 11 lecture](../../lectures/week11/lecture.md). Week 12 extends channels into bounded worker pools, cancellation and complete pipeline lifecycles.
