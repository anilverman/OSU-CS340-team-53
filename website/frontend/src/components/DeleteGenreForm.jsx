// Disclaimer: The CS340 starter code for implementing CUD operations was used as 
// a guide for the following code

const DeleteGenreForm = ({ rowObject, backendURL, refreshGenres }) => {

    const handleDelete= async function (event) {
        event.preventDefault();

        console.log(rowObject);

        try {
            const response = await fetch(backendURL + '/delete-genre', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "genreID": rowObject["Genre ID"] }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshGenres(); // Reload genre data after deletion
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

export default DeleteGenreForm;