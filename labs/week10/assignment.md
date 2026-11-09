# A5 — Object-Oriented Design in Kotlin

**Course weight: 6%. Local rubric: 100 points.** The deadline and submission procedure are announced in Moodle.

## Task

Continue your **Week 9 lending model**. Preserve the encapsulated account, policy interface, two policy implementations, and invariant:

```text
0 <= activeLoans <= limit
```

Refactor the API so a successful borrow returns the **new active count**, while rejection returns a reason and leaves the account unchanged. Keep the policy's validated, nonnegative limit constant throughout an account's lifetime. No database or UI framework is required.

## Required evidence

1. Working Kotlin source under `labs/week10/work/Main.kt`. Start from the [incomplete scaffold](src/Main.kt), or transfer **your own** Week 9 implementation into that working copy; retain your Week 9 baseline.
2. A `LoanPolicy` interface with `StandardPolicy` and `ResearchPolicy`, used via composition. Count is readable but may be changed only by validated account methods.
3. `data class Member`, `findMember(id: Int): Member?`, and a sealed `BorrowResult` with `Granted(activeLoans: Int)` and `Rejected(reason: String)`. Handle both outcomes exhaustively with `when` (without an indiscriminate `else`).
4. Executable tests/check statements for: exact loan limit; one extra rejected borrow (unchanged state); returning all loans and rejecting an empty return; zero-limit policy; invalid negative-limit construction; and nullable lookup.
5. A generic `fun <T> firstOrNull(xs: List<T>): T?` tested using at least two distinct element types and an empty collection.
6. A short comparison with a procedural/functional alternative: where state lives, where validation happens, how aliasing affects behavior, and one **compile-time** guarantee versus a **runtime/domain** obligation. Cite one concrete example rather than just naming the paradigms.

The `Granted.activeLoans` value means the count *after* successful borrowing, **not** a loan ID. A rejected operation must never increment the count.

## Execution and baseline checks

Use the BS0030 Kotlin Codespace environment. Follow [Week 10 lab instructions](README.md) for compiling, running, and saving evidence. The supplied public [contract checks](tests/ContractChecks.kt) are an executable **baseline** and do not replace your own explanation or all possible assessment cases:

```bash
kotlinc labs/week10/work/Main.kt -include-runtime -d /tmp/week10.jar
java -jar /tmp/week10.jar

kotlinc labs/week10/work/Main.kt labs/week10/tests/ContractChecks.kt -include-runtime -d /tmp/week10-tests.jar
kotlin -classpath /tmp/week10-tests.jar ContractChecksKt
```

Include your commit link, reproducible commands, source, observed output (or screenshot), and brief design comparison. Do not commit generated JAR files.

## Rubric

| Points | Criterion |
| ---: | --- |
| 25 | Encapsulated lending count, valid construction and both operation boundaries. |
| 15 | Two policy implementations used through a common interface and composition. |
| 20 | Data-class values, nullable lookup and sealed operation outcomes handled exhaustively. |
| 20 | Executable boundary checks for limit, extra borrow, empty return and invalid construction. |
| 10 | Generic helper whose output type relates to its input type. |
| 10 | Procedural/OOP comparison explaining mutability, aliasing and one type guarantee. |
| **100** | **Total** |

## Assistance and authorship

Follow the course syllabus assistance policy and any stricter Moodle instructions. Disclose substantial external or AI-generated code when required, and be able to explain and modify every submitted part in a code defence. Copying another student's assessed implementation is not permitted. Rust ownership and concurrency implementation are optional enrichment, **not A5 requirements**.

For submission follow [portfolio instructions](../../submission.md); Moodle remains authoritative for deadlines and administrative rules.
