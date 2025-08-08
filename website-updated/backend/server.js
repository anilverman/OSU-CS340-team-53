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


const PORT = 5524; // backend port

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES

app.get('/authors', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `SELECT authorID, name FROM Authors`;
        const [authors] = await db.query(query1);
    
        res.status(200).json({ authors });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.post('/delete-book', async (req, res) => {
    const { bookID } = req.body;

    try {
        const [result] = await db.query(`CALL beaverton_library_delete_book(?)`, [bookID]);
        res.status(200).json({ message: `Book successfully deleted.` });
    } catch (error) {
        console.error('Error deleting book:', error);
        res.status(500).json({ message: `Failed to delete book.` });
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

app.get('/genres', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `SELECT genreID, description FROM Genres`;
        const [genres] = await db.query(query1);
    
        res.status(200).json({ genres });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.get('/members', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `SELECT memberID, name, email, phone FROM Members`;
        const [members] = await db.query(query1);
    
        res.status(200).json({ members });  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.get('/books', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `SELECT 
                            B.bookID,
                            B.title,
                            A.name AS authorName,
                            B.year,
                            B.ISBN
                        FROM Books B
                        JOIN Authors A ON B.authorID = A.authorID;`;
        const query2 = 'SELECT * FROM Authors;';
        const [books] = await db.query(query1);
        const [authors] = await db.query(query2);
    
        res.status(200).json({ books, authors});  // Send the results to the frontend

    } catch (error) {
        console.error("Error executing queries:", error);
        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
    
});

app.get('/checkouts', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `SELECT 
                            C.checkoutID,
                            M.name AS memberName,
                            B.title AS bookTitle,
                            C.dueDate,
                            C.isReturned,
                            C.checkoutDate
                        FROM Checkouts C
                        JOIN Members M ON C.memberID = M.memberID
                        JOIN Books B ON C.bookID = B.bookID;`;
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

app.get('/reviews', async (req, res) => {
    try {
        // Create and execute our queries
        const query1 = `SELECT 
                            R.reviewID,
                            M.name AS memberName,
                            B.title AS bookTitle,
                            R.rating
                        FROM Reviews R
                        JOIN Members M ON R.memberID = M.memberID
                        JOIN Books B ON R.bookID = B.bookID;`;
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

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log('Express started on http://classwork.engr.oregonstate.edu:' + PORT + '; press Ctrl-C to terminate.');
});