# Final-assessment preparation

The final assessment is cumulative. The **comprehensive component weighs 20% of the course**, and the **timed cumulative quiz weighs 10%**. The quiz draws substantially on the semester's weekly quiz concepts and follows the curve rule announced in Moodle. Moodle also sets the approved timing, aids and submission procedure.

## Comprehensive preparation

Be able to read unfamiliar small examples, predict behavior, explain the mechanism, repair a defect and justify a model choice. Emphasis falls on the second half while retaining first-half transfer.

| Area | Required distinctions |
| --- | --- |
| Kotlin | Encapsulation/invariants, interface dispatch, composition/inheritance, val/mutation, equality/identity, nullable types, data/sealed classes, generics/variance |
| Go | Concurrency/parallelism, channels/buffers, races/deadlocks, sender/closure ownership, bounded workers, select, cancellation/completion and error policy |
| JavaScript/TypeScript | Events/async invocation, host APIs, closures, listener cleanup, run-to-completion, microtasks/timers, static typing/runtime validation |
| Async composition | Promise states, returned chains, await, dependent/independent work, all/allSettled, failure/recovery, timeout/cancellation and stale results |
| First-half transfer | Grammar/AST, scope/types, pure transformations/lazy effects, unification/search/constraints, joins/groups/NULL |

## Separate practice prompts

1. Design a small checked domain operation and name a property the type checker does not establish.
2. Show an aliasing example involving a mutable collection, then repair it or state its ownership contract.
3. Draw a producer-worker-collector lifecycle for empty input and for early cancellation.
4. Explain why a producer can block after its consumer returns early.
5. Trace a synchronous EventEmitter listener, a microtask and a timer in one standalone script.
6. Compare two dependent API calls with two independent calls. State when each can start.
7. Describe an async timeout that leaves work running and a cancellation-aware alternative.
8. Choose models for a scheduling problem, a stored-data report and a responsive interface, using explicit criteria.

## Portfolio and code defence

Choose one assignment you can explain from input through output, then practise modifying it. Also be ready to discuss other submitted work. Explain the data representation, central language constructs, test evidence and one meaningful design trade-off. Disclosure of assistance does not replace understanding of submitted code.

## Timed quiz

Review weekly quiz feedback and terminology across all instructional units. Practise accurate recognition after you understand the mechanism. The quiz's exact questions and keys remain confidential. Optional Rust material is enrichment rather than required core content.
