-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.27-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping structure for table vorpcore_34e5f3.invoices
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(50) NOT NULL,
  `sender_name` varchar(100) NOT NULL,
  `sender_job` varchar(50) NOT NULL,
  `receiver_id` varchar(50) NOT NULL,
  `receiver_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(10) DEFAULT 'Unpaid',
  `paid_date` datetime DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table vorpcore_34e5f3.invoices: ~2 rows (approximately)
REPLACE INTO `invoices` (`id`, `sender_id`, `sender_name`, `sender_job`, `receiver_id`, `receiver_name`, `description`, `amount`, `created_at`, `status`, `paid_date`, `created_date`) VALUES
	(26, '1', 'Romeo Lu', 'saloon', '1', 'Romeo Lu', 'asdasdasda', 120.00, '2024-08-18 12:12:20', 'Paid', '2024-08-18 18:16:52', '2024-08-20 08:23:04'),
	(27, '1', 'Romeo Lu', 'saloon', '1', 'Romeo Lu', 'asdasdasda twetwe twet wet', 11.00, '2024-08-18 12:13:23', 'Paid', '2024-08-18 17:43:50', '2024-08-20 08:23:04');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
