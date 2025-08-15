const DeleteReviewForm = ({ rowObject, backendURL, refreshReviews }) => {

    const handleDelete= async function (event) {
        event.preventDefault();

        console.log(rowObject);

        try {
            const response = await fetch(backendURL + '/delete-review', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "reviewID": rowObject["Review ID"] }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshReviews(); // Reload review data after deletion
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

export default DeleteReviewForm;