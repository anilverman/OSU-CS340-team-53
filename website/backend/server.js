// ########################################
// ########## SETUP

// Database
const db = require('./database/db-connector');

// Express
const express = require('express');
const app = express();

// Middleware
const cors = require('cors');
app.use(cors({ credentials: true, origin: "*" }));
app.use(express.json()); // this is needed for post requests


const PORT = 27230; // backend port

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES

// CRUD operations for the Authors table
app.get('/authors', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `
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
        CASE
            WHEN bc.numBooks IS NULL THEN 0
            ELSE bc.numBooks
        END AS "Number of Books"
        FROM Authors AS a
        LEFT JOIN BookCounts as bc ON a.authorID = bc.authorID
        ORDER BY "Name" ASC;
        `;
        const [authors] = await db.query(query1);
    
        res.status(200).json({ authors });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/add-author', async (req, res) => {
    try {
        let data = req.body;
        console.log(data);
        const [rows, fields] = await db.query(`CALL beaverton_library_add_author(?);`, [
            data.create_author_name
        ]);
        res.status(200).json({ message: `Author successfully added.` });
    } catch (error) {
        console.error('Error adding author:', error);
        res.status(500).json({ message: `Failed to add author.` });
    }
});

app.post('/update-author', async (req, res) => {
    try {
        let data = req.body;
        console.log(data);
        const [rows, fields] = await db.query(`CALL beaverton_library_update_author(?, ?);`, [
            data.update_author_ID,
            data.update_author_name
        ]);
        res.status(200).json({ message: `Author successfully updated.` });
    } catch (error) {
        console.error('Error updating author:', error);
        res.status(500).json({ message: `Failed to update author.` });
    }
});

app.post('/delete-author', async (req, res) => {
    const { authorID } = req.body;
    console.log('Received authorID:', authorID);
    if (!authorID) {
        return res.status(400).json({ message: 'authorID is required.' });
    }

    try {
        const [rows, fields] = await db.query(`CALL beaverton_library_delete_author(?);`, [authorID]);
        res.status(200).json({ message: `Author successfully deleted.` });
    } catch (error) {
        console.error('Error deleting author:', error);
        res.status(500).json({ message: `Failed to delete author.` });
    }
});

app.post('/reset', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `CALL beaverton_library_reset_database();`;
        const [reset] = await db.query(query1);
        res.status(200).send('Database has been reset.');  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

// CRUD operations for the Genres table
app.get('/genres', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `
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
        `;
        const [genres] = await db.query(query1);
    
        res.status(200).json({ genres });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/delete-genre', async (req, res) => {
    const { genreID } = req.body;
    console.log('Received genreID:', genreID);
    if (!genreID) {
        return res.status(400).json({ message: 'genreID is required.' });
    }

    try {
        const [rows, fields] = await db.query(`CALL beaverton_library_delete_genre(?);`, [genreID]);
        res.status(200).json({ message: `Genre successfully deleted.` });
    } catch (error) {
        console.error('Error deleting genre:', error);
        res.status(500).json({ message: `Failed to delete genre.` });
    }
});

// CRUD operations for the Members table
app.get('/members', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `
        SELECT
        m.memberID AS "Member ID",
        m.name AS "Name",
        m.email AS "Email",
        m.phone AS "Phone Number" 
        FROM Members AS m
        ORDER BY "Name" ASC;
        `;
        const [members] = await db.query(query1);
    
        res.status(200).json({ members });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/delete-member', async (req, res) => {
    const { memberID } = req.body;
    console.log('Received memberID:', memberID);
    if (!memberID) {
        return res.status(400).json({ message: 'memberID is required.' });
    }

    try {
        const [rows, fields] = await db.query(`CALL beaverton_library_delete_member(?);`, [memberID]);
        res.status(200).json({ message: `Member successfully deleted.` });
    } catch (error) {
        console.error('Error deleting member:', error);
        res.status(500).json({ message: `Failed to delete member.` });
    }
});

