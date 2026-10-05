# A3: Logic and Constraint Problem in Prolog

Course weight **7%**. Local rubric **100 points**. Use the logic Codespace and the Week 6 starter as your baseline. Deadlines and final submission rules come from Moodle.

## Required deliverable

Complete the Week 6 recursive-list and cycle-safe route exercises, then extend the existing three-task CLP(FD) scheduling model to four named tasks a,b,c,d in distinct slots 1..4. Require a before c, b not in slot 1, and d after b. Keep constraint posting separate from labeling and enumerate every solution for the finite model.

Submit `labs/week06/work/week06_lab.pl` plus an A3 extension file and explanation. If you define a second predicate called schedule, use a different arity or a distinct name to avoid confusing the starter's schedule/3. Include queries and observed outputs for multiple modes, a cyclic route and an unreachable destination. Explain negation as failure using an instantiated-versus-free-variable example. The N-Queens extension remains optional.

## Rubric

| Points | Criterion |
| ---: | --- |
| 20 | Recursive member and append relations in the requested modes |
| 20 | Cycle-safe route, path invariant and termination on the finite fixture |
| 25 | Correct four-task domains/constraints with complete labeled solutions |
| 15 | Separation and explanation of propagation versus enumeration |
| 10 | Reproducible queries, valid and impossible cases, and tests |
| 10 | Operational explanation of goal order, negation and one model trade-off |

Add an impossible scheduling constraint in a separate test query and demonstrate finite failure. Do not leave it in the working model. Follow the syllabus assistance policy; every submitted clause and explanation must be understandable and modifiable by its author.
