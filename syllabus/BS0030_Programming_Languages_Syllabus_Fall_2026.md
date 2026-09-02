# BS0030 Programming Languages

**Programming paradigms through representative languages**

**Riga Technical University | Riga Business School**

Academic year 2026/2027 | Fall semester

| **Course code** | BS0030 |
| --- | --- |
| **Credit points** | 8 CP |
| **Language** | English |
| **Weekly format** | 2 academic hours lecture + 2 academic hours practical work |
| **Instructor** | Valdis Saulespurēns |

Syllabus version: 14 August 2026 (revised)

[Course repository](https://github.com/ValRCS/RBS_BS0030_Programming_Languages)

**Course focus: language design, syntax and semantics, programming paradigms, abstraction, concurrency, and comparative language reasoning.**

## 1. Course Overview

Programming Languages examines how programming languages embody different models of computation and different assumptions about how programs should be structured. The course begins with the general design of programming languages and then uses representative languages to study seven major programming approaches.

The course is paradigm-first rather than language-first. Students are not expected to become professional Clojure, Prolog, Kotlin, Go, SQL, or JavaScript/TypeScript developers in fourteen weeks. Instead, each language is used as a vehicle for learning a distinct way of representing computation, state, abstraction, search, communication, or events.

## 2. Course Positioning and Prerequisites

**Prerequisite expectation:** Completion of a first-year general programming course. Students should already understand variables, expressions, conditionals, loops, functions, collections, basic classes/objects, input/output, and elementary debugging.

**Algorithms background expected:** Students should already have taken an Algorithms course and should be comfortable with basic algorithmic reasoning and asymptotic complexity.

**Relationship to BS0013 Data Structures:** BS0013 Data Structures with C++ is strongly recommended. In the Fall 2026 offering the two courses may be taken concurrently, so BS0030 will not assume advanced C++ knowledge at the beginning of the semester.

**Programming-language background:** Prior experience may be in Python, Java, JavaScript, C#, C/C++, or another general-purpose language. Familiar languages are used as baselines when introducing unfamiliar paradigms.

## 3. Course Goals

- Develop a conceptual understanding of how programming languages define syntax, semantics, types, bindings, scope, evaluation, and execution.
- Expose students to seven major programming approaches and the different models of computation they encourage.
- Develop the ability to reformulate the same computational problem using imperative, functional, logic, relational, object-oriented, concurrent, and event-driven approaches.
- Teach students to enter unfamiliar programming languages efficiently by reading authoritative documentation and experimenting in small programs.
- Develop sound engineering judgment when selecting a language, paradigm, or programming model for a particular problem.

## 4. Learning Outcomes

After successfully completing the course, a student should be able to:

1. Distinguish programming-language syntax from semantics and explain the roles of lexing, parsing, abstract syntax trees, interpretation, and compilation.
2. Read and construct simple BNF/EBNF grammars and reason about ambiguity and syntactic structure.
3. Explain names, bindings, lexical scope, lifetime, mutability, evaluation strategy, and basic type-system concepts.
4. Compare static and dynamic typing and recognize common forms of type checking and type inference.
5. Explain the defining characteristics of imperative, functional, logic, declarative/relational, object-oriented, concurrent/message-passing, and event-driven/asynchronous programming.
6. Implement small programs in several substantially different programming languages and paradigms.
7. Reformulate a computational problem using different models of computation and compare the resulting solutions.
8. Recognize advantages and limitations of mutable state, immutable values, recursion, logical inference, relational queries, encapsulation, message passing, and asynchronous events.
9. Compare programming languages using programming-language concepts rather than surface syntax alone.
10. Select and justify an appropriate language or paradigm for a stated problem.
11. Read unfamiliar source code and acquire essential syntax from authoritative documentation and examples.
12. Explain, modify, test, and defend design decisions in submitted programs, including code developed with external assistance.

## 5. Teaching and Learning Format

**Semester structure:** 14 weeks: 13 instructional units plus one dedicated midterm/assessment week.

**Typical weekly pattern:** 2 academic hours of lecture followed by 2 academic hours of practical programming work.

The course uses a concept-to-experiment cycle:

- Lecture: computational model, language-design concepts, representative syntax, semantics, and examples.
- Practical: students implement, modify, debug, or compare programs in the representative language.
- Comparison: the new paradigm is related to familiar imperative programming and to previously studied approaches.
- Reflection: students identify what the language makes easy, what it makes difficult, and which trade-offs follow from its design.

**Recurring analytical pattern:** problem → programming model → language constructs → implementation → observed behavior → comparison → engineering choice.

## 6. Weekly Course Plan

The schedule below is the intended Fall 2026 course sequence. Small adjustments may be made based on cohort progress, public holidays, or timetable constraints; any changes will be announced in Moodle.

| **Week** | **Instructional Unit** | **Lecture Focus** | **Practical Focus** |
| --- | --- | --- | --- |
| 1 | Language Overview and Imperative Baseline | Language vs implementation; compilation/interpreting/VMs; history; paradigms; imperative baseline. | Compare the same program in C++, Python, and JavaScript. |
| 2 | Syntax, Semantics, and Parsing | Tokens; BNF/EBNF; ASTs; ambiguity; parsing; semantics; scope; types. | Tiny expression grammar plus parser/interpreter. |
| 3 | Functional Programming I | Clojure/Lisp; pure and higher-order functions; immutability; recursion; map/filter/reduce. | REPL: collections, functions, and recursion. |
| 4 | Functional Programming II | Persistent data; closures; composition; laziness; effects; functional vs imperative design. | Functional data-processing task. |
| 5 | Logic Programming I | Facts, rules, queries; unification; resolution; backtracking; relations. | Knowledge-base and recursive-query exercises. |
| 6 | Logic Programming II | Lists; recursive predicates; search; negation/cut; constraints. | Graph coloring, N-Queens, scheduling, or similar. |
| 7 | SQL / Relational Programming | Relations; sets; SELECT/WHERE/JOIN/GROUP BY; aggregation; subqueries. | Query a realistic relational dataset. |
| 8 | MIDTERM / ASSESSMENT | Midterm on Weeks 1-7; no major new paradigm. | Individual assessment; SQL consolidation and review. |
| 9 | Object-Oriented Programming I | Kotlin; classes; encapsulation; interfaces; polymorphism; composition. | Small Kotlin domain model. |
| 10 | Object-Oriented II / Type Systems | Data/sealed classes; generics; nullability; typing/inference; OOP vs FP. | Refactor procedural code into OOP. |
| 11 | Concurrency I | Go; concurrency vs parallelism; races/deadlock; message passing; CSP. | Goroutines, channels, workers, pipelines. |
| 12 | Concurrency II | Buffered channels; select; worker pools; cancellation; coordination. | Concurrent vs sequential data-processing task. |
| 13 | Event-Driven Programming | JavaScript/TypeScript; events; callbacks; event loop; async I/O; inversion of control. | Small browser or Node.js event-driven app. |
| 14 | Asynchronous Programming / Synthesis | Promises; async/await; errors; reactive intuition; paradigm synthesis. | Complete async app and compare paradigms. |

## 7. Programming Paradigms as a Vertical Theme

The seven approaches are revisited comparatively throughout the semester. The categories are intentionally simplified: modern languages are often multi-paradigm, and recognizing overlap is itself a learning objective.

| **Approach** | **Primary language** | **View of computation** | **Recurring trade-off** |
| --- | --- | --- | --- |
| Imperative / procedural | C++ / Python | Computation as an ordered sequence of state changes | Direct control and familiarity vs pervasive mutable state |
| Functional | Clojure | Computation through expressions, functions, and immutable values | Composability and reasoning vs unfamiliar recursion/data flow |
| Logic | Prolog | Computation as inference over facts, rules, and relations | Concise search/specification vs operational behavior can be non-obvious |
| Declarative / relational | SQL | Describe the desired result over relations rather than an explicit procedure | Set-oriented expressiveness vs reduced procedural control |
| Object-oriented | Kotlin | Computation organized around objects, interfaces, and encapsulated state | Modularity and polymorphism vs hierarchy/state complexity |
| Concurrent / message-passing | Go | Independent computations coordinate through communication | Clear coordination patterns vs concurrency hazards and scheduling complexity |
| Event-driven / asynchronous | JavaScript / TypeScript | Computation organized around events and deferred/asynchronous work | Responsive I/O-oriented design vs non-linear control flow |

## 8. Practical Work and Programming Assignments

Practical sessions are workshops rather than secondary lectures. Most sessions begin with a concise task briefing and examples, followed by individual implementation work and a short review/comparison period.

Where appropriate, practical tasks may be offered in three levels:

- **Core:** minimum functionality that demonstrates the central programming-language concept.
- **Standard:** the expected complete solution for the unit.
- **Extension:** optional or bonus work involving deeper language features, additional comparison, larger inputs, or alternative implementations.

The assignment portfolio is expected to include:

| **Assignment** | **Topic** | **Weight** |
| --- | --- | ---: |
| A1 | Tiny Language: grammar/parser/interpreter | 5% |
| A2 | Functional Data Processing in Clojure | 7% |
| A3 | Logic and Constraint Problem in Prolog | 7% |
| A4 | Relational Querying in SQL | 5% |
| A5 | Object-Oriented Design in Kotlin | 6% |
| A6 | Concurrent Pipeline in Go | 5% |
| A7 | Event-Driven / Asynchronous Application | 5% |

Exact assignment specifications, deadlines, point values, and submission instructions will be published in Moodle. Programming assignments account for 40% of the final course grade. Weekly quizzes and participation account for an additional 10%, bringing the total coursework component to 50%.

## 9. Assessment and Grading

The grading structure preserves the overall 50% coursework, 20% midterm, and 30% final-assessment framework. The coursework and final components are subdivided as shown below.

| **Assessment component** | **Weight** | **Primary evidence** |
| --- | ---: | --- |
| Programming assignments | 40% | Implementation, testing, paradigm-specific design, explanations, and practical portfolio |
| Weekly quizzes and participation | 10% | Short cumulative knowledge checks and active participation in instructional/practical work |
| Midterm examination | 20% | Weeks 1-7: language design, syntax/semantics, functional, logic, SQL, code reading, and comparative reasoning |
| Final examination - comprehensive component | 20% | Cumulative understanding with emphasis on second-half paradigms, comparison, explanation, modification, and synthesis |
| Final examination - timed cumulative quiz | 10% | Strictly time-limited cumulative quiz based substantially on the semester quiz question set; graded on a curve |
| **Total** | **100%** | |

### 9.1 Weekly Quizzes and Participation

Weekly quizzes and participation account for 10% of the final course grade. Short quizzes reinforce terminology, language constructs, program behavior, type/scope concepts, and comparisons among paradigms. Participation may include active engagement in practical tasks and brief in-class checks.

The weekly quiz questions also form the basis of the cumulative timed quiz included in the final examination. Exact quiz timing and participation procedures will be published in Moodle.

### 9.2 Midterm

Week 8 is reserved for the midterm and does not introduce a major new paradigm. The midterm is expected to combine:

- short reasoning questions about syntax, semantics, types, scope, and programming paradigms;
- code reading, output prediction, debugging, or completion;
- a grammar/parsing or language-design exercise;
- small practical questions in one or more first-half languages;
- a comparison question requiring justification.

### 9.3 Final Examination

The final examination accounts for 30% of the final course grade and is cumulative. It consists of two components:

- **Comprehensive final component (20% of the course grade):** emphasizes demonstrated understanding across paradigms. Students may be asked to explain a submitted program, predict behavior, modify code, compare implementations, or justify a programming-model choice.
- **Timed cumulative quiz (10% of the course grade):** a strictly time-limited speed quiz covering the full set of quiz concepts used during the semester. This component is graded on a curve based on cohort performance.

The timed cumulative quiz therefore represents one-third of the final-assessment grade.

### 9.4 Code Defence / Show-and-Tell

Selected programming work may be discussed individually near the end of the course. Students may begin with a submission they consider representative of their best work, but the instructor may ask about other submitted assignments. A student must be able to explain significant language features, paradigm-specific design choices, control flow, data representation, and relevant implementation details.

## 10. Official Development Environment: GitHub Codespaces

GitHub Codespaces is the official supported development and assessment environment for the course. The new BS0030 course repository will be populated progressively with lecture notes, examples, practical work, assignments, and environment configuration. The intention is to give students a consistent browser-based Linux/VS Code environment and minimize time lost to operating-system-specific setup.

The reference environment is expected to include, as course units require:

- Visual Studio Code, Git, and GitHub integration;
- C++ and Python for familiar imperative baseline examples;
- Java/JDK and Clojure tooling for functional programming;
- SWI-Prolog for logic programming;
- SQLite, with PostgreSQL-compatible SQL where useful, for relational programming;
- Kotlin tooling for object-oriented examples;
- the Go toolchain for concurrency and message passing;
- Node.js, JavaScript, TypeScript, and browser developer tools for event-driven/asynchronous programming;
- repository-specific dev-container configuration where practical.

Browser-based playgrounds, notebooks, and REPLs may also be used for short exercises when they provide a faster or more appropriate environment than a full Codespace.

Local development is permitted but not officially supported. Students may use suitable local editors, IDEs, language runtimes, WSL, Linux, macOS, or Windows installations on their own computers. Local installation and configuration problems are the student's responsibility, and assessed code must run correctly in the designated course environment.

## 11. Coding and Submission Expectations

Submitted work should:

- run in the designated course environment without avoidable errors;
- use the language and toolchain specified for the assignment;
- use meaningful names and coherent decomposition;
- demonstrate the programming paradigm or language concept that the assignment is intended to assess;
- include tests, examples, or evidence of testing when requested;
- use Git/GitHub workflows where required by the assignment;
- follow assignment-specific restrictions on libraries, external code, collaboration, and generative AI;
- be explainable, debuggable, and modifiable by the student during a code defence.

**Paradigm assignments versus application assignments:** When the purpose is to experience a programming model, using an alternative paradigm or a library that bypasses the intended concept may be prohibited. When the purpose is to solve an application problem, appropriate standard libraries are generally encouraged. The pedagogical principle is: first experience the model directly; then learn where it is appropriate to abstract it away.

## 12. Core Materials and Learning Resources

No student is required to purchase a commercial textbook. Instructor notes, examples, notebooks, and assignment specifications in Moodle and the course repository provide the course spine. Official language documentation and selected free/open resources provide the principal reference material.

**Canonical course repository:** [RBS_BS0030_Programming_Languages](https://github.com/ValRCS/RBS_BS0030_Programming_Languages). It will be filled with materials as the course proceeds.

### 12.1 Language Design, Grammars, and Parsing

- [ANTLR Documentation - Grammars](https://github.com/antlr/antlr4/blob/master/doc/grammars.md): Grammar notation and parser-construction reference.
- [ANTLR v4 Documentation](https://github.com/antlr/antlr4/blob/master/doc/index.md): Parser-generator documentation and examples.
- [RFC 5234: Augmented BNF](https://www.rfc-editor.org/rfc/rfc5234): Formal ABNF reference useful when comparing grammar notations.

### 12.2 Functional Programming - Clojure

- [Clojure Official Website](https://clojure.org/): Language documentation, guides, reference, and ecosystem material.
- [ClojureDocs](https://clojuredocs.org/): Function-oriented documentation with practical examples.
- [Clojure - Learn](https://clojure.org/guides/getting_started): Official getting-started and learning material.

### 12.3 Logic Programming - Prolog

- [SWI-Prolog](https://www.swi-prolog.org/): Primary Prolog implementation used in the course.
- [SWI-Prolog Manual](https://www.swi-prolog.org/pldoc/doc_for?object=manual): Language and library reference.
- [Learn Prolog Now!](https://lpn.swi-prolog.org/lpnpage.php?pageid=online): Free introductory Prolog textbook and exercises.

### 12.4 Declarative / Relational Programming - SQL

- [SQLite Documentation](https://www.sqlite.org/docs.html): Core SQLite documentation and SQL reference.
- [PostgreSQL Documentation](https://www.postgresql.org/docs/): Authoritative reference for PostgreSQL and standard SQL concepts.
- [SQLZoo](https://sqlzoo.net/wiki/SQL_Tutorial): Interactive SQL exercises for practice.

### 12.5 Object-Oriented Programming - Kotlin

- [Kotlin Documentation](https://kotlinlang.org/docs/home.html): Official language documentation and learning resources.
- [Kotlin Playground](https://play.kotlinlang.org/): Browser-based environment for running and experimenting with Kotlin.
- [Kotlin Language Specification](https://kotlinlang.org/spec/): Formal language reference for deeper questions.

### 12.6 Concurrency and Message Passing - Go

- [The Go Programming Language](https://go.dev/): Official Go site, documentation, downloads, and learning material.
- [A Tour of Go](https://go.dev/tour/): Official interactive introduction to Go.
- [Effective Go](https://go.dev/doc/effective_go): Official guidance on idiomatic Go programming.
- [Go by Example](https://gobyexample.com/): Concise executable examples covering common Go features.

### 12.7 Event-Driven and Asynchronous Programming - JavaScript / TypeScript

- [MDN JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide): Comprehensive guide to modern JavaScript language features.
- [MDN - Using Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises): Core reference for Promise-based asynchronous programming.
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html): Official guide to TypeScript types, functions, objects, generics, classes, and modules.
- [TypeScript Playground](https://www.typescriptlang.org/play): Browser environment for experimenting with TypeScript and generated JavaScript.
- [Node.js Learn - Asynchronous Work](https://nodejs.org/en/learn/asynchronous-work): Official Node.js material on the event loop and asynchronous execution.

### 12.8 Cloud Development and Source Control

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces): Creating and using browser-based development environments.
- [GitHub Docs - Introduction to dev containers](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/introduction-to-dev-containers): Repository-specific development-environment configuration.
- [Git Documentation](https://git-scm.com/doc): Reference for Git commands and concepts.

### 12.9 Optional Enrichment - Rust

Rust is not part of the seven core programming approaches in this version of the course. It may be used as an optional case study in ownership, borrowing, memory safety, type systems, traits, and systems programming.

- **[Optional]** [The Rust Programming Language](https://doc.rust-lang.org/book/): Official free Rust book.
- **[Optional]** [Rust by Example](https://doc.rust-lang.org/rust-by-example/): Executable examples covering Rust language features.
- **[Optional]** [Rustlings](https://github.com/rust-lang/rustlings): Small exercises for learning Rust interactively.

## 13. Generative AI, External Assistance, and Academic Integrity

Modern programming tools, including generative AI systems, can be useful for explanation, experimentation, debugging, and learning unfamiliar syntax. Their use does not remove the requirement that assessed work demonstrate the student's own understanding.

Unless an individual assignment states stricter rules:

- AI tools may be used for learning, explanation, brainstorming, and debugging during formative/practical work.
- Students remain fully responsible for every submitted line of code and every written claim.
- Substantial AI-generated or externally obtained code should be disclosed when requested by the assignment.
- Students must be able to explain, debug, modify, and extend submitted work during a code defence.
- Copying another student's assessed solution or submitting work that the student cannot explain is not acceptable.
- During supervised midterm/final assessments, external AI assistance is not permitted unless the assessment instructions explicitly allow it.

Collaboration on concepts is encouraged. Collaboration on assessed implementation is subject to the rules stated for each assignment. When in doubt, students should ask before sharing code.

## 14. Moodle, Repository, Communication, and Course Changes

**Moodle:** is the authoritative location for weekly materials, assignment statements, deadlines, grades, announcements, and assessment instructions.

**GitHub repository:** contains course code examples, notebooks, environment configuration, starter code, datasets, and selected supporting files. The new BS0030 repository is the canonical repository for the Fall 2026 course.

**Codespaces:** is the official supported coding environment for practical work and programming assessments, supplemented by language-specific playgrounds or notebooks where announced.

**Course adjustments:** may be made when necessary to account for cohort progress, technical issues, calendar changes, or pedagogical needs. Material changes will be announced in Moodle.

**Course repository:** https://github.com/ValRCS/RBS_BS0030_Programming_Languages

## 15. Course-at-a-Glance

| **Dimension** | **BS0030 approach** |
| --- | --- |
| Primary emphasis | Programming-language design and comparative understanding of seven major programming approaches |
| Prior programming | General first-year programming course; Algorithms expected; BS0013 Data Structures recommended and may be taken concurrently |
| Instructional structure | 13 instructional units + Week 8 midterm |
| Weekly delivery | 2 academic hours lecture + 2 academic hours practical |
| Core approaches | Imperative/procedural, functional, logic, declarative/relational, object-oriented, concurrent/message-passing, event-driven/asynchronous |
| Representative languages | C++/Python, Clojure, Prolog, SQL, Kotlin, Go, JavaScript/TypeScript |
| Official environment | GitHub Codespaces / Linux / VS Code, supplemented by selected browser playgrounds |
| Local environments | Permitted but not officially supported |
| Assessment | Programming assignments 40%; weekly quizzes/participation 10%; midterm 20%; final comprehensive component 20%; final timed cumulative quiz 10% |
| Canonical repository | RBS_BS0030_Programming_Languages |
| Commercial text purchase | Not required |
| Optional enrichment | Rust, ownership/borrowing, deeper type systems, DSLs, WebAssembly, actors, reactive programming, and related topics |

## 16. Administrative and Technical References

Course repository: [RBS_BS0030_Programming_Languages](https://github.com/ValRCS/RBS_BS0030_Programming_Languages)

GitHub Codespaces development-container documentation: [Introduction to dev containers](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/introduction-to-dev-containers)

This syllabus is the proposed teaching implementation for the Fall 2026 delivery of BS0030. The approved RTU course catalogue remains authoritative for formal course status and credit points; this syllabus specifies the planned prerequisite expectations, detailed grading breakdown, teaching organization, development environment, and assessment implementation for this offering.
