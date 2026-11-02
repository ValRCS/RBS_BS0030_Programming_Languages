// BS0030 · Week 10 · public behavioral contract checks.
// These are not a solution. They compile together with your work/Main.kt.
// Run as: kotlin -classpath /tmp/week10-tests.jar ContractChecksKt
// They are a useful baseline, NOT the complete set of possible grading checks.

private fun expect(condition: Boolean, message: String) {
    check(condition) { message }
}

fun main() {
    val standard = Account(StandardPolicy())
    expect(standard.activeLoans == 0, "new account should have zero active loans")
    for (expected in 1..3) {
        val outcome = standard.borrow()
        expect(outcome is Granted, "borrow $expected should be granted")
        if (outcome is Granted) {
            expect(outcome.activeLoans == expected, "Granted must report NEW count")
        }
        expect(standard.activeLoans == expected, "state should increase exactly once")
    }

    val denied = standard.borrow()
    expect(denied is Rejected, "fourth standard borrow should be rejected")
    if (denied is Rejected) {
        expect(denied.reason.isNotBlank(), "rejection should explain why")
    }
    expect(standard.activeLoans == 3, "rejected borrow must leave state unchanged")

    repeat(3) {
        expect(standard.returnOne(), "returning a borrowed book should succeed")
    }
    expect(standard.activeLoans == 0, "three returns should reach zero")
    expect(!standard.returnOne(), "returning when empty must fail")
    expect(standard.activeLoans == 0, "empty return must not produce a negative count")

    val research = Account(ResearchPolicy())
    repeat(5) {
        expect(research.borrow() is Granted, "research limit should admit five borrows")
    }
    expect(research.borrow() is Rejected, "sixth research borrow must be rejected")
    expect(research.activeLoans == 5, "research count must remain at its limit")

    val zeroPolicy = object : LoanPolicy {
        override fun limit(): Int = 0
    }
    val zero = Account(zeroPolicy)
    expect(zero.borrow() is Rejected, "zero-limit policy always rejects borrow")
    expect(zero.activeLoans == 0, "zero-limit account must never increment")

    val negativePolicy = object : LoanPolicy {
        override fun limit(): Int = -1
    }
    expect(
        runCatching { Account(negativePolicy) }.exceptionOrNull() is IllegalArgumentException,
        "negative policy limit must fail construction using require"
    )

    expect(Member(1, "Ada") == Member(1, "Ada"), "data-class values should be equal")
    expect(findMember(1)?.name == "Ada", "known member should be found")
    expect(findMember(99) == null, "unknown member should return null")
    val id: Int? = firstOrNull(listOf(7, 8))
    val name: String? = firstOrNull(listOf("Ada", "Ben"))
    expect(id == 7 && name == "Ada", "generic helper should retain element type")
    expect(firstOrNull(emptyList<Int>()) == null, "empty list should return null")

    println("Week 10 baseline contract checks passed.")
}
