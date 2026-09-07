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

## About the course

Programming Languages examines how different languages express computation and how their design choices affect the programs we write. The course is **paradigm-first rather than language-first**: representative languages are used to explore different ways of organizing state, functions, inference, relations, objects, communication, and asynchronous events.

The objective is not to master seven languages in one semester. It is to develop the conceptual vocabulary and practical experience needed to learn unfamiliar languages, compare their strengths and limitations, and select an appropriate programming model for a problem.

The course begins with language design, history, syntax, semantics, and an imperative baseline. It then examines functional, logic, relational, object-oriented, concurrent, and event-driven programming. Modern languages are often multi-paradigm, so these categories are analytical tools rather than rigid classifications.

### Prerequisites

The course is intended for second- and third-year bachelor students who have completed introductory programming and Algorithms. Students should be comfortable with Python or another general-purpose language, including functions, collections, control flow, basic objects, and elementary debugging. BS0013 Data Structures with C++ is strongly recommended but may be taken concurrently; advanced C++ knowledge is not assumed at the start.

### Learning objectives

By the end of the course, students should be able to explain and compare programming-language constructs; read and write simple BNF/EBNF grammars; reason about types, scope, bindings, and evaluation; implement small programs in substantially different paradigms; and justify language and design choices using evidence from program behavior. Students must also be able to explain, test, modify, and defend their submitted code.

## Semester structure

The Fall 2026 course has 14 weeks, including a dedicated midterm week. The intended sequence is shown below; any timetable or assessment changes will be announced in Moodle.

| Week | Topic | Main language or focus |
| ---: | --- | --- |
| 1 | Language overview and imperative baseline | Python, C++, language history and implementation |
| 2 | Syntax, semantics, and parsing | BNF/EBNF, tokens, ASTs, tiny parser/interpreter |
| 3 | Functional Programming I | Clojure: functions, immutability, recursion |
| 4 | Functional Programming II | Clojure: persistent data, closures, composition, effects |
| 5 | Logic Programming I | Prolog: facts, rules, unification, backtracking |
| 6 | Logic Programming II | Prolog: recursion, search, constraints |
| 7 | Declarative / relational programming | SQL: relations, joins, aggregation, subqueries |
| 8 | Midterm and consolidation | Assessment of Weeks 1–7 |
| 9 | Object-Oriented Programming I | Kotlin: classes, interfaces, encapsulation, polymorphism |
| 10 | Object-Oriented Programming II / Type Systems | Kotlin: generics, nullability, data and sealed classes |
| 11 | Concurrency I | Go: goroutines, channels, message passing |
| 12 | Concurrency II | Go: worker pools, cancellation, coordination |
| 13 | Event-Driven Programming | JavaScript / TypeScript: events, callbacks, event loop |
| 14 | Asynchronous Programming and Synthesis | JavaScript / TypeScript: promises, async/await, comparison |

**Rust is optional supplementary material and is not part of the core curriculum.** JavaScript and TypeScript are intentionally covered at the end of the semester as the event-driven and asynchronous programming case study.

## Teaching and assessment

Each week normally combines a lecture, practical experimentation, and comparison with previously studied paradigms. Laboratory work may involve implementing a small program, modifying an existing example, debugging, or solving the same problem using a different computational model.

| Assessment component | Weight |
| --- | ---: |
| Programming assignments | 40% |
| Weekly quizzes and participation | 10% |
| Midterm examination | 20% |
| Comprehensive final examination component | 20% |
| Timed cumulative final quiz | 10% |
| **Total** | **100%** |

The midterm covers Weeks 1–7. The final assessment is cumulative, with particular emphasis on the second-half paradigms and comparative reasoning. Exact assignment specifications, deadlines, quiz rules, and submission requirements are published in Moodle. The full syllabus contains the detailed grading and code-defence provisions.

## Repository structure

This is the **public, student-facing repository**. It is populated progressively as the semester proceeds. The current repository contains the syllabus; lecture material, examples, laboratories, assignments, and development-environment configuration will be published as they become available.

The intended organization is:

```text
RBS_BS0030_Programming_Languages/
├── README.md                 # Course overview and navigation
├── LICENSE
├── syllabus/                 # Public syllabus
├── lectures/                 # Weekly student-facing lecture materials
│   ├── week01/
│   ├── week02/
│   └── ...
├── labs/                     # Practical exercises and starter code
│   ├── week01/
│   └── ...
├── assignments/              # Published assignment specifications
├── resources/                # Reading lists and supplementary resources
└── .devcontainer/            # Codespaces configuration, when published
```

The directory layout is a planned guide, not a claim that all folders already exist. Actual paths and instructions in each published unit take precedence. Instructor-only notes, assessment solutions, and unpublished question banks are not distributed through this repository.

## Development environment and getting started

**GitHub Codespaces is the official supported development and assessment environment.** It provides a browser-based Linux and VS Code environment, reducing operating-system-specific setup. The course will use language-specific runtimes and tools as required, including Python, C++, Clojure/JDK, SWI-Prolog, SQL tooling, Kotlin, Go, and Node.js/TypeScript.

The environment may use a common configuration or separate language-specific Codespaces when appropriate. Follow the instructions supplied for the relevant week; do not assume every language tool is already installed in a newly created Codespace.

For students beginning the course:

1. Read the [syllabus](syllabus/BS0030_Programming_Languages_Syllabus_Fall_2026.md) and check the course Moodle page for the current week's instructions.
2. Sign in to GitHub and create a fork of this public repository when instructed to do so.
3. Open the designated Codespace configuration and follow the weekly setup and practical-work instructions.
4. Keep your fork up to date with the instructor's repository and commit your own work regularly.
5. Submit work through Moodle in the format specified by each assignment. A GitHub commit or repository link alone is not a submission unless the assignment explicitly says so.

Local development is permitted, but local installation and configuration are the student's responsibility. Assessed code must run in the designated course environment. GitHub Codespaces usage limits and any applicable billing or education benefits should be checked in the student's own GitHub account.

## Reading and reference materials

The course's principal learning materials are the instructor's lectures, examples, practical tasks, and official language documentation. Students also have semester access through RBS/Pearson to Robert W. Sebesta, *Concepts of Programming Languages*, 12th edition. The book provides supplementary reading on language design, history, syntax and semantics, language constructs, and alternative paradigms. Global Edition pagination may differ, so readings will normally be identified by chapter or section.

No separate commercial textbook purchase is required. The Pearson text is available through the institution's licensed access and is not redistributed in this public repository.

Useful official and freely available references include:

- [Clojure](https://clojure.org/) and [ClojureDocs](https://clojuredocs.org/)
- [SWI-Prolog](https://www.swi-prolog.org/) and [Learn Prolog Now!](https://lpn.swi-prolog.org/lpnpage.php?pageid=online)
- [SQLite documentation](https://www.sqlite.org/docs.html)
- [Kotlin documentation](https://kotlinlang.org/docs/home.html)
- [Go documentation](https://go.dev/doc/)
- [MDN JavaScript guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide) and [TypeScript documentation](https://www.typescriptlang.org/docs/)
- [GitHub Codespaces documentation](https://docs.github.com/en/codespaces)

## Moodle and course communication

The RTU ORTUS Moodle course is the authoritative location for announcements, deadlines, quizzes, grades, and official submissions. This repository provides version-controlled student materials and code. If a repository description and a current Moodle announcement differ on an assessment requirement, follow the Moodle announcement and contact the instructor if clarification is needed.

Materials are released during the semester, so students should consult both Moodle and this repository regularly.
