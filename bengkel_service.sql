-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2025 at 10:57 AM
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
-- Database: `bengkel_service`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle_no` varchar(50) NOT NULL,
  `color` varchar(30) NOT NULL,
  `engine_type` varchar(50) NOT NULL,
  `vehicle_type` varchar(50) NOT NULL,
  `service_type` varchar(50) NOT NULL,
  `service_date` varchar(50) NOT NULL,
  `cost` double NOT NULL,
  `status` enum('Pending','Confirmed','Completed') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `user_id`, `vehicle_no`, `color`, `engine_type`, `vehicle_type`, `service_type`, `service_date`, `cost`, `status`) VALUES
(18, 8, '1234', 'Blue', 'Nitro', 'Motorbike', 'Oil Change', '2025-01-02', 60000, 'Pending'),
(19, 8, '1234', 'Blue', 'Nitro', 'Car', 'Engine Check', '2025-01-02', 130000, 'Pending'),
(20, 10, '1234', 'Blue', 'Nitro', 'Car', 'Tire Replacement', '2025-01-31', 180000, 'Pending'),
(21, 8, '234', 'Blue', 'Nitro', 'Motorbike', 'Engine Check', '2025-01-05', 0, 'Pending'),
(23, 10, '234567', 'Violet', 'Nitro', 'Car', 'Oil Change', '2025-01-05', 0, 'Pending'),
(25, 10, '445677666', 'White', 'Nitro', 'Motorbike', 'Oil Change', '2025-01-05', 60000, 'Completed'),
(27, 10, '1234', 'White', 'Nitro', 'Car', 'Tire Replacement', '2025-01-05', 180000, 'Completed'),
(28, 10, '1234', 'White', 'Nitro', 'Car', 'Engine Check', '2025-01-05', 0, 'Pending'),
(29, 10, '999', 'Blue', 'Nitro', 'Motorbike', 'Tire Replacement', '2025-01-05', 0, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `role` enum('ADMIN','CUSTOMER') NOT NULL DEFAULT 'CUSTOMER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `full_name`, `email`, `phone_number`, `role`) VALUES
(8, 'test', '1234', 'Eldwiin', 'test@gmail.com', '1234567', 'CUSTOMER'),
(9, 'carizsm', '1234', 'cahya', 'cahya@gmail.com', '1234567', 'CUSTOMER'),
(10, 'rayyn', '1234', 'Rayyn Derya', 'rayn@gmail.com', '123446', 'CUSTOMER'),
(11, 'admin', '1234', 'admin', 'admin@gmail.com', '1234', 'ADMIN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
