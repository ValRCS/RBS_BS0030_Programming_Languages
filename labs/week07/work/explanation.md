A4 Explanation

Run everything from labs/week07 with sh work/run.sh. It builds fresh databases from setup.sql (and fixture2.sql for the second fixture) and runs answers.sql. Output is saved in work/output.txt. Do not commit the .db files.

"Active loan" means loan.returned = 0. The core fixture has 3 members, 4 books and 4 loans, of which 3 are active (Ada: Algorithms and Poems, Ben: Algorithms).

Result grain (one row per what?)
Q1a: one row per computing book. Q1b: one row per distinct category.
Q2: one row per active loan, so Ada appears twice because she has two active loans.
Q3: one row per member. Q4: one row per member with no active loan.
Q5: one row per book that has at least two active loans.
Zero counts and the outer-join filter trap

Q3 uses member LEFT JOIN loan ON l.member_id = m.id AND l.returned = 0. LEFT JOIN keeps every member even if no loan matches, and then COUNT(l.id) counts only real loans, so Cara gets 0. I count l.id instead of * because for Cara the join produces one row with NULL loan columns, and COUNT(*) would wrongly give 1.

The "active" test must be in the ON clause. If it is moved to WHERE l.returned = 0, Cara's row has l.returned = NULL, the WHERE removes it, and she disappears (the "Q3 bug" query in answers.sql). The LEFT JOIN then behaves like an inner join.

NOT EXISTS (Q4)

NOT EXISTS checks, for each member, whether any active loan row exists. Cara has none, so she is returned. It gives the same answer as the LEFT JOIN with count 0, but states the question directly.

Threshold report (Q5) and the second fixture

GROUP BY book with HAVING COUNT(*) >= 2 filters after grouping. WHERE returned = 0 runs first, so only active loans are counted. In the core fixture only Algorithms qualifies. In the second fixture (fixture2.sql) a new member Dev also borrows Poems, which Ada already has, so Poems also reaches 2 and appears in the report. Eve has only a returned loan, so she shows as 0 active and is not in the report.

Zero-match cases
Member with no active loans: Cara (core), Cara and Eve (second fixture).
Book with no active loans: Databases (its only loan is returned) and Stories (no loans). The extra "every book" query uses LEFT JOIN from book to show them with 0.
Duplicate semantics

The join in Q2 returns one row per loan, so a member with two active loans repeats. SELECT DISTINCT removes the repeated names. In the core fixture there are 3 join rows but 2 distinct members. COUNT(DISTINCT l.member_id) counts members, while COUNT(*) counts loans. This is the difference between counting loans and counting borrowers.

Relational versus imperative view

In SQL I describe which rows I want (for example members with no active loan) and the database decides how to find them. An imperative version would loop over members, loop over loans, and keep a flag.