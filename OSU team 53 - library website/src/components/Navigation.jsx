import {Link} from 'react-router-dom'

function Navigation(){
    return (
        <nav className="app-nav">
            <div><Link to="/">Home</Link></div>
            <div><Link to="/create">Create New Exercise</Link></div>
        </nav>
    )
}

export default Navigation;