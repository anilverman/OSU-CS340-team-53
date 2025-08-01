function AuthorsTable() {
    return (
        // create the author table
        <table className="table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                This is where the author data will be rendered
            </tbody>
        </table> 
    )
}

export default AuthorsTable;