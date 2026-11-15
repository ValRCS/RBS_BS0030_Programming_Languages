# Week 1 — one algorithm, three languages

**BS0030 Programming Languages · Fall 2026**

This laboratory accompanies the lecture section “Baseline problem for comparison.” The same imperative algorithm is implemented in Python, C++, and JavaScript so that language mechanisms, rather than algorithmic differences, are the focus.

## Example and expected results

For the scores `72, 91, 84, 65, 88`, calculate the average and count the scores at least `80`.

- Sum: `400`
- Number of scores: `5`
- Average: `400 / 5 = 80`
- Scores at least 80: `91, 84, 88`, so the count is `3`

Python prints `80.0`; C++ and JavaScript print `80`. The numeric result is identical.

## Open your course Codespace

1. Fork the [public BS0030 course repository](https://github.com/ValRCS/RBS_BS0030_Programming_Languages) or use your existing semester fork.
2. Open **your fork** and create a Codespace using **BS0030 Core — Python, C++ and JavaScript**.
3. From the repository root, run `bash scripts/check-core-environment.sh` to verify tools. Use the separate `bash scripts/test-week01.sh` command to execute the demonstration examples.

Week 1 includes course orientation, optional language comparison and the Moodle reading/quiz activity. **The Moodle quiz, its answers and official deadlines are not in this repository.** Do not copy instructor-only material into your fork.

## Run each program

All commands below are executed from the repository root in the Codespace terminal.

### Python (CPython)

```bash
python3 labs/week01/examples/scores.py
```

Observe names, dynamic types, indentation, direct iteration, and floating-point division.

### C++ (GCC)

```bash
mkdir -p labs/week01/build
g++ -std=c++20 -Wall -Wextra -Wpedantic -g \
  labs/week01/examples/scores.cpp -o labs/week01/build/scores-gcc
./labs/week01/build/scores-gcc
```

The compiler translates source into a native executable. `static_cast<double>` makes the intended floating-point arithmetic explicit.

### C++ (Clang alternative)

```bash
clang++ -std=c++20 -Wall -Wextra -Wpedantic -g \
  labs/week01/examples/scores.cpp -o labs/week01/build/scores-clang
./labs/week01/build/scores-clang
```

This compiles the same source with a different C++ implementation. Comparing the compiler versions and diagnostics is optional.

### JavaScript (Node.js)

```bash
node labs/week01/examples/scores.js
```

Observe `let`, `const`, dynamic typing, template literals, and the distinction between ECMAScript and the Node.js host. The example does not require a browser or npm packages.

## Verify all examples

```bash
bash scripts/check-core-environment.sh
```

This checks the installed language tools and version pins; it does **not** run the example programs. To compile/run the examples and check their exact output:

```bash
bash scripts/test-week01.sh
```

The checks use only the supplied public examples and require Python, Node, GCC and Clang. No student solution files are involved.

## Compare the language mechanisms

In each of Python, C++ and JavaScript, the program initializes a sum and counter, visits each score, computes an average, and prints results. Compare language syntax and implementation while keeping the algorithm unchanged.

| Concept | Python | C++ | JavaScript |
| --- | --- | --- | --- |
| Collection | `list` | `std::vector<int>` | `Array` |
| Variable declarations | Names assigned values | Explicit `int` / `double` | `let` / `const` |
| Loop | `for ... in` | Range-based `for` | `for ... of` |
| Block structure | Indentation | Braces | Braces |
| Division | `/` | Explicit floating-point cast | `/` with Number values |
| Execution | CPython | Compile, link, run | Node.js / V8 |

The examples intentionally retain mutable accumulators and a loop. Do not replace them with `sum`, `reduce`, `filter`, or other abstractions until after the controlled comparison.

## Optional student practice

After the demonstration, copy the examples into `labs/week01/work/` and modify the copies. Do not edit the instructor-managed starter files when working in a fork.

Try changing the threshold from 80 to 90; predict and verify the count. Change one score, then explain how the total, average, and counter change. Finally, explain why `const scores` in JavaScript does not make the array immutable, and why removing `static_cast<double>` from the C++ average can change results for a non-integer average.

The complete files are **teaching demonstrations**, not answers to a graded programming assignment. Assessments are defined in Moodle.

## Source ownership

The examples and checks under this public lab are demonstration material. Do not modify them directly when working in your fork: copy them under `labs/week01/work/`. Keep assessed work under the student's work directories and check Moodle for the official formative quiz.

[Continue to Week 2](../week02/README.md).
