import { useState, useEffect } from 'react';

const UpdateBookForm = ({ books, authors, genres, backendURL, refreshBooks }) => {
    const [formData, setFormData] = useState({
        update_book_ID: "",
        update_book_author: "",
        update_book_year: "",
        update_book_isbn: "",
        update_book_genres: [],
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value
        }));
    };

    const handleGenres = (event) => {
        const selectedOptions = Array.from(event.target.selectedOptions).map(option => option.value);
        setFormData(prevData => ({
            ...prevData,
            update_book_genres: selectedOptions
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        console.log(formData);

        try {
            const response = await fetch(backendURL + '/update-book', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData), 
            });
            console.log(response);
            if (response.ok) {
                console.log("Book updated successfully.");
                refreshBooks();
            } else {
                console.error("Error updating book.");
            }
        } catch (error) {
            console.log(error);
        }
    };
    
    return (
        <>
        <h2>Update a Book</h2>
        <form className='cuForm' onSubmit={handleSubmit}>
            <label htmlFor="update_book_ID">Book to Update: </label>
            <select
                name="update_book_ID"
                id="update_book_ID"
                value={formData.update_book_ID}
                onChange={handleChange}
            >
                <option value="">Select a Book</option>
                {books.map((books) => (
                    <option key={books["Book ID"]} value={books["Book ID"]}>
                        {books["Book ID"]} - {books["Title"]}
                    </option>
                ))}
            </select>

            <label htmlFor="update_book_author">Author: </label>
            <select
                name="update_book_author"
                id="update_book_author"
                value={formData.update_book_author}
                onChange={handleChange}
            >
                <option value="">Select an Author</option>
                <option value="NULL">&lt; None &gt;</option>
                {authors.map((authors) => (
                    <option key={authors.authorID} value={authors.authorID}>
                        {authors.name}
                    </option>
                ))}
            </select>

            <label htmlFor="update_book_year">Year: </label>
            <input
                type="number"
                name="update_book_year"
                id="update_book_year"
                value={formData.update_book_year}
                onChange={handleChange}
            />

            <label htmlFor="update_book_isbn">ISBN: </label>
            <input
                type="number"
                name="update_book_isbn"
                id="update_book_isbn"
                value={formData.update_book_isbn}
                onChange={handleChange}
            />

            <label htmlFor="update_book_genres">Genre(s): </label>
            <select 
                id="update_book_genres" 
                name="update_book_genres" 
                multiple 
                size="3"
                value={formData.update_book_genres}
                onChange={handleGenres}
            >
                {genres.map((genres) => (
                    <option key={genres.genreID} value={genres.description}>
                        {genres.description}
                    </option>
                ))}
            </select>

            <input type="submit" />
        </form>
        </>
    );
};

export default UpdateBookForm;