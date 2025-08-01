function MembersTable() {
    return (
        // create the member table
        <table className="table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                This is where the member data will be rendered
            </tbody>
        </table> 
    )
}

export default MembersTable;