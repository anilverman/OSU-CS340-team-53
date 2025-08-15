// Disclaimer: The following code is based on the CS340 starter code for Web Application 
// Technology, with additions made to display the necessary table, information, and forms

import { useState, useEffect } from 'react';  // Importing useState for managing state in the component

function Home({ backendURL }) {
    const [reset, setReset] = useState([]);

    const handleReset = async function () {
        try {
            const response = await fetch(backendURL + '/reset', {
                method: 'POST',
            });

            const { reset } = await response.json();
            console.log('database reset');
            setReset(reset);
        } catch (error) {
            console.log(error);
        }
    };

    return (
        <>
            <h1>Beaverton Community Library</h1>
            <div className="homepageDescription">
                <p>
                Beaverton Community Library is a relatively small, yet beloved public library situated within 
                the quaint town of Beaverton, OR. This database is intended to manage its extensive catalogue 
                of books and the patrons who access, read, and review them.
                </p>
            </div>

            <button onClick={handleReset}>Reset Database</button>
        </>
    )
} export default Home;