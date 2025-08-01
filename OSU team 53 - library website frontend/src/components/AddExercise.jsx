import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function AddExercise() {

    const [name, setName] = useState('');
    const [reps, setReps] = useState('');
    const [weight, setWeight] = useState('');
    const [unit, setUnit] = useState('');
    const [date, setDate] = useState('');

    const navigate = useNavigate();

    const API_BASE = import.meta.env.VITE_API_URL;

    const addExercise = async () => {
        const response = await fetch(`${API_BASE}/exercises`, { 
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({name, reps, weight, unit, date})
        });
        if (response.status === 201) {
            alert(`exercise created successfully, status code = ${response.status}`)
        } else {
            alert(`exercise creation failed, status code = ${response.status}`)
        }
        navigate('/'); // Go to homepage
    };

    return (
        <div className="add-exercise">
            <input
                type="text"
                placeholder="Enter name here"
                value={name}
                onChange={e => setName(e.target.value)} />
            <input
                type="number"
                value={reps}
                placeholder="Enter reps here"
                onChange={e => setReps(e.target.valueAsNumber)} />
            <input
                type="number"
                placeholder="Enter weight here"
                value={weight}
                onChange={e => setWeight(e.target.valueAsNumber)} />
            <select value={unit} onChange={e => setUnit(e.target.value)}>
                <option value="">Select unit</option>
                <option value="lbs">lbs</option>
                <option value="kgs">kgs</option>
            </select>
            <input
                type="text"
                placeholder="Enter date here"
                value={date}
                onChange={e => setDate(e.target.value)} />
            <button
                onClick={addExercise}
            >Add</button>
        </div>
    );
}

export default AddExercise;