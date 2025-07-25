-- phpMyAdmin SQL Dump
-- version 5.2.2-1.el9.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 24, 2025 at 09:07 PM
-- Server version: 10.11.13-MariaDB-log
-- PHP Version: 8.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_vermanan`
--
CREATE DATABASE IF NOT EXISTS `cs340_vermanan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cs340_vermanan`;

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `authorID` int(11) NOT NULL,
  `name` varchar(145) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`authorID`, `name`) VALUES
(1, 'George Orwell'),
(2, 'Andrew Hunt'),
(3, 'J.R.R. Tolkien');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `bookID` int(11) NOT NULL,
  `title` varchar(145) NOT NULL,
  `authorID` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `isbn` varchar(17) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`bookID`, `title`, `authorID`, `year`, `isbn`) VALUES
(1, '1984', 1, 1949, '9780451524935'),
(2, 'The Pragmatic Programmer', 2, 1999, '9780201616224'),
(3, 'The Hobbit', 3, 1937, '9780547928227');

-- --------------------------------------------------------

--
-- Table structure for table `books_has_genres`
--

DROP TABLE IF EXISTS `books_has_genres`;
CREATE TABLE `books_has_genres` (
  `bookID` int(11) NOT NULL,
  `genreID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books_has_genres`
--

INSERT INTO `books_has_genres` (`bookID`, `genreID`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `checkouts`
--

DROP TABLE IF EXISTS `checkouts`;
CREATE TABLE `checkouts` (
  `checkoutID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `bookID` int(11) NOT NULL,
  `dueDate` date NOT NULL,
  `isReturned` tinyint(1) NOT NULL DEFAULT 0,
  `checkoutDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checkouts`
--

INSERT INTO `checkouts` (`checkoutID`, `memberID`, `bookID`, `dueDate`, `isReturned`, `checkoutDate`) VALUES
(1, 1, 1, '2025-08-01', 0, '2025-07-15'),
(2, 2, 2, '2025-08-05', 1, '2025-07-10'),
(3, 3, 3, '2025-08-10', 0, '2025-07-20');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
CREATE TABLE `genres` (
  `genreID` int(11) NOT NULL,
  `description` varchar(145) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`genreID`, `description`) VALUES
(1, 'Dystopian'),
(2, 'Software Development'),
(3, 'Fantasy');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `memberID` int(11) NOT NULL,
  `name` varchar(145) NOT NULL,
  `email` varchar(145) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`memberID`, `name`, `email`, `phone`) VALUES
(1, 'Alice Smith', 'alice@example.com', '123-456-7890'),
(2, 'Bob Johnson', 'bob@example.com', '987-654-3210'),
(3, 'Carol Davis', 'carol@example.com', '555-123-4567');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `reviewID` int(11) NOT NULL,
  `rating` smallint(1) NOT NULL,
  `memberID` int(11) NOT NULL,
  `bookID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`reviewID`, `rating`, `memberID`, `bookID`) VALUES
(1, 5, 1, 1),
(2, 4, 2, 2),
(3, 5, 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`authorID`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`bookID`,`authorID`),
  ADD KEY `fk_books_authors1_idx` (`authorID`);

--
-- Indexes for table `books_has_genres`
--
ALTER TABLE `books_has_genres`
  ADD PRIMARY KEY (`bookID`,`genreID`),
  ADD KEY `fk_books_has_genres_genres1_idx` (`genreID`),
  ADD KEY `fk_books_has_genres_books1_idx` (`bookID`);

--
-- Indexes for table `checkouts`
--
ALTER TABLE `checkouts`
  ADD PRIMARY KEY (`checkoutID`),
  ADD KEY `fk_checkout_members1_idx` (`memberID`),
  ADD KEY `fk_checkout_books1_idx` (`bookID`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genreID`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`memberID`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`reviewID`),
  ADD KEY `fk_reviews_members1_idx` (`memberID`),
  ADD KEY `fk_reviews_books1_idx` (`bookID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `authorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `bookID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `checkouts`
--
ALTER TABLE `checkouts`
  MODIFY `checkoutID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `genreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `memberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `reviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `fk_books_authors1` FOREIGN KEY (`authorID`) REFERENCES `authors` (`authorID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `books_has_genres`
--
ALTER TABLE `books_has_genres`
  ADD CONSTRAINT `fk_books_has_genres_books1` FOREIGN KEY (`bookID`) REFERENCES `books` (`bookID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_books_has_genres_genres1` FOREIGN KEY (`genreID`) REFERENCES `genres` (`genreID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `checkouts`
--
ALTER TABLE `checkouts`
  ADD CONSTRAINT `fk_checkout_books1` FOREIGN KEY (`bookID`) REFERENCES `books` (`bookID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_checkout_members1` FOREIGN KEY (`memberID`) REFERENCES `members` (`memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_books1` FOREIGN KEY (`bookID`) REFERENCES `books` (`bookID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reviews_members1` FOREIGN KEY (`memberID`) REFERENCES `members` (`memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
