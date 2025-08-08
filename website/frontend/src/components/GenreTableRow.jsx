import DeleteGenreForm from './DeleteGenreForm';

const GenreTableRow = ({ rowObject, backendURL, refreshGenres }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteGenreForm rowObject={rowObject} backendURL={backendURL} refreshGenres={refreshGenres} />
        </tr>
    );
};

export default GenreTableRow;