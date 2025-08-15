import DeleteMemberForm from './DeleteMemberForm';

const MemberTableRow = ({ rowObject, backendURL, refreshMembers }) => {
    return (
        <tr>
            {Object.values(rowObject).map((value, index) => (
                <td key={index}>{value}</td>
            ))}
            
            <DeleteMemberForm rowObject={rowObject} backendURL={backendURL} refreshMembers={refreshMembers} />
        </tr>
    );
};

export default MemberTableRow;