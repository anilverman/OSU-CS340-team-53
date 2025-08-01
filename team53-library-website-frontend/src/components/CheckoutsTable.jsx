function CheckoutsTable() {
    return (
        // create the checkout table
        <table className="table">
            <thead>
                <tr>
                    <th>Member Name</th>
                    <th>Book Title</th>
                    <th>Checkout Date</th>
                    <th>Due Date</th>
                    <th>Return Status</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                This is where the checkout data will be rendered
            </tbody>
        </table> 
    )
}

export default CheckoutsTable;