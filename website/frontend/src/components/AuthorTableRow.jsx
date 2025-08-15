// Disclaimer: The appropriate CS340 starter code for Web Application Technology was used as 
// a guide for the following code

import DeleteAuthorForm from './DeleteAuthorForm';

const AuthorTableRow = ({ rowObject, backendURL, refreshAuthors }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteAuthorForm rowObject={rowObject} backendURL={backendURL} refreshAuthors={refreshAuthors} />
        </tr>
    );
};

export default AuthorTableRow;