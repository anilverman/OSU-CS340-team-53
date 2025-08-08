import { useState, useEffect } from 'react';  // Importing useState for managing state in the component
import GenreTableRow from '../components/GenreTableRow';
//import CreateAuthorForm from '../components/CreateAuthorForm';
//import UpdateAuthorForm from '../components/UpdateAuthorForm';


function Genres({ backendURL }) {

    // Set up a state variable `author` to store and display the backend response
    const [genres, setGenres] = useState([]);


    const getData = async function () {
        try {
            // Make a GET request to the backend
            const response = await fetch(backendURL + '/genres');
            
            // Convert the response into JSON format
            const {genres} = await response.json();
    
            // Update the author state with the response data
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
            <h1>Genres</h1>

            <table>
                <thead>
                    <tr>
                        {genres.length > 0 && Object.keys(genres[0]).map((header, index) => (
                            <th key={index}>{header}</th>
                        ))}
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    {genres.map((genres, index) => (
                        <GenreTableRow key={index} rowObject={genres} backendURL={backendURL} refreshGenres={getData}/>
                    ))}

                </tbody>
            </table>
            
            {/* <CreateAuthorForm authors={authors} backendURL={backendURL} refreshAuthors={getData} />
            <UpdateAuthorForm authors={authors} backendURL={backendURL} refreshAuthors={getData} />*/}              
        </>
    );

} export default Genres;