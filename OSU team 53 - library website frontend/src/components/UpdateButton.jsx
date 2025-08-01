import { MdModeEdit } from "react-icons/md";

function UpdateButton({exercise, onUpdate}) {
    // create a update button that deletes the associated exercise
    
    return (
        <>
            <MdModeEdit onClick={() => {onUpdate(exercise)}}/>
        </>
    )
}

export default UpdateButton;