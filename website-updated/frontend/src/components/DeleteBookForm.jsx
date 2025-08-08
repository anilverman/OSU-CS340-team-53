const DeleteBookForm = ({ rowObject, backendURL, refreshBook }) => {

    const handleDelete = async function () {
        try {
            const response = await fetch(backendURL + '/delete-book', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ bookID: rowObject.bookID }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshBook(); // Reload book data after deletion
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