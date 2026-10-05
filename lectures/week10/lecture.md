# Week 10: Object-Oriented Design and Type Systems

BS0030 Programming Languages, Fall 2026

## Continuity

Week 9 used encapsulated state, interfaces and composition to preserve domain invariants.

## Object-Oriented Design and Type Systems

Week 10, BS0030 Programming Languages

**Kotlin: values, absence, alternatives and generic code**

## Learning outcomes

- Distinguish inferred static types from dynamic typing.
- Represent absence with nullable types.
- Represent alternatives with a sealed hierarchy.
- Explain data-class equality and shallow copying.
- Use generics without weakening type guarantees.

## Type inference

```kotlin
val count = 3
// count = "three" // reassignment is also forbidden
var total = 3
// total = "three" // incompatible type
```

Both bindings have a statically inferred `Int` type.

## Types and domain validation

```kotlin
fun createLimit(n: Int): Int {
    require(n >= 0)
    return n
}
```

`Int` allows negative integers.
The lending domain adds a stronger condition.

## Nullable types

```kotlin
val name: String = "Ada"
val missing: String? = null
// println(missing.length) // rejected
```

`String?` permits a String value or null.

## Safe calls and defaults

```kotlin
val name: String? = null
val length: Int? = name?.length
val displayed: Int = name?.length ?: 0
```

The safe call propagates absence.
The Elvis operator supplies a chosen fallback.

## Smart casts

```kotlin
fun lengthOrZero(value: String?): Int {
    if (value == null) return 0
    return value.length
}
```

The remaining path establishes a non-null value.

## The non-null assertion

```kotlin
val name: String? = null
// println(name!!.length) // throws at runtime
```

`!!` asserts a condition.
It does not establish that the condition is true.

## Data classes

```kotlin
data class Member(val id: Int, val name: String)
val a = Member(1, "Ada")
val b = Member(1, "Ada")
```

`a == b` is true. `a === b` is false.

## Copying is shallow

```kotlin
data class Basket(val ids: MutableList<Int>)
val a = Basket(mutableListOf(1))
val b = a.copy()
b.ids.add(2)
println(a.ids) // [1, 2]
```

## Value updates

```kotlin
data class Member(val id: Int, val name: String)
val original = Member(1, "Ada")
val renamed = original.copy(name = "Ada L.")
```

The original value remains available.

## Sealed alternatives

```kotlin
sealed interface BorrowResult
data class Granted(val loanId: Int) : BorrowResult
data class Rejected(val reason: String) : BorrowResult
```

The hierarchy declares the permitted direct alternatives.

## Exhaustive handling

```kotlin
fun message(result: BorrowResult): String =
    when (result) {
        is Granted -> "Loan ${result.loanId}"
        is Rejected -> result.reason
    }
```

The expression handles every declared alternative.

## Invalid state combinations

```text
success: Boolean
loanId: Int?
error: String?
```

What does `success=true, loanId=null, error="denied"` mean?

Separate `Granted` and `Rejected` cases avoid this combination.

## Absence and failure

| Representation | Suitable meaning |
| --- | --- |
| `Member?` | lookup may find no member |
| sealed result | expected domain alternatives |
| exception | an operation cannot complete normally |

The choice is part of the API contract.

## Generic functions

```kotlin
fun <T> firstOrNull(items: List<T>): T? =
    if (items.isEmpty()) null else items[0]

val first: Int? = firstOrNull(listOf(10, 20))
```

Type parameters relate input and output types.

## Generic bounds

```kotlin
fun <T : Comparable<T>> larger(a: T, b: T): T =
    if (a >= b) a else b
```

The bound supplies the comparison capability.

## Mutable-container invariance

```kotlin
val numbers: MutableList<Int> = mutableListOf(1)
// val values: MutableList<Any> = numbers // rejected
```

If allowed, `values.add("oops")` would corrupt the Int list.

## Producer covariance

```kotlin
val numbers: List<Int> = listOf(1, 2)
val values: List<Any> = numbers
```

Kotlin's `List<out T>` permits this assignment.
Read-only access still does not prove deep immutability.

## Static guarantees and runtime checks

- Kotlin checks declared and inferred types before execution.
- JVM generic arguments are commonly erased.
- Unchecked casts can weaken guarantees.
- Domain invariants still require sound operations.

## A5 refactoring plan

1. Keep lending state behind operations.
2. Use data classes for stable values.
3. Return sealed operation outcomes.
4. Handle absence explicitly.
5. Test behavior through the public API.

## Comparing OOP and FP

An object can own state and validate operations.
A pure function can transform a value into another value.

For a lending request, compare:

- aliasing and mutation;
- test setup;
- failure representation;
- where the invariant lives.

## Concurrency preview

Two requests both read `activeLoans = 2` with a limit of 3.

Both decide to grant a loan.

What must prevent the combined state from exceeding the limit?

## Further study

- [Null safety](https://kotlinlang.org/docs/null-safety.html).
- [Data classes](https://kotlinlang.org/docs/data-classes.html).
- [Sealed classes](https://kotlinlang.org/docs/sealed-classes.html).
- [Generics](https://kotlinlang.org/docs/generics.html).
- Sebesta 12e §§6.12–6.15, §9.10 and §11.5.

Optional: Rust ownership as another response to aliasing.

## Further reading in Sebesta

Sebesta 12e §§6.12–6.15, §9.10, §11.5 and Chapter 12. Optional Rust enrichment is outside assessed core content.

## Next unit

Week 11 asks how independently executing computations coordinate, using Go goroutines and channels.
