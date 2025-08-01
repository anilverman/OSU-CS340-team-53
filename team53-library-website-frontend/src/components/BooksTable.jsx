function BooksTable() {
    return (
        // create the books table
        <table className="table">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Year</th>
                    <th>ISBN #</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                This is where the book data will be rendered
            </tbody>
        </table> 
    )
}

export default BooksTable;