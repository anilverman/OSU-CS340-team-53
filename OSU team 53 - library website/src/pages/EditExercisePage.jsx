import EditExercise from "../components/EditExercise";

function EditExercisePage({exerciseToEdit}){
    return (
        <>
            <h2>Edit Exercise</h2>
            <EditExercise exerciseToEdit={exerciseToEdit}></EditExercise>
        </>
    )
}

export default EditExercisePage;