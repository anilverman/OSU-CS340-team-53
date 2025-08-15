// Disclaimer: The appropriate CS340 starter code for Web Application Technology was used as 
// a guide for the following code

import DeleteCheckoutForm from './DeleteCheckoutForm';

const CheckoutTableRow = ({ rowObject, backendURL, refreshCheckouts }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteCheckoutForm rowObject={rowObject} backendURL={backendURL} refreshCheckouts={refreshCheckouts} />
        </tr>
    );
};

export default CheckoutTableRow;