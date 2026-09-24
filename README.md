# BS0030 Programming Languages

**Programming paradigms through representative languages**

Riga Business School · Riga Technical University (RTU)

| | |
| --- | --- |
| **Course** | BS0030 Programming Languages |
| **Academic year** | 2026/2027, Fall semester |
| **Credit points** | 8 CP |
| **Language of instruction** | English |
| **Weekly format** | 2 academic hours of lecture + 2 academic hours of practical work |
| **Instructor** | Valdis Saulespurens, Lecturer, RTU |
| **Contact** | [valdis.saulespurens@rtu.lv](mailto:valdis.saulespurens@rtu.lv) |

[Full course syllabus](syllabus/BS0030_Programming_Languages_Syllabus_Fall_2026.md)

## Current practical work

### Week 4 — Functional Programming II: Clojure

Week 4 completes the functional-programming block and is the assessed **A2: Functional Data Processing in Clojure (7%)**. The practical develops one coherent vector-of-maps program using persistent immutable updates, closures, `comp`, `->>`, aggregation, lazy sequence observation, and a functional-core / effectful-shell design.

➡️ **[Open the Week 4 Lab / A2](labs/week04/README.md)**

The lab uses the **BS0030 Functional — Clojure** GitHub Codespace and pins Clojure to **1.12.6**.

Previous practical:

- [Week 3 — Functional Programming I: Clojure](labs/week03/README.md)
- [Week 2 — Syntax, BNF/EBNF, Parsing, and ASTs](labs/week02/README.md)

## Start here: fork once, use your fork all semester

GitHub Codespaces is the officially supported development environment for BS0030.

The course workflow is:

```text
PUBLIC COURSE REPOSITORY
        ↓
      Fork once
        ↓
YOUR-GITHUB-USERNAME/RBS_BS0030_Programming_Languages
        ↓
Create Codespace from YOUR fork
        ↓
Select the environment required for the current week
        ↓
Complete the lab in your fork
        ↓
Commit and push your work
        ↓
Sync new instructor material into the same fork later
```

> **Codespace = disposable language laboratory.**  
> **GitHub fork = permanent course portfolio.**

### Setup for Week 4

If you already created your fork earlier in the course, **keep using the same fork**. First use **Sync fork** / **Update branch** on GitHub so that your fork contains the new Week 4 material.

1. Open **your fork**, not the original `ValRCS` repository.
2. Create a new Codespace for your fork, or reuse/rebuild an existing Codespace with the functional configuration.
3. Select the **BS0030 Functional — Clojure** Dev Container configuration.
4. Wait for VS Code in the browser to finish building the environment.
5. In the terminal, from the repository root, run:

```bash
bash scripts/check-functional-environment.sh
```

6. Continue with the [Week 4 Lab / A2](labs/week04/README.md).

The functional container includes Java, the Clojure CLI, Git, and the Calva VS Code extension. The command-line Clojure REPL remains the reference environment for the lab.

Local development is allowed, but local setup is the student's responsibility. Assessed code must run in the designated course Codespace.

## Keeping your fork up to date

New lecture material, labs, and environment configurations will be added to the public repository during the semester.

Before starting a newly released week:

1. open your fork on GitHub;
2. use **Sync fork** / **Update branch** to bring in upstream course changes;
3. resolve any conflicts before beginning new work;
4. open or rebuild the Codespace required for that week's language environment.

To reduce conflicts, course-provided files and student-owned files are separated where practical. In Week 4:

```text
Course-provided:
labs/week04/README.md
labs/week04/assignment.md
labs/week04/deps.edn
labs/week04/starter/

Student-managed:
labs/week04/work/
```

Copy the Week 4 starter file into `work/` once, then make your changes only in the working copy. Do not edit the course-provided starter file unless the lab explicitly tells you to do so.

## About the course

Programming Languages examines how different languages express computation and how their design choices affect the programs we write. The course is **paradigm-first rather than language-first**: representative languages are used to explore different ways of organizing state, functions, inference, relations, objects, communication, and asynchronous events.

The objective is not to master seven languages in one semester. It is to develop the conceptual vocabulary and practical experience needed to learn unfamiliar languages, compare their strengths and limitations, and select an appropriate programming model for a problem.

The course begins with language design, history, syntax, semantics, and an imperative baseline. It then examines functional, logic, relational, object-oriented, concurrent, and event-driven programming.

### Prerequisites

The course is intended for second- and third-year bachelor students who have completed introductory programming and Algorithms. Students should be comfortable with Python or another general-purpose language, including functions, collections, control flow, basic objects, and elementary debugging. BS0013 Data Structures with C++ is strongly recommended but may be taken concurrently.

### Learning objectives

By the end of the course, students should be able to explain and compare programming-language constructs; read and write simple BNF/EBNF grammars; reason about types, scope, bindings, and evaluation; implement small programs in substantially different paradigms; and justify language and design choices using evidence from program behavior.

## Semester structure and estimated schedule

