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

-- --------------------------------------------------------

--
-- Table structure for table `Authors`
--

DROP TABLE IF EXISTS `Authors`;
CREATE TABLE `Authors` (
  `authorID` int(11) NOT NULL,
  `name` varchar(145) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Authors`
--

INSERT INTO `Authors` (`authorID`, `name`) VALUES
(1, 'George Orwell'),
(2, 'Andrew Hunt'),
(3, 'J.R.R. Tolkien');

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
CREATE TABLE `Books` (
  `bookID` int(11) NOT NULL,
  `title` varchar(145) NOT NULL,
  `authorID` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `isbn` varchar(17) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Books`
--

INSERT INTO `Books` (`bookID`, `title`, `authorID`, `year`, `isbn`) VALUES
(1, '1984', 1, 1949, '9780451524935'),
(2, 'The Pragmatic Programmer', 2, 1999, '9780201616224'),
(3, 'The Hobbit', 3, 1937, '9780547928227');

-- --------------------------------------------------------

--
-- Table structure for table `Books_has_Genres`
--

DROP TABLE IF EXISTS `Books_has_Genres`;
CREATE TABLE `Books_has_Genres` (
  `bookID` int(11) NOT NULL,
  `genreID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Books_has_Genres`
--

INSERT INTO `Books_has_Genres` (`bookID`, `genreID`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Checkouts`
--

DROP TABLE IF EXISTS `Checkouts`;
CREATE TABLE `Checkouts` (
  `checkoutID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `bookID` int(11) NOT NULL,
  `dueDate` date NOT NULL,
  `isReturned` tinyint(1) NOT NULL DEFAULT 0,
  `checkoutDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Checkouts`
--

INSERT INTO `Checkouts` (`checkoutID`, `memberID`, `bookID`, `dueDate`, `isReturned`, `checkoutDate`) VALUES
(1, 1, 1, '2025-08-01', 0, '2025-07-15'),
(2, 2, 2, '2025-08-05', 1, '2025-07-10'),
(3, 3, 3, '2025-08-10', 0, '2025-07-20');

-- --------------------------------------------------------

--
-- Table structure for table `Genres`
--

DROP TABLE IF EXISTS `Genres`;
CREATE TABLE `Genres` (
  `genreID` int(11) NOT NULL,
  `description` varchar(145) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Genres`
--

INSERT INTO `Genres` (`genreID`, `description`) VALUES
(1, 'Dystopian'),
(2, 'Software Development'),
(3, 'Fantasy');

-- --------------------------------------------------------

--
-- Table structure for table `Members`
--

DROP TABLE IF EXISTS `Members`;
CREATE TABLE `Members` (
  `memberID` int(11) NOT NULL,
  `name` varchar(145) NOT NULL,
  `email` varchar(145) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Members`
--

INSERT INTO `Members` (`memberID`, `name`, `email`, `phone`) VALUES
(1, 'Alice Smith', 'alice@example.com', '123-456-7890'),
(2, 'Bob Johnson', 'bob@example.com', '987-654-3210'),
(3, 'Carol Davis', 'carol@example.com', '555-123-4567');

-- --------------------------------------------------------

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
CREATE TABLE `Reviews` (
  `reviewID` int(11) NOT NULL,
  `rating` smallint(1) NOT NULL,
  `memberID` int(11) NOT NULL,
  `bookID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Reviews`
--

INSERT INTO `Reviews` (`reviewID`, `rating`, `memberID`, `bookID`) VALUES
(1, 5, 1, 1),
(2, 4, 2, 2),
(3, 5, 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Authors`
--
ALTER TABLE `Authors`
  ADD PRIMARY KEY (`authorID`);

--
-- Indexes for table `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`bookID`,`authorID`),
  ADD KEY `fk_books_authors1_idx` (`authorID`);

--
-- Indexes for table `Books_has_Genres`
--
ALTER TABLE `Books_has_Genres`
  ADD PRIMARY KEY (`bookID`,`genreID`),
  ADD KEY `fk_books_has_genres_genres1_idx` (`genreID`),
  ADD KEY `fk_books_has_genres_books1_idx` (`bookID`);

--
-- Indexes for table `Checkouts`
--
ALTER TABLE `Checkouts`
  ADD PRIMARY KEY (`checkoutID`),
  ADD KEY `fk_checkout_members1_idx` (`memberID`),
  ADD KEY `fk_checkout_books1_idx` (`bookID`);

--
-- Indexes for table `Genres`
--
ALTER TABLE `Genres`
  ADD PRIMARY KEY (`genreID`);

--
-- Indexes for table `Members`
--
ALTER TABLE `Members`
  ADD PRIMARY KEY (`memberID`);

--
-- Indexes for table `Reviews`
--
ALTER TABLE `Reviews`
  ADD PRIMARY KEY (`reviewID`),
  ADD KEY `fk_reviews_members1_idx` (`memberID`),
  ADD KEY `fk_reviews_books1_idx` (`bookID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Authors`
--
ALTER TABLE `Authors`
  MODIFY `authorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Books`
--
ALTER TABLE `Books`
  MODIFY `bookID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Checkouts`
--
ALTER TABLE `Checkouts`
  MODIFY `checkoutID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Genres`
--
ALTER TABLE `Genres`
  MODIFY `genreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Members`
--
ALTER TABLE `Members`
  MODIFY `memberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Reviews`
--
ALTER TABLE `Reviews`
  MODIFY `reviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Books`
--
ALTER TABLE `Books`
  ADD CONSTRAINT `fk_books_authors1` FOREIGN KEY (`authorID`) REFERENCES `Authors` (`authorID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Books_has_Genres`
--
ALTER TABLE `Books_has_Genres`
  ADD CONSTRAINT `fk_books_has_genres_books1` FOREIGN KEY (`bookID`) REFERENCES `Books` (`bookID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_books_has_genres_genres1` FOREIGN KEY (`genreID`) REFERENCES `Genres` (`genreID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Checkouts`
--
ALTER TABLE `Checkouts`
  ADD CONSTRAINT `fk_checkout_books1` FOREIGN KEY (`bookID`) REFERENCES `Books` (`bookID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_checkout_members1` FOREIGN KEY (`memberID`) REFERENCES `Members` (`memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Reviews`
--
ALTER TABLE `Reviews`
  ADD CONSTRAINT `fk_reviews_books1` FOREIGN KEY (`bookID`) REFERENCES `Books` (`bookID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_members1` FOREIGN KEY (`memberID`) REFERENCES `Members` (`memberID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
