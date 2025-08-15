const DeleteAuthorForm = ({ rowObject, backendURL, refreshAuthors }) => {

    const handleDeleteAuthor = async function (event) {
        event.preventDefault();

        console.log(rowObject);

        try {
            const response = await fetch(backendURL + '/delete-author', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "authorID": rowObject["Author ID"] }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshAuthors(); // Reload author data after deletion
        } catch (error) {
            console.log(error);
        }
    };

    return (
        <td>
            <form onSubmit={handleDeleteAuthor}>
                <button type='submit'>
                    Delete
                </button>
            </form>
        </td>

    );
};

export default DeleteAuthorForm;