| Week | Date (Monday) | Topic | Main language or focus |
| ---: | --- | --- | --- |
| 1 | 7 September 2026 | Language overview and imperative baseline | Python, C++, language history and implementation |
| 2 | 14 September 2026 | Syntax, semantics, and parsing | BNF/EBNF, tokens, ASTs, tiny parser/interpreter |
| 3 | 21 September 2026 | Functional Programming I | Clojure: functions, immutability, recursion |
| 4 | 28 September 2026 | Functional Programming II | Clojure: persistent data, closures, composition, effects |
| 5 | 5 October 2026 | Logic Programming I | Prolog: facts, rules, unification, backtracking |
| 6 | 12 October 2026 | Logic Programming II | Prolog: recursion, search, constraints |
| 7 | 19 October 2026 | Declarative / relational programming | SQL: relations, joins, aggregation, subqueries |
| **8** | **26 October 2026** | **Midterm and consolidation** | **Assessment of Weeks 1–7** |
| 9 | 2 November 2026 | Object-Oriented Programming I | Kotlin: classes, interfaces, encapsulation, polymorphism |
| 10 | 9 November 2026 | Object-Oriented Programming II / Type Systems | Kotlin: generics, nullability, data and sealed classes |
| 11 | 16 November 2026 | Concurrency I | Go: goroutines, channels, message passing |
| 12 | 23 November 2026 | Concurrency II | Go: worker pools, cancellation, coordination |
| 13 | 30 November 2026 | Event-Driven Programming | JavaScript / TypeScript: events, callbacks, event loop |
| 14 | 7 December 2026 | Asynchronous Programming and Synthesis | JavaScript / TypeScript: promises, async/await, comparison |

**Rust is optional supplementary material and is not part of the core curriculum.**

## Development environments

The repository uses several Dev Container configurations during the semester rather than one oversized environment containing every language.

Currently published environments are:

```text
.devcontainer/
├── core/
│   ├── Dockerfile
│   └── devcontainer.json
└── functional/
    ├── Dockerfile
    └── devcontainer.json
```

**Core** is used for Week 2 and supports Python, C/C++, Node.js, Git, and SQLite.

**Functional** is used for Weeks 3–4 and provides Java, the Clojure CLI, Git, and Calva. Weeks 3 and 4 each pin Clojure **1.12.6** in their respective `deps.edn` files.

Later paradigm blocks will add their own environments for Prolog, Kotlin, Go, and JavaScript/TypeScript.

Students keep the same GitHub fork even when they create a new Codespace for a different language block.

## Repository structure

```text
RBS_BS0030_Programming_Languages/
├── README.md
├── LICENSE
├── syllabus/
├── .devcontainer/
│   ├── core/
│   └── functional/
├── scripts/
│   ├── check-core-environment.sh
│   └── check-functional-environment.sh
├── lectures/
├── labs/
│   ├── week02/
│   │   ├── README.md
│   │   ├── assignment.md
│   │   ├── grammar-exercises.md
│   │   ├── examples/
│   │   ├── starter/
│   │   └── work/
│   ├── week03/
│   │   ├── README.md
│   │   ├── assignment.md
│   │   ├── deps.edn
│   │   ├── starter/
│   │   └── work/
│   └── week04/
│       ├── README.md
│       ├── assignment.md
│       ├── deps.edn
│       ├── starter/
│       └── work/
├── assignments/
└── resources/
```

Materials are released progressively during the semester.

## Teaching and assessment

Each week normally combines a lecture, practical experimentation, and comparison with previously studied paradigms.

| Assessment component | Weight |
| --- | ---: |
| Programming assignments | 40% |
| Weekly quizzes and participation | 10% |
| Midterm examination | 20% |
| Comprehensive final examination component | 20% |
| Timed cumulative final quiz | 10% |
| **Total** | **100%** |

Moodle is the authoritative location for announcements, deadlines, quizzes, grades, and official submissions. A GitHub commit or repository link alone is not an official submission unless the assignment explicitly says so.

## Reading and reference materials

Students have semester access through RBS/Pearson to Robert W. Sebesta, *Concepts of Programming Languages*, 12th edition. Global Edition pagination may differ, so readings will normally be identified by chapter or section.

Useful official references include:

- [Clojure](https://clojure.org/) and [ClojureDocs](https://clojuredocs.org/)
- [SWI-Prolog](https://www.swi-prolog.org/)
- [SQLite documentation](https://www.sqlite.org/docs.html)
- [Kotlin documentation](https://kotlinlang.org/docs/home.html)
- [Go documentation](https://go.dev/doc/)
- [MDN JavaScript guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)
- [TypeScript documentation](https://www.typescriptlang.org/docs/)
- [GitHub Codespaces documentation](https://docs.github.com/en/codespaces)

## Moodle and course communication

The RTU ORTUS Moodle course is authoritative for announcements, deadlines, quizzes, grades, and official submissions. This repository provides version-controlled student materials and code.

If a repository description and a current Moodle announcement differ on an assessment requirement, follow the Moodle announcement and contact the instructor if clarification is needed.
