-- MySQL dump 10.13  Distrib 8.0.16, for Linux (x86_64)
--
-- Host: localhost    Database: asset_manager
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` enum('individual','public') NOT NULL,
  `model` varchar(100) NOT NULL,
  `maker` varchar(100) NOT NULL,
  `year` year(4) NOT NULL,
  `price` decimal(10,0) unsigned NOT NULL,
  `warrenty` date DEFAULT NULL,
  `status` enum('available','assigned','in_repair') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'iPhone','individual','7','Apple Inc.',2010,45000,'2011-01-01','available'),(2,'iPhone','individual','8','Apple Inc.',2012,55000,'2014-01-01','available'),(3,'iPad','individual','mini','Apple Inc.',2013,40000,'2014-01-01','available'),(4,'projector','individual','10DX','Cannon Inc.',2008,30000,'2011-01-01','available'),(5,'printer','public','asdf12','Hawaei',2010,41000,'2013-01-01','available'),(6,'router','public','asdf12','Hawaei',2010,41000,'2013-01-01','available'),(7,'modem','public','asdf12','Hawaei',2010,41000,'2013-01-01','available'),(8,'Laptop A','individual','xps','Dell',2011,50000,'2011-01-01','assigned'),(9,'Laptop B','individual','xps','Dell',2011,50000,'2011-01-01','available'),(10,'Laptop N1','individual','xps','Dell',2011,50000,'2011-01-01','available'),(11,'Laptop N2','individual','xps','Dell',2011,50000,'2011-01-01','available'),(12,'iPhone A','individual','6s','Apple',2010,40000,'2011-04-01','assigned'),(13,'iPhone B','individual','6s','Apple',2010,40000,'2011-08-01','assigned'),(14,'Projector A','public','asxz','Some',2010,10000,'2011-08-15','available'),(15,'Printer A','public','asxz','Some Prints',2010,10000,'2011-08-15','available'),(16,'Printer B','public','asxz','Some Prints',2010,10000,'2011-09-10','available');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Alice'),(2,'Bob'),(3,'Chris'),(4,'Duke'),(5,'Emily');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `management_logs`
--

DROP TABLE IF EXISTS `management_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `management_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `assigned_on` datetime NOT NULL,
  `released_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `management_logs_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`),
  CONSTRAINT `management_logs_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `management_logs`
--

LOCK TABLES `management_logs` WRITE;
/*!40000 ALTER TABLE `management_logs` DISABLE KEYS */;
INSERT INTO `management_logs` VALUES (3,8,1,'2011-01-01 00:00:00','2011-12-31'),(4,8,2,'2012-01-01 00:00:00',NULL),(6,9,2,'2011-01-01 00:00:00','2011-12-31'),(7,10,1,'2011-04-01 00:00:00',NULL),(8,11,2,'2011-08-01 00:00:00',NULL);
/*!40000 ALTER TABLE `management_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repairs`
--

DROP TABLE IF EXISTS `repairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `repairs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `cost` decimal(10,0) unsigned NOT NULL,
  `description` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `repairs_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repairs`
--

LOCK TABLES `repairs` WRITE;
/*!40000 ALTER TABLE `repairs` DISABLE KEYS */;
INSERT INTO `repairs` VALUES (1,4,5000,'Lens was damaged'),(2,7,2000,'Hardware issue');
/*!40000 ALTER TABLE `repairs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-25 11:30:06
