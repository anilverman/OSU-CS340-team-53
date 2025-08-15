-- Group 53 Procedure Language SQL queries

DROP PROCEDURE IF EXISTS beaverton_library_reset_database;
DROP PROCEDURE IF EXISTS beaverton_library_add_book;
DROP PROCEDURE IF EXISTS beaverton_library_update_book;
DROP PROCEDURE IF EXISTS beaverton_library_delete_book;
DROP PROCEDURE IF EXISTS beaverton_library_add_author;
DROP PROCEDURE IF EXISTS beaverton_library_update_author;
DROP PROCEDURE IF EXISTS beaverton_library_delete_author;
DROP PROCEDURE IF EXISTS beaverton_library_delete_genre;
DROP PROCEDURE IF EXISTS beaverton_library_delete_member;
DROP PROCEDURE IF EXISTS beaverton_library_delete_checkout;
DROP PROCEDURE IF EXISTS beaverton_library_delete_review;

DELIMITER //

-- Procedure for resetting the database
CREATE PROCEDURE beaverton_library_reset_database()
BEGIN
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
            ON DELETE CASCADE ON UPDATE CASCADE,
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
            ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (bookID) REFERENCES Books(bookID)
            ON DELETE CASCADE ON UPDATE CASCADE
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
            ON DELETE CASCADE ON UPDATE CASCADE,
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
END //

-- Procedure for adding a new book to the database
CREATE PROCEDURE beaverton_library_add_book(IN p_title VARCHAR(145), p_author VARCHAR(145), p_year INT, p_isbn VARCHAR(17), p_genreID INT)
BEGIN
    DECLARE p_authorID INT;
    DECLARE p_bookID INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not add ", p_title, " by ", p_author, " to the database.") AS Result;
    END;

    START TRANSACTION;

    -- Get the book's author's authorID
    SELECT Authors.authorID INTO p_authorID FROM Authors WHERE Authors.name = p_author;
    -- Check if the database already has the book we're adding
    IF EXISTS (SELECT 1 FROM Books WHERE Books.title = p_title AND Books.authorID = p_authorID AND Books.year = p_year AND Books.isbn = p_isbn) THEN
        -- Rollback if the book we're trying to add already exists
        ROLLBACK;
        SELECT CONCAT("Error: The book ", p_title, " by ", p_author, " already exists in the database.") AS Result;
    ELSE 
        INSERT INTO Books (title, authorID, year, isbn)
        VALUES (
            p_title,
            p_authorID,
            p_year,
            p_isbn
        );
        SELECT LAST_INSERT_ID() INTO p_bookID;
        INSERT INTO Books_has_Genres (bookID, genreID)
        VALUES (
            p_bookID, 
            p_genreID
        );
        COMMIT;
        SELECT CONCAT("Successfully added ", p_title, " by ", p_author, " to the database.") AS Result;
    END IF;
END //

-- Procedure for updating the information of a book in the database
CREATE PROCEDURE beaverton_library_update_book(
    IN p_bookID INT,
    p_newAuthorID INT,
    p_newYear INT,
    p_newIsbn VARCHAR(17),
    p_newGenres VARCHAR(65535)
)
BEGIN
    -- 1. Declare all variables, cursors, and handlers first (MariaDB gave me a MASSIVE headache until I got this down)
    -- Variables
    DECLARE currentGenre VARCHAR(145);
    DECLARE p_genreID INT;
    DECLARE v_position INT DEFAULT 1;
    DECLARE v_value VARCHAR(145);
    DECLARE done INT DEFAULT FALSE;
    
    -- Cursor (declared after all variables)
    DECLARE genreIterator CURSOR FOR SELECT value FROM temp_values;

    -- Handlers (declared last)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        -- Use IF EXISTS to avoid errors if the table was never created
        DROP TEMPORARY TABLE IF EXISTS temp_values;
        SELECT CONCAT("Error: Could not update the information of book #", p_bookID, " in the database.") AS Result;
    END;
    
    -- 2. Execute other statements after all declarations are complete
    CREATE TEMPORARY TABLE temp_values (
        value VARCHAR(145)
    );

    WHILE v_position > 0 DO
        SET v_position = LOCATE('|', p_newGenres);
        IF v_position > 0 THEN
            SET v_value = SUBSTRING(p_newGenres, 1, v_position - 1);
            SET p_newGenres = SUBSTRING(p_newGenres, v_position + 1);
        ELSE
            SET v_value = p_newGenres;
        END IF;
        INSERT INTO temp_values (value) VALUES (v_value);
    END WHILE;

    -- 3. Proceed with the rest of the procedure
    START TRANSACTION;

    UPDATE Books
    SET
        authorID = p_newAuthorID,
        year = p_newYear,
        isbn = p_newIsbn
    WHERE bookID = p_bookID;

    DELETE FROM Books_has_Genres WHERE bookID = p_bookID;

    OPEN genreIterator;
    read_loop: LOOP
        FETCH genreIterator INTO currentGenre;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT genreID INTO p_genreID FROM Genres WHERE description = currentGenre;
        
        IF p_genreID IS NOT NULL THEN
            INSERT INTO Books_has_Genres (bookID, genreID) VALUES (p_bookID, p_genreID);
        END IF;
    END LOOP;
    CLOSE genreIterator;

    COMMIT;
    SELECT CONCAT("Book #", p_bookID, " successfully updated.") AS Result;
    DROP TEMPORARY TABLE IF EXISTS temp_values;
END //

