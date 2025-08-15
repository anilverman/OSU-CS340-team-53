// Disclaimer: The following code is sourced from the CS340 starter code for Web Application Technology 

import React from 'react';
import { Routes, Route } from 'react-router-dom';

// Pages
import Home from './pages/Home';
import Authors from './pages/Authors';
import Books from './pages/Books';
import Members from './pages/Members';
import Genres from './pages/Genres';
import Checkouts from './pages/Checkouts';
import Reviews from './pages/Reviews';

// Components
import Navigation from './components/Navigation';

// Define the backend port and URL for API requests
const backendPort = 27230;  // Use the port you assigned to the backend server, this would normally go in a .env file
const backendURL = `http://classwork.engr.oregonstate.edu:${backendPort}`;

function App() {

    return (
        <>
            <Navigation />
            <Routes>
                <Route path="/" element={<Home backendURL={backendURL} />} />
                <Route path="/authors" element={<Authors backendURL={backendURL} />} />
                <Route path="/books" element={<Books backendURL={backendURL} />} />
                <Route path="/members" element={<Members backendURL={backendURL} />} />
                <Route path="/genres" element={<Genres backendURL={backendURL} />} />
                <Route path="/checkouts" element={<Checkouts backendURL={backendURL} />} />
                <Route path="/reviews" element={<Reviews backendURL={backendURL} />} />
            </Routes>
        </>
    );

} export default App;