import { useState } from 'react'
import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Navigation from './components/Navigation'
import HomePage from './pages/HomePage'
import MembersPage from './pages/MembersPage'
import BooksPage from './pages/BooksPage'
import ReviewsPage from './pages/ReviewsPage'
import CheckoutsPage from './pages/CheckoutsPage'
import GenresPage from './pages/GenresPage'
import AuthorsPage from './pages/AuthorsPage'

function App() {

  return (
    <>
    <header>
      <h1>OSU team 53: library</h1>
      <p>Select pages below</p>
    </header>
    <div className='app'>
      <Router>
        <Navigation />
        <Routes>
          <Route path="/" element={<HomePage />}></Route>
          <Route path="/members" element={<MembersPage />}></Route>
          <Route path="/books" element={<BooksPage />}></Route>
          <Route path="/reviews" element={<ReviewsPage />}></Route>
          <Route path="/checkouts" element={<CheckoutsPage />}></Route>
          <Route path="/genres" element={<GenresPage />}></Route>
          <Route path="/authors" element={<AuthorsPage />}></Route>
        </Routes>
      </Router>
    </div>
    <footer>© 2025 team 53</footer>
    </>
  )
}

export default App