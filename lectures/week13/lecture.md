# Week 13: Event-Driven Programming with JavaScript and TypeScript

BS0030 Programming Languages, Fall 2026

## Continuity

Go coordinated independent computations with channels. JavaScript organizes reactions around events and deferred work.

## Event-Driven Programming

Week 13, BS0030 Programming Languages

**JavaScript and TypeScript: reactions, callbacks and scheduling**

## Learning outcomes

- Register and remove event handlers.
- Explain inversion of control and closures.
- Trace synchronous code, microtasks and timers.
- Identify blocking work and callback errors.
- Distinguish TypeScript checking from runtime validation.

## Comparing Week 12 Go and Week 13 JavaScript

Go's worker pool uses independently scheduled goroutines and channels to coordinate results. The Node event bus instead registers functions that an event source invokes; ordinary `EventEmitter.emit()` listeners run **synchronously**, in registration order. Event-driven design does not imply concurrency, asynchronous dispatch, or a new thread. JavaScript runtimes can also use workers for parallel work, while Go can use event-driven designs.

| Question | Go worker pool | Node event application |
| --- | --- | --- |
| Who invokes work? | Go runtime schedules goroutines | Event source invokes listeners |
| Coordination | Channels, select, context | Event listeners, task/microtask scheduling |
| Blocking | One blocked goroutine need not block others | Long synchronous listener delays event-loop progress |
| Cancellation | Cooperative context propagation | Host/API-specific cancellation and cleanup |

## A simplified event-loop model

![Simplified event-loop diagram](diagrams/week13-event-loop.svg)

Synchronous JavaScript runs to completion. In the following standalone Node example, the microtask is processed after the current stack, before the timer callback:

```javascript
console.log('A');
queueMicrotask(() => console.log('M'));
setTimeout(() => console.log('T'), 0);
console.log('B');
// A, B, M, T
```

The diagram is a teaching abstraction, not a complete description of Node phases, `process.nextTick`, or every browser scheduling rule. Timers specify eligibility, not exact execution deadlines.

## One application, two weeks

Week 13's library lending example registers a pure lending decision and an audit subscriber for a named `borrow-request` event. Students verify synchronous listener ordering, remove both listeners by function identity, trace a deferred callback, and validate a typed payload. Week 14 retains the event shell while introducing promise-returning local lookups, async composition, failure handling, bounded overlap, and freshness/cancellation protection.

**Week 13 is the baseline, not a separate graded assignment.** The Week 14 A7 rubric assesses the completed application; keep the Week 13 commit for the code defence.

## A Node event source

```javascript
const { EventEmitter } = require('node:events');
const bus = new EventEmitter();
bus.on('loan', name => console.log(name));
bus.emit('loan', 'Ada');
console.log('done');
```

Expected output: Ada, then done.

## Inversion of control

```javascript
bus.on('loan', handler);
```

We supply behavior to an event source.
The source chooses when to invoke it.

Registration is different from calling `handler()` now.

## Browser events

```javascript
const button = document.querySelector('#borrow');
button.addEventListener('click', () => {
  console.log('borrow requested');
});
```

Assume the button exists. This runs in a browser, not Node.

## Event-driven architecture

![width:1050](diagrams/week13-events.svg)

One event may have several subscribers.
Each subscription has a lifecycle.

## Closures in handlers

```javascript
function makeCounter() {
  let count = 0;
  return () => ++count;
}
const next = makeCounter();
console.log(next(), next()); // 1 2
```

## const and object mutation

```javascript
const state = { count: 0 };
state.count += 1;
// state = { count: 2 }; // rejected
```

`const` fixes the binding, not the object's properties.

## Pure core and event shell

```javascript
const allowed = (active, limit) => active < limit;
bus.on('request', ({ active, limit }) => {
  console.log(allowed(active, limit));
});
```

Separate the decision from the event and logging effects.

## Subscription cleanup

```javascript
const handler = name => console.log(name);
bus.on('loan', handler);
bus.off('loan', handler);
```

Removal needs the same function reference.
`once` registers a listener for one invocation.

## Deferred callbacks

```javascript
console.log('A');
setTimeout(() => console.log('B'), 0);
console.log('C');
```

Expected output: A, C, B.

## Run to completion

```javascript
setTimeout(() => console.log('timer'), 0);
const end = Date.now() + 100;
while (Date.now() < end) { /* synchronous work */ }
console.log('finished');
```

The timer callback waits for this work to finish.

## Asynchronous I/O and parallel work

- A host can perform I/O while JavaScript handles other events.
- Long synchronous handlers block that thread.
- Workers can run JavaScript separately.
- `async` syntax alone does not parallelize CPU work.

## Microtasks and timers

```javascript
console.log('A');
queueMicrotask(() => console.log('M'));
setTimeout(() => console.log('T'), 0);
console.log('B');
```

Expected output: A, B, M, T.

## Microtask starvation

```javascript
function again() { queueMicrotask(again); }
// again(); // intentionally not executed
```

An endless microtask chain can delay timers and other work.

## Callback errors

```javascript
setTimeout(() => {
  try { throw new Error('failure'); }
  catch (error) { console.log(error.message); }
}, 0);
```

An outer try around timer registration does not catch this throw.

## Error-first callbacks

```javascript
const fs = require('node:fs');
fs.readFile('data.txt', 'utf8', (error, text) => {
  if (error) { console.error(error.message); return; }
  console.log(text);
});
```

The callback receives the eventual outcome.

## Dependent callbacks

```javascript
loadMember(id, (err, member) => {
  if (err) return report(err);
  loadLoans(member.id, (err, loans) => {
    if (err) return report(err);
    display(member, loans);
  });
});
```

This is API-shaped pseudocode.

## JavaScript dynamic typing

```javascript
let value = 3;
value = 'three';
console.log(typeof value); // string
```

Types belong to runtime values.
Bindings can refer to values of different types.

## Coercion and comparison

```javascript
console.log('3' + 1);  // 31
console.log('3' == 3); // true
console.log('3' === 3); // false
```

Prefer explicit conversion and intentional comparison rules.

## TypeScript event data

```typescript
type LoanRequest = { memberId: number; bookId: number };
function describe(request: LoanRequest): string {
  return `${request.memberId}:${request.bookId}`;
}
// describe({ memberId: 'Ada', bookId: 1 }); // rejected
```

## Type erasure and validation

TypeScript annotations normally disappear from emitted JavaScript.

Untrusted JSON still needs runtime checks.

```typescript
const raw: unknown = JSON.parse(text);
```

Narrow `raw` before using it as a request.

## Discriminated event alternatives

```typescript
type DomainEvent =
  | { kind: 'borrow'; bookId: number }
  | { kind: 'return'; loanId: number };
```

A checked `kind` branch narrows the available fields.

## Practical and Week 14

[Week 13 lab](../../labs/week13/README.md)

- Build a small event bus with cleanup.
- Trace callback order in Node.
- Keep a pure decision function.
- Validate and type event payloads.

Next: promises, async/await and error composition.

## Further study

- [Node events](https://nodejs.org/api/events.html).
- [Node event loop](https://nodejs.org/en/learn/asynchronous-work/event-loop-timers-and-nexttick).
- [TypeScript narrowing](https://www.typescriptlang.org/docs/handbook/2/narrowing.html).
- Sebesta 12e §14.5 and §9.12.

Exercise: explain why an event handler can be synchronous.

## Next unit

Week 14 gives deferred work a composable result representation through promises and async/await.
