import {Link} from 'react-router-dom'

function Navigation(){
    return (
        <nav className="app-nav">
            <div><Link to="/">Home</Link></div>
            <div><Link to="/members">See Members</Link></div>
            <div><Link to="/books">See Books</Link></div>
            <div><Link to="/reviews">See Reviews</Link></div>
            <div><Link to="/checkouts">See Checkouts</Link></div>
            <div><Link to="/genres">See Genres</Link></div>
            <div><Link to="/authors">See Authors</Link></div>
        </nav>
    )
}

export default Navigation;