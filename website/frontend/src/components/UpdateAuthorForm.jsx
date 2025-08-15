// Disclaimer: The CS340 starter code for implementing CUD operations was used as 
// a guide for the following code

import { useState, useEffect } from 'react';

const UpdateAuthorForm = ({ authors, backendURL, refreshAuthors }) => {
    const [formData, setFormData] = useState({
        update_author_ID: "",
        update_author_name: ""
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
            const response = await fetch(backendURL + '/update-author', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData), 
            });
            console.log(response);
            if (response.ok) {
                console.log("Author updated successfully.");
                refreshAuthors();
            } else {
                console.error("Error updating author.");
            }
        } catch (error) {
            console.log(error);
        }
    };

    return (
        <>
        <h2>Update an Author</h2>
        <form className='cuForm' onSubmit={handleSubmit}>
            <label htmlFor="update_author_ID">Author to Update: </label>
            <select
                name="update_author_ID"
                id="update_author_ID"
                value={formData.update_author_ID}
                onChange={handleChange}
            >
                <option value="">Select an Author</option>
                {authors.map((authors) => (
                    <option key={authors["Author ID"]} value={authors["Author ID"]}>
                        {authors["Author ID"]} - {authors["Name"]}
                    </option>
                ))}
            </select>

            <label htmlFor="update_author_name">Name: </label>
            <input
                type="text"
                name="update_author_name"
                id="update_author_name"
                value={formData.update_author_name}
                onChange={handleChange}
            />

            <input type="submit" />
        </form>
        </>
    );
};

export default UpdateAuthorForm;