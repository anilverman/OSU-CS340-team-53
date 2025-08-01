-- Group 53 Data Manipulation queries
-- The "@" prefix denotes a variable whose value will be determined by user input

-- CRUD queries for the Members table:

-- CREATE a new member
INSERT INTO Members (name, email, phone)
VALUES (@name, @email, @phone);

-- READ out members in the database
SELECT * FROM Members
ORDER BY Members.name ASC;

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
SELECT * FROM Checkouts
ORDER BY Checkouts.dueDate ASC, Checkouts.isReturned ASC;

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
SELECT * FROM Reviews
ORDER BY r.bookID ASC;

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
SELECT * FROM Books
JOIN Books_has_Genres ON Books.bookID = Books_has_Genres.bookID
JOIN Genres ON Books_has_Genres.genreID = Genres.genreID
ORDER BY b.name ASC;

-- UPDATE an existing book
UPDATE Books 
SET title = @title,
  authorID = @authorID,
  year = @year,
  isbn = @isbn
WHERE bookID = @bookID;
UPDATE Books_has_Genres 
SET genreID = @genreID
WHERE bookID = @bookID;

-- DELETE a book from the database
DELETE FROM Books 
WHERE bookID = @bookID;


-- CRUD queries for the Authors table:

-- CREATE a new author
INSERT INTO Authors (name)
VALUES (@name);

-- READ out authors in the database
SELECT a.authorID, a.name
FROM Authors as a
ORDER BY a.name ASC;

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
SELECT g.authorID, a.description
FROM Genres as g
ORDER BY g.description ASC;

-- UPDATE an existing genre
UPDATE Genres 
SET description = @desc
WHERE genreID = @genreID;

-- DELETE a genre from the database
DELETE FROM Genre 
WHERE genreID = @genreID;