function ReviewsTable() {
    return (
        // create the reviews table
        <table className="table">
            <thead>
                <tr>
                    <th>Book Title</th>
                    <th>Member Name</th>
                    <th>Rating</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                This is where the review data will be rendered
            </tbody>
        </table> 
    )
}

export default ReviewsTable;