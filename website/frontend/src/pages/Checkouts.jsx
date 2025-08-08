import { useState, useEffect } from 'react';  // Importing useState for managing state in the component
import CheckoutTableRow from '../components/CheckoutTableRow';
//import CreateBookForm from '../components/CreateBookForm';
//import UpdateBookForm from '../components/UpdateBookForm';


function Checkouts({ backendURL }) {

    // Set up a state variable `books` to store and display the backend response
    const [checkouts, setCheckouts] = useState([]);
    const [books, setBooks] = useState([]);
    const [members, setMembers] = useState([]);


    const getData = async function () {
        try {
            // Make a GET request to the backend
            const response = await fetch(backendURL + '/checkouts');
            
            // Convert the response into JSON format
            const {checkouts, books, members} = await response.json();
    
            // Update the book state with the response data
            setCheckouts(checkouts);
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
            <h1>Checkouts</h1>

            <table>
                <thead>
                    <tr>
                        {checkouts.length > 0 && Object.keys(checkouts[0]).map((header, index) => (
                            <th key={index}>{header}</th>
                        ))}
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    {checkouts.map((checkouts, index) => (
                        <CheckoutTableRow key={index} rowObject={checkouts} backendURL={backendURL} refreshCheckouts={getData}/>
                    ))}

                </tbody>
            </table>
            
            {/*<CreateBookForm books={books} authors={authors} backendURL={backendURL} refreshBooks={getData} />
            <UpdateBookForm books={books} authors={authors} backendURL={backendURL} refreshBooks={getData} />    */}    
        </>
    );

} export default Checkouts;