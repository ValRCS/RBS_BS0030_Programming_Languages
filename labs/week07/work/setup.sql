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
 