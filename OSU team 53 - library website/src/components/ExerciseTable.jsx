import ExerciseRow from './ExerciseRow';

function ExerciseTable({exercises, onDelete, onUpdate}) {
    return (
        // create the exercise table
        <table className="exercise-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Reps</th>
                    <th>Weight</th>
                    <th>Unit</th>
                    <th>Date</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {exercises.map((exercise, i) => <ExerciseRow exercise={exercise} onDelete={onDelete} onUpdate={onUpdate} key={i} />)}
            </tbody>
        </table> 
    )
}

export default ExerciseTable;