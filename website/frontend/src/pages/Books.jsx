import { useState, useEffect } from 'react';  // Importing useState for managing state in the component
import BookTableRow from '../components/BookTableRow';
import CreateBookForm from '../components/CreateBookForm';
import UpdateBookForm from '../components/UpdateBookForm';


function Books({ backendURL }) {

    // Set up a state variable `books` to store and display the backend response
    const [books, setBooks] = useState([]);
    const [authors, setAuthors] = useState([]);
    const [genres, setGenres] = useState([]);

    const getData = async function () {
        try {
            // Make a GET request to the backend
            const response = await fetch(backendURL + '/books');
            
            // Convert the response into JSON format
            const {books, authors, genres} = await response.json();
    
            // Update the book state with the response data
            setBooks(books);
            setAuthors(authors);
            setGenres(genres);
            
        } catch (error) {
          // If the API call fails, print the error to the console
          console.log(error);
        }

    };

    // Load table on page load
    useEffect(() => {
        getData();
    }, []);

    return (
        <>
            <h1>Books</h1>

            <table>
                <thead>
                    <tr>
                        {books.length > 0 && Object.keys(books[0]).map((header, index) => (
                            <th key={index}>{header}</th>
                        ))}
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    {books.map((books, index) => (
                        <BookTableRow key={index} rowObject={books} backendURL={backendURL} refreshBooks={getData}/>
                    ))}

                </tbody>
            </table>
            
            <CreateBookForm books={books} authors={authors} genres={genres} backendURL={backendURL} refreshBooks={getData} />
            <UpdateBookForm books={books} authors={authors} genres={genres} backendURL={backendURL} refreshBooks={getData} />        
        </>
    );

} export default Books;