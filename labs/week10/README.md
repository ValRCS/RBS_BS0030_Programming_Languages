# Week 10: Typed outcomes and A5 completion

## Environment and portfolio

Use the **BS0030 Kotlin** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
kotlinc -version && java -version
```

Commit your source and explanations under `labs/week10/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Continue the Week 9 model

Create `labs/week10/work/` and copy your own Week 9 source there. Keep both versions for comparison. Add these value and result declarations:

```kotlin
data class Member(val id: Int, val name: String)
sealed interface BorrowResult
data class Granted(val activeLoans: Int) : BorrowResult
data class Rejected(val reason: String) : BorrowResult
```

The Granted count describes the state after the operation; it is not a persistent database loan identifier. Change borrow to return BorrowResult and handle both alternatives with an exhaustive when expression. Add a `findMember(id: Int): Member?` function over a small local collection.

## Workshop sequence (90 minutes)

1. **15 min:** distinguish null lookup, expected rejection and invalid construction.
2. **25 min:** refactor outcomes and update clients without exposing the setter.
3. **20 min:** check structural equality, identity and nullable branches.
4. **15 min:** implement a generic `firstOrNull` and explain its input/output type relationship.
5. **15 min:** compare the Week 9 and Week 10 API and complete A5 evidence.

Run `kotlinc labs/week10/work/Main.kt -include-runtime -d /tmp/week10.jar` then `java -jar /tmp/week10.jar`.

Core: invariant plus sealed result handling. Standard: full A5. Extension: demonstrate shallow-copy aliasing safely, or compare optional Rust ownership concepts. Rust code is not required or assessed.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 10 lecture](../../lectures/week10/lecture.md). Week 11 asks how independently executing computations coordinate, using Go goroutines and channels.
