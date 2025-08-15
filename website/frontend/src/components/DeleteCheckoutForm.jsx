const DeleteCheckoutForm = ({ rowObject, backendURL, refreshCheckouts }) => {

    const handleDelete= async function (event) {
        event.preventDefault();

        console.log(rowObject);

        try {
            const response = await fetch(backendURL + '/delete-checkout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "checkoutID": rowObject["Checkout ID"] }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshCheckouts(); // Reload checkout data after deletion
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

export default DeleteCheckoutForm;