-- --------------------------------------------------------
-- Host:                         127.0.0.2
-- Versión del servidor:         10.1.25-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para test
DROP DATABASE IF EXISTS `test`;
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `test`;

-- Volcando estructura para tabla test.author
DROP TABLE IF EXISTS `author`;
CREATE TABLE IF NOT EXISTS `author` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla test.author: ~2 rows (aproximadamente)
DELETE FROM `author`;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` (`author_id`, `name`) VALUES
	(1, 'Atanas Kambitov'),
	(2, 'Asen Kambitov');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;

-- Volcando estructura para tabla test.books
DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id_book` int(5) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `year` date NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id_book`),
  KEY `FK_books_author` (`author_id`),
  CONSTRAINT `FK_books_author` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla test.books: ~10 rows (aproximadamente)
DELETE FROM `books`;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` (`id_book`, `title`, `year`, `author_id`) VALUES
	(1, 'a history of earth', '2017-07-31', 1),
	(2, 'national geography', '2017-08-01', 1),
	(3, 'languges', '2017-08-02', 1),
	(4, 'mathematics', '2017-08-03', 1),
	(5, 'mathematics1', '2017-08-04', 1),
	(6, 'mathematics2', '2017-08-05', 1),
	(7, 'mathematics3', '2017-08-06', 1),
	(8, 'mathematics4', '2017-08-07', 1),
	(9, 'mathematics5', '2017-08-08', 1),
	(10, 'mathematics6', '2017-08-09', 1);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;

-- Volcando estructura para tabla test.download
DROP TABLE IF EXISTS `download`;
CREATE TABLE IF NOT EXISTS `download` (
  `id_download` int(3) NOT NULL AUTO_INCREMENT,
  `hit_count` int(3) NOT NULL,
  `book_id` int(3) NOT NULL,
  PRIMARY KEY (`id_download`),
  KEY `FK_download_books` (`book_id`),
  CONSTRAINT `FK_download_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id_book`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla test.download: ~0 rows (aproximadamente)
DELETE FROM `download`;
/*!40000 ALTER TABLE `download` DISABLE KEYS */;
/*!40000 ALTER TABLE `download` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
