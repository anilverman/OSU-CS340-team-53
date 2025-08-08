const UpdateBookForm = ({ books, authors, backendURL, refreshBooks }) => {

    return (
        <>
        <h2>Update a Book</h2>
        <form className='cuForm'>
            <label htmlFor="update_book_id">Book to Update: </label>
            <select
                name="update_book_id"
                id="update_book_id"
            >
                <option value="">Select a Book</option>
                {books.map((books) => (
                    <option key={books.bookID} value={books.bookID}>
                        {books.bookID} - {books.title}
                    </option>
                ))}
            </select>

            <label htmlFor="update_book_author">Author: </label>
            <select
                name="update_book_author"
                id="update_book_author"
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
            />

            <label htmlFor="update_book_isbn">ISBN: </label>
            <input
                type="number"
                name="update_book_isbn"
                id="update_book_isbn"
            />

            <input type="submit" />
        </form>
        </>
    );
};

export default UpdateBookForm;