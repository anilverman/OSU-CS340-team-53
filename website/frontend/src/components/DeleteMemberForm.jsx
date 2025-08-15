// Disclaimer: The CS340 starter code for implementing CUD operations was used as 
// a guide for the following code

const DeleteMemberForm = ({ rowObject, backendURL, refreshMembers }) => {

    const handleDelete= async function (event) {
        event.preventDefault();

        console.log(rowObject);

        try {
            const response = await fetch(backendURL + '/delete-member', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ "memberID": rowObject["Member ID"] }),
            });

            const { message } = await response.json();
            console.log(message);
            refreshMembers(); // Reload member data after deletion
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

export default DeleteMemberForm;