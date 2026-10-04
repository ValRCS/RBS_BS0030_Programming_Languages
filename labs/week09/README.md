# Week 9: Kotlin domain model: start A5

## Environment and portfolio

Use the **BS0030 Kotlin** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
kotlinc -version && java -version
```

Commit your source and explanations under `labs/week09/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Setup and starter

Create `labs/week09/work/Main.kt`. The starter deliberately leaves behavior for you:

```kotlin
interface LoanPolicy { fun limit(): Int }
class StandardPolicy : LoanPolicy {
    override fun limit() = 3
}
class Account(private val policy: LoanPolicy) {
    var activeLoans: Int = 0
        private set
    init { require(policy.limit() >= 0) }
    fun borrow(): Boolean = TODO("preserve the invariant")
    fun returnOne(): Boolean = TODO("reject when no loan exists")
}
fun main() {
    val account = Account(StandardPolicy())
    // TODO: exercise accepted and rejected operations with check(...).
}
```

Compile and run from the repository root:

```bash
kotlinc labs/week09/work/Main.kt -include-runtime -d /tmp/week09.jar
java -jar /tmp/week09.jar
```

## Workshop sequence (90 minutes)

1. **15 min:** annotate the invariant `0 <= activeLoans <= policy.limit()` and define rejection behavior.
2. **25 min:** implement both operations with a private setter.
3. **15 min:** add a ResearchPolicy with limit 5. Keep policy limits constant for an account's lifetime.
4. **20 min:** test empty returns, exact limit, one extra borrow and repeated return.
5. **15 min:** explain interface dispatch and composition. Demonstrate that val does not freeze a mutable object.

Core: correct operations with one policy. Standard: two interchangeable policies and all boundary checks. Extension: compare a pure state-transition version without removing the OOP implementation.

This starts A5. Week 10 supplies the final assessed specification, including richer outcome types. Commit source and explanations in your work directory, not generated jars.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 9 lecture](../../lectures/week09/lecture.md). Week 10 refines this model with data and sealed classes, nullability, generics and type inference.
