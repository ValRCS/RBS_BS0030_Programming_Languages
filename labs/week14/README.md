# Week 14: Asynchronous application and A7 completion

## Environment and portfolio

Use the **BS0030 Core** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
node --version
```

Commit your source and explanations under `labs/week14/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Offline asynchronous fixture

Create `labs/week14/work/app.cjs` and adapt your Week 13 event shell. Use this local API:

```javascript
function lookup(id, { signal } = {}) {
  return new Promise((resolve, reject) => {
    if (signal?.aborted) return reject(new Error('aborted'));
    const abort = () => {
      clearTimeout(timer);
      signal?.removeEventListener('abort', abort);
      reject(new Error('aborted'));
    };
    const timer = setTimeout(() => {
      signal?.removeEventListener('abort', abort);
      if (id < 0) reject(new Error('invalid id'));
      else resolve({ id, title: `Book ${id}` });
    }, 20);
    signal?.addEventListener('abort', abort, { once: true });
  });
}
```

This fake API uses a uniform delay so timing is not part of the task. It removes the listener after settlement and clears the timer on abort. Call it inside an async function and handle that function's rejected promise at the entry point.

## Workshop sequence (90 minutes)

1. **15 min:** refactor a dependent callback sequence into an awaited sequence.
2. **20 min:** compare independent operations with Promise.all and mixed outcomes with allSettled.
3. **20 min:** implement at most two active lookup workers, or sequential batches of at most two with the throughput limitation explained.
4. **20 min:** add AbortController cancellation or request-ID freshness protection. Test valid, invalid and empty input.
5. **15 min:** complete A7 and compare three paradigms on the same domain.

Run `node labs/week14/work/app.cjs`. A rejected lookup must not cause an unhandled rejection. Return or await all work that belongs to the app's completion contract.

Core: async composition and handled failure. Standard: full A7 with bounded overlap and cancellation/freshness. Extension: compare a Go service pipeline with the Node event shell. Do not require measured speedup or live networking.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 14 lecture](../../lectures/week14/lecture.md). The final assessment asks for cumulative explanation, modification and justified paradigm choices.
