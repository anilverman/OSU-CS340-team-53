// Disclaimer: The CS340 starter code for implementing CUD operations was used as 
// a guide for the following code

import { useState, useEffect } from 'react';

const CreateBookForm = ({ books, authors, genres, backendURL, refreshBooks }) => {
    const [formData, setFormData] = useState({
        create_book_title: "",
        create_book_author: "",
        create_book_year: "",
        create_book_isbn: "",
        create_book_genres: "",
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        console.log(formData);

        try {
            const response = await fetch(backendURL + '/add-book', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData),
            });
            console.log(response);
            if (response.ok) {
                console.log("Book created successfully.");
                refreshBooks();
            } else {
                console.error("Error creating book.");
            }
        } catch (error) {
            console.log(error);
        }
    };

    return (
        <>
        <h2>Create a Book</h2>
        <form className='cuForm' onSubmit={handleSubmit}>
            <label htmlFor="create_book_title">Title: </label>
            <input
                type="text"
                name="create_book_title"
                id="create_book_title"
                value={formData.create_book_title}
                onChange={handleChange}
            />

            <label htmlFor="create_book_author">Author: </label>
            <select
                name="create_book_author"
                id="create_book_author"
                value={formData.create_book_author}
                onChange={handleChange}
            >
                <option value="">Select an Author</option>
                <option value="NULL">&lt; None &gt;</option>
                {authors.map((authors, index) => (
                    <option value={authors.id} key={index}>{authors.name}</option>
                ))}
            </select>

            <label htmlFor="create_book_year">Year: </label>
            <input
                type="number"
                name="create_book_year"
                id="create_book_year"
                value={formData.create_book_year}
                onChange={handleChange}
            />

            <label htmlFor="create_book_isbn">ISBN: </label>
            <input
                type="number"
                name="create_book_isbn"
                id="create_book_isbn"
                value={formData.create_book_isbn}
                onChange={handleChange}
            />

            <label htmlFor="create_book_genres">Genre(s): </label>
            <select 
                name="create_book_genres" 
                id="create_book_genres" 
                value={formData.create_book_genres}
                onChange={handleChange}
            >
                <option value="">Select a Genre</option>
                {genres.map((genres, index) => (
                    <option value={genres.genreID} key={index}>{genres.description}</option>
                ))}
            </select>
            <input type="submit" />
        </form>
        </>
    );
};

export default CreateBookForm;