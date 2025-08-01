import { MdHighlightOff } from "react-icons/md";

function DeleteButton({_id, onDelete}) {
    // create a delete button that deletes the associated exercise
    
    return (
        <>
            <MdHighlightOff onClick={() => {onDelete(_id)}}/>
        </>
    )
}

export default DeleteButton;