# Week 10 — Typed outcomes and A5 completion

**Monday, 9 November 2026 · 90-minute Kotlin lab**  
Continuation of [Week 9: Kotlin OOP model](../week09/README.md). The task is to improve the **types and public contract** of the lending account without weakening its invariant.

## Environment

Use the **BS0030 Kotlin** Codespace configuration from your existing student fork; sync your fork before opening or rebuilding it. The Core environment is not the Kotlin environment.

From the repository root:

```bash
kotlinc -version && java -version
mkdir -p labs/week10/work
cp labs/week10/src/Main.kt labs/week10/work/Main.kt
```

The committed [starter](src/Main.kt) deliberately contains `TODO()` placeholders for assessed work. It **compiles** as a scaffold but its `main()` will throw until the missing logic is implemented. Do **not** edit the shared `src/Main.kt`; edit **your own** `work/Main.kt`. Keep your Week 9 source in `labs/week09/work/` as the baseline for your comparison.

If you have a complete Week 9 implementation, **transfer your own methods and design** into the Week 10 working copy instead of starting over. Do not duplicate `Account` declarations by copying both complete files together.

## Canonical A5 API and behavior

| Part | Requirement |
| --- | --- |
| Invariant | `0 <= activeLoans <= limit` at every valid observable state |
| Policy | `LoanPolicy`, `StandardPolicy` (3), `ResearchPolicy` (5) via composition |
| Construction | Reject a negative policy limit; keep the accepted limit fixed for this account |
| Count | Readable `activeLoans` with a **private setter** |
| Borrow | `BorrowResult`: `Granted(new activeLoans)` or `Rejected(nonblank reason)` |
| Rejection | Does not mutate `activeLoans`, including for limit zero |
| Return | `returnOne(): Boolean`; false at zero with no state change |
| Member | `data class Member(val id: Int, val name: String)` |
| Lookup | `findMember(id: Int): Member?`; absence is `null` |
| Generic | `fun <T> firstOrNull(xs: List<T>): T?` |
| Result handling | Exhaustive `when` over both sealed cases without a generic `else` |

**Important:** `Granted.activeLoans` is the new count **after** a successful operation, **not** a loan ID or the old count. The `Account` must protect the counter; making its setter public defeats the invariant.

## 90-minute workshop

1. **15 min — model the contracts.** From Week 9 distinguish missing member (`Member?`), expected full-capacity rejection (`Rejected`), and invalid construction (`require`).
2. **25 min — refactor.** Implement `borrow(): BorrowResult` and `returnOne(): Boolean` while preserving private mutation and both policies.
3. **20 min — values and boundaries.** Implement nullable lookup, explain `==` versus `===` for data classes, test exact/full/zero/negative cases.
4. **15 min — generics and evidence.** Implement `firstOrNull`; explain how `T` connects the input element type to result type `T?`.
5. **15 min — A5 completion.** Run checks, record output, and compare OOP with one procedural/functional alternative (mutability, aliasing, failure and invariant location).

## Build and run

From the repository root, after implementing the TODOs:

```bash
kotlinc labs/week10/work/Main.kt -include-runtime -d /tmp/week10.jar
java -jar /tmp/week10.jar
```

Run the supplied **behavioral contract checks** together with your implementation:

```bash
kotlinc labs/week10/work/Main.kt labs/week10/tests/ContractChecks.kt -include-runtime -d /tmp/week10-tests.jar
kotlin -classpath /tmp/week10-tests.jar ContractChecksKt
```

See [public contract-check source](tests/ContractChecks.kt). These tests exercise normal, full, empty, zero-limit and invalid construction boundaries; nullable lookup; values; and generic return types. They do **not** replace a student's own explanatory tests or cover every possible grader case. The test build has two `main` functions, so use the explicit `ContractChecksKt` entry point shown above, **not** `java -jar` for the combined test build.

A successful run ends with `Week 10 baseline contract checks passed.` If `TODO()` is still reachable, a `NotImplementedError` is expected until you implement it. Do not merely print the expected message.

## A5 submission

Complete [A5: Object-Oriented Design in Kotlin](assignment.md) (**6% of course grade**, local rubric **100 points**). Commit work in `labs/week10/work/`: source, reproducible commands, test output or screenshot, and a concise comparison of your Week 9 and Week 10 API including a type-system guarantee and a remaining runtime/domain obligation. Use the [portfolio submission instructions](../../submission.md); Moodle controls the deadline and final administrative rules. **Never commit generated JARs**.

Core: correct encapsulated account and sealed results. Standard: all A5 requirements and boundaries. Extension: safely demonstrate shallow-copy aliasing or discuss Rust ownership (optional and not assessed).

## Lecture and next week

[Week 10 lecture notes](../../lectures/week10/lecture.md). Week 11 introduces concurrency with Go: static types and a private setter alone do not make overlapping operations atomic.
