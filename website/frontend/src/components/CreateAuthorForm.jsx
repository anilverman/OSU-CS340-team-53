const CreateAuthorForm = ({ authors, backendURL, refreshAuthors }) => {

    return (
        <>
        <h2>Create an Author</h2>

        <form className='cuForm'>
            <label htmlFor="create_author_name">Name: </label>
            <input
                type="text"
                name="create_author_name"
                id="create_author_name"
            />

            <input type="submit" />
        </form>
        </>
    );
};

export default CreateAuthorForm;