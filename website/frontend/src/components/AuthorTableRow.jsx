import DeleteAuthorForm from './DeleteAuthorForm';

const AuthorTableRow = ({ rowObject, backendURL, refreshAuthor }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteAuthorForm rowObject={rowObject} backendURL={backendURL} refreshAuthor={refreshAuthor} />
        </tr>
    );
};

export default AuthorTableRow;