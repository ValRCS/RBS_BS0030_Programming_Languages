-- A4 answers. Run against a database built from setup.sql:
--   sqlite3 -header -column work/library.db < work/answers.sql
-- "Active loan" means loan.returned = 0.
 
.print '--- Q1a: computing titles in stable order ---'
SELECT title
FROM book
WHERE category = 'computing'
ORDER BY title, id;
 
.print '--- Q1b: distinct categories ---'
SELECT DISTINCT category
FROM book
ORDER BY category;
 
.print '--- Q2: active loans with member name and book title ---'
SELECT m.name AS member, b.title AS book
FROM loan AS l
JOIN member AS m ON m.id = l.member_id
JOIN book   AS b ON b.id = l.book_id
WHERE l.returned = 0
ORDER BY m.name, b.title;
 
.print '--- Q3: every member with active-loan count (zero included) ---'
-- LEFT JOIN keeps members with no matching loan. The active condition is in
-- ON, not WHERE, so members with no active loan are not removed.
SELECT m.name AS member, COUNT(l.id) AS active_loans
FROM member AS m
LEFT JOIN loan AS l
       ON l.member_id = m.id AND l.returned = 0
GROUP BY m.id, m.name
ORDER BY m.name;
 
.print '--- Q3 bug (do not use): WHERE instead of ON drops Cara ---'
SELECT m.name AS member, COUNT(l.id) AS active_loans
FROM member AS m
LEFT JOIN loan AS l ON l.member_id = m.id
WHERE l.returned = 0
GROUP BY m.id, m.name
ORDER BY m.name;
 
.print '--- Q4: members with no active loan (NOT EXISTS) ---'
SELECT m.name AS member
FROM member AS m
WHERE NOT EXISTS (
  SELECT 1
  FROM loan AS l
  WHERE l.member_id = m.id AND l.returned = 0
)
ORDER BY m.name;
 
.print '--- Q5: books with at least two active loans ---'
SELECT b.title AS book, COUNT(*) AS active_loans
FROM book AS b
JOIN loan AS l ON l.book_id = b.id
WHERE l.returned = 0
GROUP BY b.id, b.title
HAVING COUNT(*) >= 2
ORDER BY b.title;
 
.print '--- Extra: every book with active count (zero-match book included) ---'
SELECT b.title AS book, COUNT(l.id) AS active_loans
FROM book AS b
LEFT JOIN loan AS l ON l.book_id = b.id AND l.returned = 0
GROUP BY b.id, b.title
ORDER BY b.title;
 
.print '--- Extra: duplicates. Ada appears twice in Q2; DISTINCT / COUNT DISTINCT ---'
SELECT DISTINCT m.name AS member
FROM loan AS l JOIN member AS m ON m.id = l.member_id
WHERE l.returned = 0
ORDER BY m.name;
 
SELECT COUNT(*) AS join_rows, COUNT(DISTINCT l.member_id) AS distinct_members
FROM loan AS l
WHERE l.returned = 0;