-- Procedure for deleting a book from the database
CREATE PROCEDURE beaverton_library_delete_book(IN p_bookID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete book #", p_bookID," from the database.") AS Result;
    END;

    START TRANSACTION;

    -- Checks if the book to be deleted is actually in the database
    IF EXISTS (SELECT 1 FROM Books WHERE Books.bookID = p_bookID) THEN
        -- Delete the book from the Books table
        DELETE FROM Books WHERE Books.bookID = p_bookID;
        COMMIT;
        SELECT CONCAT("Book #", p_bookID, " successfully deleted.") AS Result;
    ELSE
        -- Rollback the transaction if book does not exist
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete book #", p_bookID," from the database.") AS Result;
    END IF;
END //

-- Procedure for adding a new author to the database
CREATE PROCEDURE beaverton_library_add_author(IN p_name VARCHAR(145))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not add author", p_name," to the database.") AS Result;
    END;

    START TRANSACTION;

    -- Check if the database already has the author we're adding
    IF EXISTS (SELECT 1 FROM Authors WHERE Authors.name = p_name) THEN 
        -- Rollback if the author we're trying to add already exists
        ROLLBACK;
        SELECT CONCAT("Error: The author ", p_name, " already exists in the database.") AS Result;
    ELSE
        INSERT INTO Authors (name) VALUES (p_name);
        COMMIT;
        SELECT CONCAT("Successfully added author ", p_name, " to the database.") AS Result;
    END IF;
END //

-- Procedure for updating the information of an author in the database
CREATE PROCEDURE beaverton_library_update_author(IN p_authorID INT, p_newName VARCHAR(145))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not update the information of author #", p_authorID," in the database.") AS Result;
    END;

    START TRANSACTION;

    UPDATE Authors
    SET
        name = p_newName
    WHERE authorID = p_authorID;
    COMMIT;
    SELECT CONCAT("Author #", p_authorID, " successfully updated.") AS Result;
END //

-- Procedure for deleting an author from the database
CREATE PROCEDURE beaverton_library_delete_author(IN p_authorID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete author #", p_authorID," from the database.") AS Result;
    END;

    START TRANSACTION;

    -- Checks if the author to be deleted is actually in the database
    IF EXISTS (SELECT 1 FROM Authors WHERE Authors.authorID = p_authorID) THEN
        -- Delete the author from the Authors table
        DELETE FROM Authors WHERE Authors.authorID = p_authorID;
        COMMIT;
        SELECT CONCAT("Author #", p_authorID, " successfully deleted.") AS Result;
    ELSE
        -- Rollback the transaction if author does not exist
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete author #", p_authorID," from the database.") AS Result;
    END IF;
END //

-- Procedure for deleting a genre from the database
CREATE PROCEDURE beaverton_library_delete_genre(IN p_genreID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete genre #", p_genreID," from the database.") AS Result;
    END;

    START TRANSACTION;

    -- Checks if the genre to be deleted is actually in the database
    IF EXISTS (SELECT 1 FROM Genres WHERE Genres.genreID = p_genreID) THEN
        -- Delete the genre from the Genres table
        DELETE FROM Genres WHERE Genres.genreID = p_genreID;
        COMMIT;
        SELECT CONCAT("Genre #", p_genreID, " successfully deleted.") AS Result;
    ELSE
        -- Rollback the transaction if genre does not exist
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete genre #", p_genreID," from the database.") AS Result;
    END IF;
END //

-- Procedure for deleting a member from the database
CREATE PROCEDURE beaverton_library_delete_member(IN p_memberID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete member #", p_memberID," from the database.") AS Result;
    END;

    START TRANSACTION;

    -- Checks if the member to be deleted is actually in the database
    IF EXISTS (SELECT 1 FROM Members WHERE Members.memberID = p_memberID) THEN
        -- Delete the member from the Members table
        DELETE FROM Members WHERE Members.memberID = p_memberID;
        COMMIT;
        SELECT CONCAT("Member #", p_memberID, " successfully deleted.") AS Result;
    ELSE
        -- Rollback the transaction if member does not exist
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete member #", p_memberID," from the database.") AS Result;
    END IF;
END //

-- Procedure for deleting a checkout from the database
CREATE PROCEDURE beaverton_library_delete_checkout(IN p_checkoutID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete checkout #", p_checkoutID," from the database.") AS Result;
    END;

    START TRANSACTION;

    -- Checks if the checkout to be deleted is actually in the database
    IF EXISTS (SELECT 1 FROM Checkouts WHERE Checkouts.checkoutID = p_checkoutID) THEN
        -- Delete the checkout from the Checkouts table
        DELETE FROM Checkouts WHERE Checkouts.checkoutID = p_checkoutID;
        COMMIT;
        SELECT CONCAT("Checkout #", p_checkoutID, " successfully deleted.") AS Result;
    ELSE
        -- Rollback the transaction if checkout does not exist
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete checkout #", p_checkoutID," from the database.") AS Result;
    END IF;
END //

-- Procedure for deleting a review from the database
CREATE PROCEDURE beaverton_library_delete_review(IN p_reviewID INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete review #", p_reviewID," from the database.") AS Result;
    END;

    START TRANSACTION;

    -- Checks if the review to be deleted is actually in the database
    IF EXISTS (SELECT 1 FROM Reviews WHERE Reviews.reviewID = p_reviewID) THEN
        -- Delete the review from the Reviews table
        DELETE FROM Reviews WHERE Reviews.reviewID = p_reviewID;
        COMMIT;
        SELECT CONCAT("Review #", p_reviewID, " successfully deleted.") AS Result;
    ELSE
        -- Rollback the transaction if review does not exist
        ROLLBACK;
        SELECT CONCAT("Error: Could not delete review #", p_reviewID," from the database.") AS Result;
    END IF;
END //

DELIMITER ;
