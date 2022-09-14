-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 14, 2022 at 09:17 AM
-- Server version: 10.3.34-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `1245`
--

-- --------------------------------------------------------

--
-- Table structure for table `CAFESHOPS`
--

CREATE TABLE `CAFESHOPS` (
  `shopID` int(11) NOT NULL,
  `ShopintDBID` int(11) NOT NULL,
  `SellposX` text NOT NULL,
  `SellposY` text NOT NULL,
  `SellposZ` text NOT NULL,
  `SellDim` int(11) NOT NULL,
  `SellInt` int(11) NOT NULL,
  `ownerCharID` int(11) NOT NULL,
  `Water` int(11) NOT NULL DEFAULT 0,
  `Food` int(11) NOT NULL DEFAULT 0,
  `StockPosX` text NOT NULL DEFAULT '0',
  `StockPosY` text NOT NULL DEFAULT '0',
  `StockPosZ` text NOT NULL DEFAULT '0',
  `StockDim` int(11) NOT NULL DEFAULT 0,
  `StockInt` int(11) NOT NULL DEFAULT 0,
  `stockID` int(10) NOT NULL DEFAULT 0,
  `createdBY` text NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `CAFESHOPS`
--

INSERT INTO `CAFESHOPS` (`shopID`, `ShopintDBID`, `SellposX`, `SellposY`, `SellposZ`, `SellDim`, `SellInt`, `ownerCharID`, `Water`, `Food`, `StockPosX`, `StockPosY`, `StockPosZ`, `StockDim`, `StockInt`, `stockID`, `createdBY`) VALUES
(1, 1887, '374.714844', '-118.807617', '1001.499512', 1887, 5, 306, 99999975, 99999978, '2457.5166015625', '-2536.3779296875', '1095.4331054688', 1890, 6, 1, 'yoza12--306');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CAFESHOPS`
--
ALTER TABLE `CAFESHOPS`
  ADD PRIMARY KEY (`shopID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CAFESHOPS`
--
ALTER TABLE `CAFESHOPS`
  MODIFY `shopID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