// CRUD operations for the Books table
app.get('/books', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `
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
        LEFT JOIN Checkouts AS c ON b.bookID = c.bookID
        ORDER BY "Title" ASC, "Book ID" ASC;
        `;
        const query2 = 'SELECT * FROM Authors;';
        const query3 = 'SELECT * FROM Genres;';
        const [books] = await db.query(query1);
        const [authors] = await db.query(query2);
        const [genres] = await db.query(query3);
    
        res.status(200).json({ books, authors, genres });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/add-book', async (req, res) => {
    try {
        let data = req.body;
        console.log(data);
        const [rows, fields] = await db.query(`CALL beaverton_library_add_book(?, ?, ?, ?, ?);`, Object.values(data));
        res.status(200).json({ message: `Book successfully added.` });
    } catch (error) {
        console.error('Error adding book:', error);
        res.status(500).json({ message: `Failed to add book.` });
    }
});

app.post('/update-book', async (req, res) => {
    try {
        let data = req.body;
        data.update_book_genres = data.update_book_genres.join("|");
        console.log(data);
        const [rows, fields] = await db.query(`CALL beaverton_library_update_book(?, ?, ?, ?, ?);`, [
            data.update_book_ID,
            data.update_book_author,
            data.update_book_year,
            data.update_book_isbn,
            data.update_book_genres
        ]);
        res.status(200).json({ message: `Book successfully updated.` });
    } catch (error) {
        console.error('Error updating book:', error);
        res.status(500).json({ message: `Failed to update book.` });
    }
});

app.post('/delete-book', async (req, res) => {
    const { bookID } = req.body;
    console.log('Received bookID:', bookID);
    if (!bookID) {
        return res.status(400).json({ message: 'bookID is required.' });
    }

    try {
        const [rows, fields] = await db.query(`CALL beaverton_library_delete_book(?);`, [bookID]);
        res.status(200).json({ message: `Book successfully deleted.` });
    } catch (error) {
        console.error('Error deleting book:', error);
        res.status(500).json({ message: `Failed to delete book.` });
    }
});

// CRUD operations for the Checkouts table
app.get('/checkouts', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `
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
        `;
        const query2 = 'SELECT * FROM Books;';
        const query3 = 'SELECT * FROM Members;';
        const [checkouts] = await db.query(query1);
        const [books] = await db.query(query2);
        const [members] = await db.query(query3);
    
        res.status(200).json({ checkouts, books, members});  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/delete-checkout', async (req, res) => {
    const { checkoutID } = req.body;
    console.log('Received checkoutID:', checkoutID);
    if (!checkoutID) {
        return res.status(400).json({ message: 'checkoutID is required.' });
    }

    try {
        const [rows, fields] = await db.query(`CALL beaverton_library_delete_checkout(?);`, [checkoutID]);
        res.status(200).json({ message: `Checkout successfully deleted.` });
    } catch (error) {
        console.error('Error deleting checkout:', error);
        res.status(500).json({ message: `Failed to delete checkout.` });
    }
});

// CRUD operations for the Reviews table
app.get('/reviews', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `
        SELECT
        r.reviewID AS "Review ID",
        b.title AS "Book Title",
        m.name AS "Reviewer",
        r.rating AS "Rating"
        FROM Reviews AS r
        JOIN Members AS m ON m.memberID = r.memberID
        JOIN Books AS b ON b.bookID = r.bookID
        ORDER BY "Review ID" ASC;
        `;
        const query2 = 'SELECT * FROM Books;';
        const query3 = 'SELECT * FROM Members;';
        const [reviews] = await db.query(query1);
        const [books] = await db.query(query2);
        const [members] = await db.query(query3);
    
        res.status(200).json({ reviews, books, members});  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/delete-review', async (req, res) => {
    const { reviewID } = req.body;
    console.log('Received reviewID:', reviewID);
    if (!reviewID) {
        return res.status(400).json({ message: 'reviewID is required.' });
    }

    try {
        const [rows, fields] = await db.query(`CALL beaverton_library_delete_review(?);`, [reviewID]);
        res.status(200).json({ message: `Review successfully deleted.` });
    } catch (error) {
        console.error('Error deleting review:', error);
        res.status(500).json({ message: `Failed to delete review.` });
    }
});

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log('Express started on http://classwork.engr.oregonstate.edu:' + PORT + '; press Ctrl-C to terminate.');
});