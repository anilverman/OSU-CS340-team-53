const CreateBookForm = ({ books, authors, backendURL, refreshBooks }) => {

    return (
        <>
        <h2>Create a Book</h2>

        <form className='cuForm'>
            <label htmlFor="create_book_title">Title: </label>
            <input
                type="text"
                name="create_book_title"
                id="create_book_title"
            />

            <label htmlFor="create_book_author">Author: </label>
            <select
                name="create_book_author"
                id="create_book_author"
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
            />

            <label htmlFor="create_book_isbn">ISBN: </label>
            <input
                type="number"
                name="create_book_isbn"
                id="create_book_isbn"
            />

            <input type="submit" />
        </form>
        </>
    );
};

export default CreateBookForm;