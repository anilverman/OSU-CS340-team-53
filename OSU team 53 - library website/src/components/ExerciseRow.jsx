import DeleteButton from "./DeleteButton";
import UpdateButton from "./UpdateButton";

function ExerciseRow({ exercise, onDelete, onUpdate}) {
    return (
        <tr>
            <td>{exercise.name}</td>
            <td>{exercise.reps}</td>
            <td>{exercise.weight}</td>
            <td>{exercise.unit}</td>
            <td>{exercise.date}</td>
            <td><DeleteButton _id={exercise._id} onDelete={onDelete} /></td>
            <td><UpdateButton exercise={exercise} onUpdate={onUpdate}/></td>
        </tr> 
    );
}

export default ExerciseRow;