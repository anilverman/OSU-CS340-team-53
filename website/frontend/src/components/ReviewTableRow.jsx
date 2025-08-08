import DeleteReviewForm from './DeleteReviewForm';

const ReviewTableRow = ({ rowObject, backendURL, refreshReviews }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteReviewForm rowObject={rowObject} backendURL={backendURL} refreshReviews={refreshReviews} />
        </tr>
    );
};

export default ReviewTableRow;