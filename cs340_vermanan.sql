-- phpMyAdmin SQL Dump
-- version 5.2.2-1.el9.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 03, 2025 at 08:28 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `idbook` int(11) NOT NULL,
  `title` varchar(145) NOT NULL,
  `author` varchar(145) NOT NULL,
  `ischeckedout` tinyint(1) NOT NULL DEFAULT 0,
  `genre_idgenre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`idbook`, `title`, `author`, `ischeckedout`, `genre_idgenre`) VALUES
(1, 'The Hobbit', 'J.R.R. Tolkien', 0, 1),
(2, 'Dune', 'Frank Herbert', 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `idcheckout` int(11) NOT NULL,
  `members_idmember` int(11) NOT NULL,
  `books_idbook` int(11) NOT NULL,
  `duedate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `idgenre` int(11) NOT NULL,
  `description` varchar(145) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`idgenre`, `description`) VALUES
(1, 'thriller'),
(2, 'mystery'),
(3, 'horror');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `idmember` int(11) NOT NULL,
  `name` varchar(145) NOT NULL,
  `email` varchar(145) NOT NULL,
  `phone` smallint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`idmember`, `name`, `email`, `phone`) VALUES
(1, 'anil verman', 'testemail', 123),
(2, 'manjit verman', 'testemail', 234);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `idreview` int(11) NOT NULL,
  `rating` smallint(1) NOT NULL,
  `members_idmember` int(11) NOT NULL,
  `books_idbook` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`idbook`),
  ADD KEY `fk_books_genre_idx` (`genre_idgenre`);

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`idcheckout`),
  ADD KEY `fk_checkout_members1_idx` (`members_idmember`),
  ADD KEY `fk_checkout_books1_idx` (`books_idbook`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`idgenre`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`idmember`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`idreview`),
  ADD KEY `fk_reviews_members1_idx` (`members_idmember`),
  ADD KEY `fk_reviews_books1_idx` (`books_idbook`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `idbook` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `idcheckout` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `idgenre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `idmember` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `idreview` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `fk_books_genre` FOREIGN KEY (`genre_idgenre`) REFERENCES `genre` (`idgenre`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `checkout`
--
ALTER TABLE `checkout`
  ADD CONSTRAINT `fk_checkout_books1` FOREIGN KEY (`books_idbook`) REFERENCES `books` (`idbook`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_checkout_members1` FOREIGN KEY (`members_idmember`) REFERENCES `members` (`idmember`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_books1` FOREIGN KEY (`books_idbook`) REFERENCES `books` (`idbook`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reviews_members1` FOREIGN KEY (`members_idmember`) REFERENCES `members` (`idmember`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
