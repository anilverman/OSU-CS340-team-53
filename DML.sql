-- Group 53 Data Manipulation queries
-- The "@" prefix denotes a variable whose value will be determined by user input

-- CRUD queries for the Members table:

-- CREATE a new member
INSERT INTO Members (name, email, phone)
VALUES (@name, @email, @phone);

-- READ out members in the database
SELECT
  m.memberID AS "Member ID",
  m.name AS "Name",
  m.email AS "Email",
  m.phone AS "Phone Number" 
FROM Members AS m
ORDER BY "Name" ASC;

-- UPDATE an existing member
UPDATE Members 
SET name = @name,
  email = @email,
  phone = @phone
WHERE memberID = @memberID;

-- DELETE a member from the database
DELETE FROM Members 
WHERE memberID = @memberID;


-- CRUD queries for the Checkouts table:

-- CREATE a new checkout
INSERT INTO Checkouts (bookID, dueDate, isReturned, checkoutDate)
VALUES (@bookID, @dueDate, @isReturned, @checkoutDate);

-- READ out checkouts in the database
SELECT 
  c.checkoutID AS "Checkout ID",
  m.name AS "Checked Out By",
  b.title AS "Book Title",
  c.checkoutDate AS "Checkout Date",
  c.dueDate AS "Due Date",
  CASE
    WHEN c.isReturned = 1 THEN "Yes"
    ELSE "No"
  END AS "Returned?"
FROM Checkouts AS c
JOIN Members AS m ON m.memberID = c.memberID
JOIN Books AS b ON b.bookID = c.bookID
ORDER BY "Due Date" ASC, "Returned?" ASC;

-- UPDATE an existing checkout
UPDATE Checkouts 
SET memberID = @memberID,
  bookID = @bookID,
  dueDate = @dueDate,
  isReturned = @isReturned,
  checkoutDate = @checkoutDate
WHERE checkoutID = @checkoutID;

-- DELETE a checkout from the database
DELETE FROM Checkouts 
WHERE checkoutID = @checkoutID;


-- CRUD queries for the Reviews table:

-- CREATE a new review
INSERT INTO Reviews (rating, memberID, bookID)
VALUES (@rating, @memberID, @bookID);

-- READ out reviews in the database
SELECT
  r.reviewID AS "Review ID",
  b.title AS "Book Title",
  m.name AS "Reviewer",
  r.rating AS "Rating"
FROM Reviews AS r
JOIN Members AS m ON m.memberID = r.memberID
JOIN Books AS b ON b.bookID = r.bookID
ORDER BY "Review ID" ASC;

-- UPDATE an existing review
UPDATE Reviews 
SET rating = @rating,
  memberID = @memberID,
  bookID = @bookID
WHERE authorID = @authorID;

-- DELETE a review from the database
DELETE FROM Reviews 
WHERE reviewID = @reviewID;


-- CRUD queries for the Books table:

-- CREATE a new book
INSERT INTO Books (title, authorID, year, isbn)
VALUES (@title, @authorID, @year, @isbn);

-- READ out books in the database
WITH BGList (bookID, genres) AS (
	SELECT bg.bookID, GROUP_CONCAT(g.description SEPARATOR ", ")
    FROM Books_has_Genres AS bg
    JOIN Genres AS g ON bg.genreID = g.genreID
    GROUP BY bg.bookID
)
SELECT
  b.bookID AS "Book ID",
  b.title AS "Title",
  a.name AS "Author",
  bgl.genres AS "Genre(s)",
  b.year AS "Publishing Year",
  b.isbn AS "ISBN",
  CASE
    WHEN c.isReturned = 1 THEN "Yes"
    ELSE "No"
  END AS "Checked Out?"
FROM Books AS b
JOIN BGList AS bgl ON b.bookID = bgl.bookID
JOIN Authors AS a ON b.authorID = a.authorID
JOIN Checkouts AS c ON b.bookID = c.bookID
ORDER BY "Title" ASC, "Book ID" ASC;

-- UPDATE an existing book
UPDATE Books 
SET title = @title,
  authorID = @authorID,
  year = @year,
  isbn = @isbn
WHERE bookID = @bookID;
-- The query below needs to be replaced with something more precise 
/*
UPDATE Books_has_Genres 
SET genreID = @genreID
WHERE bookID = @bookID;
*/

-- DELETE a book from the database
DELETE FROM Books 
WHERE bookID = @bookID;


-- CRUD queries for the Authors table:

-- CREATE a new author
INSERT INTO Authors (name)
VALUES (@name);

-- READ out authors in the database
WITH BookCounts (authorID, numBooks) AS (
  SELECT a.authorID, COUNT(*)
  FROM Books AS b 
  JOIN Authors as a
  WHERE a.authorID = b.authorID
  GROUP BY a.authorID
)
SELECT 
  a.authorID AS "Author ID", 
  a.name AS "Name",
  bc.numBooks AS "Number of Books"
FROM Authors AS a
JOIN BookCounts as bc ON a.authorID = bc.authorID
ORDER BY "Name" ASC;

-- UPDATE an existing author
UPDATE Authors 
SET name = @name
WHERE authorID = @authorID;

-- DELETE an author from the database
DELETE FROM Authors 
WHERE authorID = @authorID;


-- CRUD queries for the Genres table:

-- CREATE a new genre
INSERT INTO Genres (description)
VALUES (@desc);

-- READ out genres in the database
WITH BookCounts (genreID, numBooks) AS (
  SELECT g.genreID, COUNT(*)
  FROM Books_has_Genres AS bg 
  JOIN Genres as g
  WHERE g.genreID = bg.genreID
  GROUP BY g.genreID
)
SELECT 
  g.genreID AS "Genre ID", 
  g.description AS "Description",
  bc.numBooks AS "Number of Books"
FROM Genres AS g
JOIN BookCounts AS bc ON g.genreID = bc.genreID
ORDER BY "Description" ASC;

-- UPDATE an existing genre
UPDATE Genres 
SET description = @desc
WHERE genreID = @genreID;

-- DELETE a genre from the database
DELETE FROM Genre 
WHERE genreID = @genreID;
