import { useEffect, useState } from 'react'
import ExerciseTable from "../components/ExerciseTable";
import { useNavigate } from 'react-router-dom';

function HomePage({setExerciseToEdit}) {
    const [exercises, setExercises] = useState([]);
    const navigate = useNavigate();

    const API_BASE = import.meta.env.VITE_API_URL;

    const loadExercises = async () => {
        const response = await fetch(`${API_BASE}/exercises`);
        const exercises = await response.json();
        setExercises(exercises);
    }

    useEffect(() => {
        loadExercises(); 
    }, []);

    const onDelete = async (_id) => {
        const response = await fetch(`${API_BASE}/exercises/${_id}`, { method: 'DELETE' });
        if (response.status === 204) {
            setExercises(exercises.filter(m => m._id !== _id));
        } else {
            alert(`Failed to delete exercises with id = ${_id}, status code = ${response.status}`)
        }
    }

    const onUpdate = async (exercise) => {
        setExerciseToEdit(exercise)
        navigate('/edit')
    }

    return (
        <>
            <ExerciseTable exercises={exercises} onDelete={onDelete} onUpdate={onUpdate}></ExerciseTable>
        </>
    )
}

export default HomePage;