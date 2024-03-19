-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2023 at 02:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `salesman`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CUSTOMER_ID` int(11) NOT NULL,
  `CUST_NAME` varchar(25) NOT NULL,
  `CITY` varchar(15) NOT NULL,
  `GRADE` int(11) NOT NULL,
  `SALESMAN_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CUSTOMER_ID`, `CUST_NAME`, `CITY`, `GRADE`, `SALESMAN_ID`) VALUES
(501, 'GANESH', 'MANDYA', 2, 101);

-- --------------------------------------------------------

--
-- Stand-in structure for view `highorder`
-- (See below for the actual view)
--
CREATE TABLE `highorder` (
`SALESMAN_ID` int(11)
,`CUSTOMER_ID` int(11)
,`PURCHASE_AMT` int(11)
,`ORD_DATE` date
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ORD_NO` int(11) NOT NULL,
  `PURCHASE_AMT` int(11) NOT NULL,
  `ORD_DATE` date NOT NULL,
  `CUSTOMER_ID` int(11) DEFAULT NULL,
  `SALESMAN_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`ORD_NO`, `PURCHASE_AMT`, `ORD_DATE`, `CUSTOMER_ID`, `SALESMAN_ID`) VALUES
(1001, 4500, '2021-12-12', 501, 101);

-- --------------------------------------------------------

--
-- Table structure for table `salesman`
--

CREATE TABLE `salesman` (
  `SALESMAN_ID` int(11) NOT NULL,
  `NAME` varchar(25) NOT NULL,
  `CITY` varchar(15) NOT NULL,
  `COMMISSION` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salesman`
--

INSERT INTO `salesman` (`SALESMAN_ID`, `NAME`, `CITY`, `COMMISSION`) VALUES
(101, 'JHON', 'MYSORE', 10);

-- --------------------------------------------------------

--
-- Structure for view `highorder`
--
DROP TABLE IF EXISTS `highorder`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `highorder`  AS SELECT `x`.`SALESMAN_ID` AS `SALESMAN_ID`, `x`.`CUSTOMER_ID` AS `CUSTOMER_ID`, `x`.`PURCHASE_AMT` AS `PURCHASE_AMT`, `x`.`ORD_DATE` AS `ORD_DATE` FROM `orders` AS `x` WHERE `x`.`PURCHASE_AMT` = (select max(`y`.`PURCHASE_AMT`) from `orders` `y` where `x`.`ORD_DATE` = `y`.`ORD_DATE`) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CUSTOMER_ID`),
  ADD KEY `SALESMAN_ID` (`SALESMAN_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ORD_NO`),
  ADD KEY `CUSTOMER_ID` (`CUSTOMER_ID`),
  ADD KEY `SALESMAN_ID` (`SALESMAN_ID`);

--
-- Indexes for table `salesman`
--
ALTER TABLE `salesman`
  ADD PRIMARY KEY (`SALESMAN_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`SALESMAN_ID`) REFERENCES `salesman` (`SALESMAN_ID`) ON DELETE SET NULL;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customer` (`CUSTOMER_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`SALESMAN_ID`) REFERENCES `salesman` (`SALESMAN_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
