const UpdateAuthorForm = ({ authors, backendURL, refreshAuthor }) => {

    return (
        <>
        <h2>Update an Author</h2>
        <form className='cuForm'>
            <label htmlFor="update_author_id">Author to Update: </label>
            <select
                name="update_author_id"
                id="update_author_id"
            >
                <option value="">Select an Author</option>
                {authors.map((authors) => (
                    <option key={authors.authorID} value={authors.authorID}>
                        {authors.authorID} - {authors.name}
                    </option>
                ))}
            </select>

            <label htmlFor="update_author_age">Name: </label>
            <input
                type="text"
                name="update_author_age"
                id="update_author_age"
            />

            <input type="submit" />
        </form>
        </>
    );
};

export default UpdateAuthorForm;