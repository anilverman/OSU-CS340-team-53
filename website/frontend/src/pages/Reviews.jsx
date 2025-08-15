// Disclaimer: The following code is based on the CS340 starter code for Web Application 
// Technology, with additions made to display the necessary table, information, and forms

import { useState, useEffect } from 'react';  // Importing useState for managing state in the component
import ReviewTableRow from '../components/ReviewTableRow';

function Reviews({ backendURL }) {

    // Set up a state variable `books` to store and display the backend response
    const [reviews, setReviews] = useState([]);
    const [books, setBooks] = useState([]);
    const [members, setMembers] = useState([]);


    const getData = async function () {
        try {
            // Make a GET request to the backend
            const response = await fetch(backendURL + '/reviews');
            
            // Convert the response into JSON format
            const {reviews, books, members} = await response.json();
    
            // Update the book state with the response data
            setReviews(reviews);
            setBooks(books);
            setMembers(members);
            
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
            <h1>Reviews</h1>

            <table>
                <thead>
                    <tr>
                        {reviews.length > 0 && Object.keys(reviews[0]).map((header, index) => (
                            <th key={index}>{header}</th>
                        ))}
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    {reviews.map((reviews, index) => (
                        <ReviewTableRow key={index} rowObject={reviews} backendURL={backendURL} refreshReviews={getData}/>
                    ))}

                </tbody>
            </table>
            
            {/*<CreateBookForm books={books} authors={authors} backendURL={backendURL} refreshBooks={getData} />
            <UpdateBookForm books={books} authors={authors} backendURL={backendURL} refreshBooks={getData} />    */}    
        </>
    );

} export default Reviews;