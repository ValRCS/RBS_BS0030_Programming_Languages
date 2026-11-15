# Week 13: Local event application — A7 baseline

**Event-driven JavaScript/TypeScript · 90-minute lab · 30 November 2026**

Week 13 introduces synchronous event-listener dispatch, inversion of control, function-identity cleanup, microtasks, timers, error boundaries and validation of unknown JSON. This is the **ungraded baseline for A7**; the assessed deliverable and rubric are in [Week 14](../week14/assignment.md).

## Environment

Use the **BS0030 Core** Codespace from your **own fork**. Sync your fork before opening or rebuilding it. Verify:

```bash
node --version && npm --version
```

The committed `starter/` directory contains:

- `lending.cjs`: an intentionally complete **pure eligibility predicate**, not a full A7 solution;
- `events.cjs`: named listeners with TODOs for registration and exact-reference disposal;
- `app.cjs` and `fixture.json`: a local reproducible event demonstration;
- `types.ts`: an incomplete TypeScript runtime guard (TODO);
- `tests/lending.test.cjs`: public behavioral tests; the event case fails until TODOs are implemented.

No remote service or framework is required. Use Node for the event application and the pinned TypeScript compiler for the type-only exercise.

## Create your working copy

From the repository root:

```bash
mkdir -p labs/week13/work
cp labs/week13/starter/* labs/week13/work/
cp labs/week13/tests/lending.test.cjs labs/week13/work/lending.test.cjs
```

**Do not overwrite existing student work.** In your copied `work/lending.test.cjs`, update these two imports to refer to your copies:

```javascript
const { allowed } = require('./lending.cjs');
const { createLendingBus } = require('./events.cjs');
```

Keep the instructor-managed public `starter/` and `tests/` files unchanged. The copied test file is there to verify **your** implementation; do not weaken its assertions.

## Predict and test the original baseline

```bash
node --test labs/week13/tests/*.test.cjs
node labs/week13/starter/app.cjs
```

The original event-listener test is expected to fail because event registration/disposal are TODOs. The TypeScript guard also rejects the valid fixture until implemented. After editing your own working copies:

```bash
node --test labs/week13/work/lending.test.cjs
node labs/week13/work/app.cjs
npx --yes --package typescript@5.9.3 tsc labs/week13/work/types.ts --strict --target ES2022 --module commonjs --outDir /tmp/week13-ts
node /tmp/week13-ts/types.js
```

The TypeScript command may download the pinned teaching compiler through npm on the first run. This type-only example does not need `@types/node`.

## Workshop sequence (90 minutes)

1. **15 min — synchronous events.** Predict `EventEmitter.emit` order; explain why listeners do not automatically become asynchronous.
2. **15 min — subscription lifecycle.** Register the decision and audit handlers, in that order. Remove the exact same function references during `dispose()`; verify zero remaining listeners.
3. **20 min — scheduling and errors.** Predict a synchronous log, queued microtask and timer; distinguish a later callback exception from a synchronous `try` surrounding timer registration.
4. **20 min — safe event data.** Complete `isBorrowRequest(value: unknown)` with an object/field check and finite-integer validation; do not rely on a TypeScript assertion to validate JSON.
5. **15 min — test evidence.** Run the Node tests and TypeScript example. Explain why the pure domain function and mutable event shell are separated.
6. **5 min — A7 baseline.** Commit working files and a brief explanation of expected listener order (decision, audit), cleanup, and scheduling.

**Expected behavior:** one borrow-request dispatch records a decision followed by an audit entry; disposal leaves no registered listeners and a later emit adds no history. The original starter does *not* yet satisfy this contract.

## Continuation and submission

Keep work under `labs/week13/work/`; preserve a baseline Git commit so you can explain the Week 14 promise/async refactor. See the [Week 13 practical specification](assignment.md), [Week 14 A7 rubric](../week14/assignment.md), [Week 13 lecture](../../lectures/week13/lecture.md), and the [portfolio instructions](../../submission.md). Moodle remains authoritative for deadlines and assessment conditions.
