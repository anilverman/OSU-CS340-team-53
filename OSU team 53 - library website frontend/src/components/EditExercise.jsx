import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function EditExercise({exerciseToEdit}) {

    const [name, setName] = useState(exerciseToEdit.name);
    const [reps, setReps] = useState(exerciseToEdit.reps);
    const [weight, setWeight] = useState(exerciseToEdit.weight);
    const [unit, setUnit] = useState(exerciseToEdit.unit);
    const [date, setDate] = useState(exerciseToEdit.date);

    const navigate = useNavigate();

    const API_BASE = import.meta.env.VITE_API_URL;

    const editExercise = async () => {
        const response = await fetch(`${API_BASE}/exercises/${exerciseToEdit._id}`, { 
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({name, reps, weight, unit, date})
        });
        if (response.status === 200) {
            alert(`exercise edited successfully, status code = ${response.status}`)
        } else {
            alert(`exercise edit failed, status code = ${response.status}`)
        }
        navigate('/'); // Go to homepage
    };

    return (
        <div>
            <input
                type="text"
                value={name}
                onChange={e => setName(e.target.value)} />
            <input
                type="number"
                value={reps}
                onChange={e => setReps(e.target.valueAsNumber)} />
            <input
                type="number"
                value={weight}
                onChange={e => setWeight(e.target.valueAsNumber)} />
            <input
                type="text"
                value={unit}
                onChange={e => setUnit(e.target.value)} />
            <input
                type="text"
                value={date}
                onChange={e => setDate(e.target.value)} />
            <button
                onClick={editExercise}
            >Update</button>
        </div>
    );
}

export default EditExercise;