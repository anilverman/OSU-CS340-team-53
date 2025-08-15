// Disclaimer: The CS340 starter code for implementing CUD operations was used as 
// a guide for the following code

import { useState, useEffect } from 'react';

const CreateAuthorForm = ({ authors, backendURL, refreshAuthors }) => {
    const [formData, setFormData] = useState({
        create_author_name: ""
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
            const response = await fetch(backendURL + '/add-author', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData),
            });
            console.log(response);
            if (response.ok) {
                console.log("Author created successfully.");
                refreshAuthors();
            } else {
                console.error("Error creating author.");
            }
        } catch (error) {
            console.log(error);
        }
    };

    return (
        <>
        <h2>Create an Author</h2>

        <form className='cuForm' onSubmit={handleSubmit}>
            <label htmlFor="create_author_name">Name: </label>
            <input
                type="text"
                name="create_author_name"
                id="create_author_name"
                value={formData.create_author_name}
                onChange={handleChange}
            />

            <input type="submit" />
        </form>
        </>
    );
};

export default CreateAuthorForm;