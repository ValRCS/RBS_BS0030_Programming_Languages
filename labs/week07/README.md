# Week 7: Relational queries and A4

## Environment and portfolio

Use the **BS0030 Core** Codespace configuration from your existing student fork. Sync the fork before opening or rebuilding the appropriate environment. The Core container supports SQLite and Node; the Kotlin and Go configurations support Weeks 9–10 and 11–12 respectively.

From a terminal run:

```bash
sqlite3 --version
```

Commit your source and explanations under `labs/week07/work/`. Markdown code blocks below are the starter source: copy the indicated block into the named file, then edit your working copy. Generated jars, executable binaries and disposable database files are not submission evidence.

## Reproducible fixture

From the repository root, create `labs/week07/work/`. Save this block as `work/setup.sql` inside the week folder:

```sql
PRAGMA foreign_keys = ON;
CREATE TABLE member(id INTEGER PRIMARY KEY, name TEXT NOT NULL);
CREATE TABLE book(id INTEGER PRIMARY KEY, title TEXT NOT NULL, category TEXT NOT NULL);
CREATE TABLE loan(id INTEGER PRIMARY KEY,
  member_id INTEGER NOT NULL REFERENCES member(id),
  book_id INTEGER NOT NULL REFERENCES book(id),
  returned INTEGER NOT NULL CHECK(returned IN (0,1)));
INSERT INTO member VALUES (1,'Ada'),(2,'Ben'),(3,'Cara');
INSERT INTO book VALUES (1,'Algorithms','computing'),(2,'Poems','literature'),
  (3,'Databases','computing'),(4,'Stories','literature');
INSERT INTO loan VALUES (1,1,1,0),(2,1,2,0),(3,1,3,1),(4,2,1,0);
```

Create a fresh practice database:

```bash
cd labs/week07
mkdir -p work
sqlite3 work/library.db < work/setup.sql
sqlite3 -header -column work/library.db
```

Run setup only against a fresh database. For a reset use a new filename so that your existing answers stay intact. SQLite foreign-key enforcement is connection-local; enter `PRAGMA foreign_keys=ON;` when modifying the database in another connection.

## Workshop sequence (90 minutes)

1. **10 min:** draw keys and predict how many rows an active-loan join returns.
2. **15 min:** list computing titles in stable order and the distinct categories.
3. **20 min:** join active loans to member and book descriptions. Explain why Ada can appear twice.
4. **20 min:** report every member's active-loan count, including zero.
5. **15 min:** find members with no active loan using NOT EXISTS. Repair a WHERE-versus-ON bug.
6. **10 min:** explain one query in relational and imperative terms.

Save queries in `work/answers.sql` and reasoning in `work/explanation.md`. Predict before running; retain the observed output. A successful setup has 3 members, 4 books and 4 lending events.

## Core and extension

Core: queries 1–5 in the assignment and an explanation of zero counts. Standard: all A4 tasks. Extension: compare EXPLAIN QUERY PLAN before/after a relevant index without asserting that the index must always be chosen.


## Submission

Follow [the portfolio instructions](../../submission.md). For assessed work, include a commit link, reproducible run commands, tests or observed outputs, and a short explanation of the relevant programming model. Deadlines and final administrative rules come from Moodle.

## Lecture and next step

[Week 7 lecture](../../lectures/week07/lecture.md). Week 8 assesses Weeks 1–7. Practise tracing and explaining these models before beginning Kotlin in Week 9.
