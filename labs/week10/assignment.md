# A5: Object-Oriented Design in Kotlin

Course weight: **6%**. Local rubric: **100 points**. Deadline and submission procedure are announced in Moodle.

## Task and evidence

Preserve the Week 9 model as a baseline. A successful borrow returns the new active count; a rejection explains the reason and leaves state unchanged. Policy limits stay nonnegative and constant for the account lifetime. Use local fixtures and check statements or a test framework. No database or UI framework is required.

Submit working source, run instructions, result evidence and your explanation in the week work folder. The expected solution must run in the designated course environment and be explainable and modifiable in a code defence.

## Rubric

| Points | Criterion |
| ---: | --- |
| 25 | Encapsulated lending count with valid construction and both operation boundaries. |
| 15 | Two policy implementations used through a common interface and composition. |
| 20 | Data-class values, nullable lookup and sealed operation outcomes handled exhaustively. |
| 20 | Executable boundary checks for limit, extra borrow, empty return and invalid construction. |
| 10 | A generic helper whose output type relates to its input type. |
| 10 | Compare procedural and OOP designs, explaining mutability, aliasing and one type guarantee. |

## Assistance and authorship

Follow the syllabus assistance policy and any stricter Moodle instructions. Disclose substantial external or AI-generated code when requested, and be able to explain every submitted part. Copying another student's assessed implementation is not permitted.
