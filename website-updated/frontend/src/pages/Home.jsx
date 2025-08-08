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
            <h1>Home page</h1>
            <div className="homepageDescription">
                <p>Developer information and Project overview here.</p>
            </div>

            <button onClick={handleReset}>Reset Database</button>
        </>
    )
} export default Home;