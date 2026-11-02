// BS0030 · Week 10 · A5 student starter (intentionally INCOMPLETE).
// Copy to labs/week10/work/Main.kt; preserve your Week 9 version for comparison.
// TODO markers are assessed work. Do not replace these with hardcoded printouts.

data class Member(val id: Int, val name: String)

interface LoanPolicy {
    fun limit(): Int
}

class StandardPolicy : LoanPolicy {
    override fun limit(): Int = 3
}

class ResearchPolicy : LoanPolicy {
    // TODO: implement the second policy from Week 9 (limit 5).
    override fun limit(): Int = TODO("research loan limit")
}

sealed interface BorrowResult
data class Granted(val activeLoans: Int) : BorrowResult
data class Rejected(val reason: String) : BorrowResult

class Account(policy: LoanPolicy) {
    // Keep a stable limit for this account's lifetime.
    private val limit: Int = policy.limit()

    var activeLoans: Int = 0
        private set

    init {
        // TODO: reject a negative policy limit at construction time.
    }

    fun borrow(): BorrowResult {
        // TODO: at the limit, return Rejected(reason) WITHOUT changing state.
        // Otherwise increment exactly once and return Granted(NEW activeLoans).
        return TODO("typed borrow outcome and invariant")
    }

    fun returnOne(): Boolean {
        // TODO: return false without mutation when empty; otherwise decrement.
        return TODO("empty-return boundary")
    }
}

val members = listOf(Member(1, "Ada"), Member(2, "Ben"))

fun findMember(id: Int): Member? {
    // TODO: locate one member or return null (do not throw on not found).
    return TODO("nullable lookup")
}

fun <T> firstOrNull(xs: List<T>): T? {
    // TODO: preserve element type T in result T?; handle an empty list.
    return TODO("generic helper")
}

fun describe(result: BorrowResult): String =
    when (result) {
        is Granted -> "Active loans: ${result.activeLoans}"
        is Rejected -> "Rejected: ${result.reason}"
    }

fun main() {
    val account = Account(StandardPolicy())
    // The starter compiles, but the next line throws until borrow is implemented.
    println(describe(account.borrow()))
    // TODO: add checks, run ContractChecks.kt, and prepare A5 comparison notes.
}
