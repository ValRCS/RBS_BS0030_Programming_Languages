# Week 9: Object-Oriented Programming I with Kotlin

BS0030 Programming Languages, Fall 2026

## Continuity

The midterm reviewed how commands, functions, logical relations and SQL queries express computation.

## Object-Oriented Programming I

Week 9, BS0030 Programming Languages

**Kotlin: objects, invariants and interfaces**

## A domain invariant

A member may borrow at most three books.

```text
0 <= activeLoans <= limit
```

How can every operation preserve this rule?
Who is allowed to change the count?

## Learning outcomes

- Construct and use Kotlin classes.
- Explain encapsulation through an invariant.
- Use an interface for interchangeable behavior.
- Distinguish composition from inheritance.
- Compare identity, equality and mutable state.

## Kotlin execution model

```kotlin
fun main() {
    val name = "Ada"
    println("Hello, $name")
}
```

Compile to JVM bytecode and run with Java.
Static type inference gives `name` the type `String`.

## Classes and instances

```kotlin
class Member(val id: Int, val name: String)

fun main() {
    val ada = Member(1, "Ada")
    println(ada.name)
}
```

Constructor properties become part of the instance API.

## val and var

```kotlin
val names = mutableListOf("Ada")
names.add("Ben")
// names = mutableListOf("Cara") // rejected
```

`val` prevents reassignment of the reference.
It does not make the referenced object immutable.

## Encapsulation

```kotlin
class Account(val limit: Int) {
    var activeLoans: Int = 0
        private set
    fun borrow(): Boolean {
        if (activeLoans >= limit) return false
        activeLoans += 1
        return true
    }
}
```

## Constructor validation

```kotlin
init {
    require(limit >= 0) { "limit must be nonnegative" }
}
```

Place this block inside `Account`.

Invalid input fails before a usable instance is returned.

## Returning a book

```kotlin
fun returnOne(): Boolean {
    if (activeLoans == 0) return false
    activeLoans -= 1
    return true
}
```

Boundary cases belong in the design and tests.

## Operation contracts

| Operation | Accepted case | Rejected case |
| --- | --- | --- |
| borrow | count increases by one | count stays unchanged |
| returnOne | count decreases by one | count stays unchanged |

The invariant holds after either result.

## Interfaces describe behavior

```kotlin
interface LoanPolicy {
    fun limit(): Int
}

class StandardPolicy : LoanPolicy {
    override fun limit() = 3
}
```

Clients can refer to `LoanPolicy`.

## Polymorphism through an interface

```kotlin
class ResearchPolicy : LoanPolicy {
    override fun limit() = 5
}

fun describe(policy: LoanPolicy): String =
    "Loan limit: ${policy.limit()}"
```

The selected implementation supplies the method behavior.

## Composition

```kotlin
class LibraryService(private val policy: LoanPolicy) {
    fun canBorrow(active: Int): Boolean {
        require(active >= 0)
        return active < policy.limit()
    }
}
```

A service **has a** policy.

## Inheritance

```kotlin
open class Item(val title: String) {
    open fun description() = title
}
class Book(title: String) : Item(title) {
    override fun description() = "Book: $title"
}
```

Kotlin classes and methods are final by default.

## Composition and inheritance

| Choice | Relationship | Typical concern |
| --- | --- | --- |
| composition | service has a policy | dependency contract |
| inheritance | book is an item | substitutability |

Reuse alone does not establish a sound subtype.

## Substitutability

A client that accepts a policy should not need
special cases for each valid implementation.

```kotlin
val policies: List<LoanPolicy> =
    listOf(StandardPolicy(), ResearchPolicy())
```

What assumptions may the client make?

## Identity and equality

```kotlin
val a = Member(1, "Ada")
val b = Member(1, "Ada")
println(a === b)
println(a == b)
```

With this ordinary class, both results are false.

## Aliasing and state

```kotlin
val first = Account(3)
val second = first
second.borrow()
println(first.activeLoans) // 1
```

Two references observe one object.

## Exposing internal data

```kotlin
private val loans = mutableListOf<Int>()
fun loanIds(): List<Int> = loans.toList()
```

A snapshot prevents clients from mutating this backing list.
Element objects may still be shared.

## OOP and functional design

```kotlin
fun available(ids: List<Int>, borrowed: Set<Int>) =
    ids.filter { it !in borrowed }
```

Pure computations can serve an encapsulated domain model.
Keep I/O and state changes visible at boundaries.

## Testing behavior

```kotlin
val account = Account(1)
check(account.borrow())
check(!account.borrow())
check(account.activeLoans == 1)
```

Tests distinguish a rejected operation from a corrupt state.

## Practical: a small domain model

[Week 9 lab](../../labs/week09/README.md)

- Implement an encapsulated account.
- Supply two policy implementations.
- Exercise composition through an interface.
- Test limits and rejected operations.
- Explain a state invariant and one design choice.

## Week 10 preview

How should the model represent:

- equal values with different identities;
- a missing member;
- several possible operation outcomes;
- reusable, type-safe collections?

## Further study

- [Kotlin classes](https://kotlinlang.org/docs/classes.html).
- [Interfaces](https://kotlinlang.org/docs/interfaces.html).
- [Inheritance](https://kotlinlang.org/docs/inheritance.html).
- [Equality](https://kotlinlang.org/docs/equality.html).
- Sebesta 12e Chapters 11–12: abstraction and OOP.

Exercise: replace a policy subtype hierarchy with composition.

## Further reading in Sebesta

Sebesta 12e §§11.1–11.3 and §§12.1–12.3. Kotlin syntax comes from official documentation.

## Next unit

Week 10 refines this model with data and sealed classes, nullability, generics and type inference.
