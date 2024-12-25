-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2024 at 03:21 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `2bdsm`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateprice` ()   BEGIN
update products set PRICE = PRICE*1.05;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `ID` int(13) NOT NULL,
  `NAME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`ID`, `NAME`) VALUES
(1, 'IPHONE'),
(2, 'INFINIX'),
(3, 'TECHNO'),
(4, 'Q-MOBILE'),
(5, 'SAMSUNG'),
(6, 'NOKIA'),
(7, 'VIVO'),
(8, 'OPPO'),
(9, 'REALME'),
(10, 'GOOGLE PIXEL');

--
-- Triggers `brands`
--
DELIMITER $$
CREATE TRIGGER `b_bk` AFTER INSERT ON `brands` FOR EACH ROW BEGIN
INSERT INTO brand_backup (description)
VALUES (concat('insert a data into brand table',now()));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brand_backup`
--

CREATE TABLE `brand_backup` (
  `ID` int(11) NOT NULL,
  `description` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ID` int(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `QUANTITY` int(50) NOT NULL,
  `PRICE` int(50) NOT NULL,
  `STATUS` varchar(50) NOT NULL,
  `WARRANTY` int(50) NOT NULL,
  `brand_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ID`, `NAME`, `QUANTITY`, `PRICE`, `STATUS`, `WARRANTY`, `brand_id`) VALUES
(1, 'Samsung Galaxy S23', 10, 230000, 'Available', 1, 5),
(2, 'Nokia X30', 8, 75000, ' Available', 1, 6),
(3, 'Vivo V27 Pro', 10, 115000, 'Available', 1, 7),
(5, 'Samsung Galaxy A14', 15, 55000, 'Available', 1, 5),
(6, 'Samsung Galaxy Z Fold 5', 5, 380000, 'up coming', 1, 5),
(7, 'Nokia G21', 5, 4000, 'Available', 1, 6),
(8, 'Nokia 3310 Classic', 6, 9000, 'Available', 6, 6),
(9, 'Vivo Y22', 7, 38000, 'Available', 1, 7),
(10, 'Vivo X90', 4, 210000, 'up coming', 1, 7),
(11, 'Oppo Find X6 Pro', 6, 220000, ' Available', 1, 8),
(12, 'Oppo A77', 8, 450000, 'Available', 1, 8),
(13, 'Oppo Reno 8', 5, 125000, 'up coming', 1, 8),
(14, ' Realme Narzo 60 Pro', 10, 88000, ' Available', 1, 9),
(15, 'Realme C55', 15, 38000, 'Available', 1, 9),
(16, 'Realme GT 3', 5, 125000, 'up coming', 1, 9),
(17, 'Google Pixel 8', 6, 300000, 'Available', 1, 10),
(18, ' Google Pixel 7a', 6, 160000, 'Available', 1, 10),
(19, ' Google Pixel Fold', 4, 450000, 'up coming', 1, 10),
(20, 'iPhone 15 Pro Max', 7, 570000, 'Available', 1, 1),
(21, 'iPhone 14 Plus', 3, 460000, 'Available', 1, 1),
(22, 'iPhone SE 3rd Gen', 12, 230000, 'Available', 1, 1),
(23, 'Infinix Zero Ultra', 15, 890000, 'Available', 1, 2),
(24, 'Infinix Note 30 VIP', 5, 380000, 'available', 1, 2),
(25, 'Infinix Hot 30i', 5, 75000, 'Available', 1, 2),
(26, 'Techno Phantom V Fold', 8, 280000, 'up coming', 1, 3),
(27, 'Techno Camon 20 Premier', 12, 82000, 'available', 1, 3),
(28, 'Techno Spark 10 Pro', 4, 45000, 'Available', 1, 3),
(29, 'Q-Mobile Noir LT700', 4, 18000, 'Available', 1, 4),
(30, 'Q-Mobile Noir J7', 5, 22000, 'Available', 1, 4),
(31, 'Q-Mobile E3 Dual', 15, 14500, 'Available', 1, 4);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `bk_pro` AFTER DELETE ON `products` FOR EACH ROW BEGIN
    DECLARE pname VARCHAR(30);
    SET pname = OLD.name;
    INSERT INTO brand_backup (description)
    VALUES (CONCAT('The data is deleted from the table, data name is ', pname, ' ', NOW()));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bkup_pro` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
    DECLARE price_old INT;
    DECLARE price_new INT;
    SET price_old = OLD.price;
    SET price_new = NEW.price;
    INSERT INTO brand_backup (description)
    VALUES (CONCAT('The data is updated in the table. The old price of the product was ', price_old, ' and the new price of the product is ', price_new, ' ', NOW()));    
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `brand_backup`
--
ALTER TABLE `brand_backup`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `brand_id` (`brand_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `ID` int(13) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `brand_backup`
--
ALTER TABLE `brand_backup`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
