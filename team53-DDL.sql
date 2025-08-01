SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION;

-- Drop tables
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Checkouts;
DROP TABLE IF EXISTS Books_has_Genres;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Authors;

-- Create tables
CREATE TABLE Authors (
    authorID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(145) NOT NULL,
    PRIMARY KEY (authorID)
);

CREATE TABLE Genres (
    genreID INT NOT NULL AUTO_INCREMENT,
    description VARCHAR(145) NOT NULL,
    PRIMARY KEY (genreID)
);

CREATE TABLE Members (
    memberID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(145) NOT NULL,
    email VARCHAR(145) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (memberID)
);

CREATE TABLE Books (
    bookID INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(145) NOT NULL,
    authorID INT NOT NULL,
    year INT NOT NULL,
    isbn VARCHAR(17) NOT NULL,
    PRIMARY KEY (bookID, authorID),
    KEY (authorID),
    FOREIGN KEY (authorID) REFERENCES Authors(authorID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Books_has_Genres (
    bookID INT NOT NULL,
    genreID INT NOT NULL,
    PRIMARY KEY (bookID, genreID),
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (genreID) REFERENCES Genres(genreID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Checkouts (
    checkoutID INT NOT NULL AUTO_INCREMENT,
    memberID INT NOT NULL,
    bookID INT NOT NULL,
    dueDate DATE NOT NULL,
    isReturned TINYINT(1) NOT NULL DEFAULT 0,
    checkoutDate DATE NOT NULL,
    PRIMARY KEY (checkoutID),
    KEY (memberID),
    KEY (bookID),
    FOREIGN KEY (memberID) REFERENCES Members(memberID)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Reviews (
    reviewID INT NOT NULL AUTO_INCREMENT,
    rating SMALLINT(1) NOT NULL,
    memberID INT NOT NULL,
    bookID INT NOT NULL,
    PRIMARY KEY (reviewID),
    KEY (memberID),
    KEY (bookID),
    FOREIGN KEY (memberID) REFERENCES Members(memberID)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert data
INSERT INTO Authors (authorID, name) VALUES
(1, 'George Orwell'),
(2, 'Andrew Hunt'),
(3, 'J.R.R. Tolkien');

INSERT INTO Genres (genreID, description) VALUES
(1, 'Dystopian'),
(2, 'Software Development'),
(3, 'Fantasy');

INSERT INTO Members (memberID, name, email, phone) VALUES
(1, 'Alice Smith', 'alice@example.com', '123-456-7890'),
(2, 'Bob Johnson', 'bob@example.com', '987-654-3210'),
(3, 'Carol Davis', 'carol@example.com', '555-123-4567');

INSERT INTO Books (bookID, title, authorID, year, isbn) VALUES
(1, '1984', 1, 1949, '9780451524935'),
(2, 'The Pragmatic Programmer', 2, 1999, '9780201616224'),
(3, 'The Hobbit', 3, 1937, '9780547928227');

INSERT INTO Books_has_Genres (bookID, genreID) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Checkouts (checkoutID, memberID, bookID, dueDate, isReturned, checkoutDate) VALUES
(1, 1, 1, '2025-08-01', 0, '2025-07-15'),
(2, 2, 2, '2025-08-05', 1, '2025-07-10'),
(3, 3, 3, '2025-08-10', 0, '2025-07-20');

INSERT INTO Reviews (reviewID, rating, memberID, bookID) VALUES
(1, 5, 1, 1),
(2, 4, 2, 2),
(3, 5, 3, 3);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
