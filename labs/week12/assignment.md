# A6: Concurrent Pipeline in Go

Course weight: **5%**. Local rubric: **100 points**. Deadline and submission procedure are announced in Moodle.

## Task and evidence

Use integer-square transformations or another equally small documented pure transformation. Sum or indexed results are acceptable if the output contract is explicit. Reject invalid worker counts. Do not rely on sleep for completion. No particular speedup is required. If cancelled, define partial-result behavior explicitly.

Submit working source, run instructions, result evidence and your explanation in the week work folder. The expected solution must run in the designated course environment and be explainable and modifiable in a code defence.

## Rubric

| Points | Criterion |
| ---: | --- |
| 20 | Correct results equivalent to a sequential baseline. |
| 20 | Fixed positive worker count and bounded channels. |
| 20 | Correct producer/worker/coordinator/collector lifecycle and closure ownership. |
| 20 | Cooperative cancellation on all blocking edges with complete shutdown. |
| 10 | Empty, single-worker, many-input and cancellation tests plus race-detector evidence. |
| 10 | Explain ordering, race versus deadlock, and a fair performance comparison. |

## Assistance and authorship

Follow the syllabus assistance policy and any stricter Moodle instructions. Disclose substantial external or AI-generated code when requested, and be able to explain every submitted part. Copying another student's assessed implementation is not permitted.
