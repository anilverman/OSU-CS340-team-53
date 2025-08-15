// Disclaimer: The appropriate CS340 starter code for Web Application Technology was used as 
// a guide for the following code

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