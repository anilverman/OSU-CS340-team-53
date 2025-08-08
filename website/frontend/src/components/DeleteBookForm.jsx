const DeleteBookForm = ({ rowObject, backendURL, refreshBooks }) => {

    const handleDelete = async function (event) {
        event.preventDefault();

        console.log('bookID:', rowObject["Book ID"]);

        try {
            const response = await fetch(backendURL + '/delete-book', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "bookID": rowObject["Book ID"] }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshBooks(); // Reload book data after deletion
        } catch (error) {
            console.log(error);
        }
    };

    return (
        <td>
            <form onSubmit={handleDelete}>
                <button type='submit'>
                    Delete
                </button>
            </form>
        </td>

    );
};

export default DeleteBookForm;