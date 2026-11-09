# Week 13: Local event application: start A7

## Environment and portfolio

Use the **BS0030 Core** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
node --version && npm --version
```

Commit your source and explanations under `labs/week13/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Integrated starter and verification

Use the committed `starter/` files as the baseline: `lending.cjs` holds the pure decision, `events.cjs` holds the named event subscribers, `app.cjs` emits a local JSON fixture, and `types.ts` demonstrates typed payload validation. The tests are intentionally red until you complete the registration, disposal, and runtime guard TODOs.

```bash
node --test labs/week13/tests/*.test.cjs
node labs/week13/starter/app.cjs
npx --yes --package typescript@5.9.3 tsc labs/week13/starter/types.ts --strict --target ES2022 --module commonjs --outDir /tmp/week13-ts
node /tmp/week13-ts/types.js
```

Copy the starter files into `labs/week13/work/` for your submitted implementation and adapt test import paths to your copy; do not change tests merely to hide failures. No network service or browser framework is required. The expected listener order is decision, then audit; disposal must remove both listeners.

### Workshop sequence (90 minutes)

1. **15 min:** run the starter and predict synchronous dispatch.
2. **15 min:** register both listeners and implement reference-preserving cleanup.
3. **20 min:** predict and test microtask/timer order and callback error boundaries.
4. **20 min:** implement a runtime guard for finite integer request fields in `types.ts`.
5. **15 min:** run tests and explain the pure core and event shell.
6. **5 min:** preserve a Week 13 baseline commit for A7 continuation.

The Week 14 A7 rubric assesses the completed application, not a separate Week 13 submission. Preserve your baseline and demonstrate the callback-to-promise refactor in the code defence.

## Original minimal demonstration

## A runnable event shell

Create `labs/week13/work/app.cjs`:

```javascript
const { EventEmitter } = require('node:events');
const bus = new EventEmitter();
const allowed = (active, limit) => active < limit;
function onRequest(request) {
  console.log(allowed(request.active, request.limit));
}
bus.on('request', onRequest);
bus.emit('request', { active: 2, limit: 3 });
bus.off('request', onRequest);
```

Run `node labs/week13/work/app.cjs`. The expected output is true. Extend this with a local immutable fixture and named event payloads; do not require a remote service.

## Workshop sequence (90 minutes)

1. **20 min:** add two listeners and demonstrate synchronous invocation order.
2. **15 min:** remove a listener with the same reference and verify no duplicate effect remains.
3. **20 min:** trace a microtask and a timer, then test a callback failure.
4. **25 min:** create `types.ts` with a DomainEvent union and runtime guard over unknown JSON input.
5. **10 min:** explain the event shell and pure decision core. Start A7.

Compile TypeScript using the documented pinned teaching compiler:

```bash
npx --yes --package typescript@5.9.3 tsc labs/week13/work/types.ts --strict --target ES2022 --module commonjs --outDir /tmp/week13-ts
node /tmp/week13-ts/types.js
```

No @types/node dependency is needed for a type-only fixture that uses console, JSON and plain objects. Keep Node EventEmitter code in app.cjs. Core: working events and cleanup. Standard: scheduling trace plus validated typed payloads. Extension: a browser button UI with explicit listener disposal.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 13 lecture](../../lectures/week13/lecture.md). Week 14 gives deferred work a composable result representation through promises and async/await.
