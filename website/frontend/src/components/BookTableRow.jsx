import DeleteBookForm from './DeleteBookForm';

const BookTableRow = ({ rowObject, backendURL, refreshBooks }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteBookForm rowObject={rowObject} backendURL={backendURL} refreshBooks={refreshBooks} />
        </tr>
    );
};

export default BookTableRow;