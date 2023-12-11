-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: localhost    Database: project_roofs
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation` (
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `donation_date` date NOT NULL,
  `donation_description` varchar(1000) NOT NULL,
  `shelter_name` varchar(128) NOT NULL,
  KEY `shelter_name` (`shelter_name`),
  CONSTRAINT `donation_ibfk_1` FOREIGN KEY (`shelter_name`) REFERENCES `shelter` (`shelter_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation`
--

LOCK TABLES `donation` WRITE;
/*!40000 ALTER TABLE `donation` DISABLE KEYS */;
INSERT INTO `donation` VALUES ('Mack','Birch','2023-12-01','Meal for 20 people','Boston Community Shelter'),('Jack','Mullins','2023-12-02','Christmas gifts for 20 people','Boston Community Shelter'),('Veronica','Sanders','2023-11-30','Knitted sweaters for the elderly','Brigham Shelter'),('Mia','Martin','2023-11-28','Chocolates for everyone','Brigham Shelter'),('Sal','King','2023-12-05','Snow shoes','Holy Hearts Shelter'),('Daniel','Scott','2023-12-08','Groceries','Holy Hearts Shelter');
/*!40000 ALTER TABLE `donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pr_admin`
--

DROP TABLE IF EXISTS `pr_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pr_admin` (
  `email_id` varchar(128) NOT NULL,
  `username` varchar(128) NOT NULL,
  `admin_password` varbinary(255) NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pr_admin`
--

LOCK TABLES `pr_admin` WRITE;
/*!40000 ALTER TABLE `pr_admin` DISABLE KEYS */;
INSERT INTO `pr_admin` VALUES ('belai.d@northeastern.edu','dhruvbelai',0xF24C35E5E0D57BF53F0F8B2A48CE12C2),('chris.k@gmail.com','chrisk',0x0DE5DD11206057694A788641F82DD1C6),('downey.r@northeastern.edu','robertdowney',0xBBE97BC4A57E37250510CC0E77DC5035),('kelly.c@northeastern.edu','kellyc',0x0DE5DD11206057694A788641F82DD1C6),('khubani.l@neu.edu','luv',0x0DE5DD11206057694A788641F82DD1C6),('rohit.s@neu.edu','rohit',0x0DE5DD11206057694A788641F82DD1C6),('saloni.k@umass.edu','sk',0x0DE5DD11206057694A788641F82DD1C6),('shellyk@northeastern.edu','shellyk',0x13997C2CAAB384F04084C1971951CF62),('venkat.p@northeastern.edu','padmavenkat',0xBBE2DD0380CE749FFEED48ED11CD3047);
/*!40000 ALTER TABLE `pr_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resident`
--

DROP TABLE IF EXISTS `resident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resident` (
  `resident_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `shelter_name` varchar(128) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `join_date` date NOT NULL,
  `leave_date` date DEFAULT NULL,
  PRIMARY KEY (`resident_id`),
  KEY `shelter_name` (`shelter_name`),
  CONSTRAINT `resident_ibfk_1` FOREIGN KEY (`shelter_name`) REFERENCES `shelter` (`shelter_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `resident_chk_1` CHECK (regexp_like(`phone_no`,_utf8mb4'^[0-9+()-]*$'))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resident`
--

LOCK TABLES `resident` WRITE;
/*!40000 ALTER TABLE `resident` DISABLE KEYS */;
INSERT INTO `resident` VALUES (1,'Smith','Roberts','Brigham Shelter','Male','1954-10-19','+1(932)-129-3340','2023-11-25','2023-12-07'),(2,'Shelly','Martin','Boston Community Shelter','Transgender','1984-12-13','+1(431)-120-1230','2023-11-20',NULL),(3,'Cassie','Johnson','Holy Hearts Shelter','Female','1990-03-01','+1(585)-789-0910','2023-10-31','2023-12-02'),(4,'Isac','King','Boston Community Shelter','Male','1972-01-07','+1(832)-191-0091','2023-10-24','2023-12-01'),(5,'Baljeet','Singh','Brigham Shelter','Male','1960-08-10','+1(657)-231-9981','2023-12-01',NULL),(6,'Amelia','Lens','Holy Hearts Shelter','Female','1992-05-18','+1(556)-856-6790','2023-10-20',NULL),(10,'John','Newman','Brigham Shelter','Male','1989-06-01','+1(990)-109-2384','2023-12-05','2023-12-07'),(12,'John','Smith','Boston Community Shelter','Male','2001-09-09','+1(867)-907-9807','2023-11-01',NULL);
/*!40000 ALTER TABLE `resident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resident_employment`
--

DROP TABLE IF EXISTS `resident_employment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resident_employment` (
  `resident_id` int DEFAULT NULL,
  `employment_status` tinyint(1) NOT NULL,
  `employer_name` varchar(255) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `employment_begin` date DEFAULT NULL,
  `employment_end` date DEFAULT NULL,
  KEY `resident_id` (`resident_id`),
  CONSTRAINT `resident_employment_ibfk_1` FOREIGN KEY (`resident_id`) REFERENCES `resident` (`resident_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resident_employment_chk_1` CHECK ((((`employment_status` = true) and (`employer_name` is not null) and (`job_title` is not null) and (`employment_begin` is not null)) or ((`employment_status` = false) and (`employer_name` is null) and (`job_title` is null) and (`employment_begin` is null) and (`employment_end` is null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resident_employment`
--

LOCK TABLES `resident_employment` WRITE;
/*!40000 ALTER TABLE `resident_employment` DISABLE KEYS */;
INSERT INTO `resident_employment` VALUES (1,0,NULL,NULL,NULL,NULL),(2,1,'Aldi','Associate','2023-12-01',NULL),(3,0,NULL,NULL,NULL,NULL),(4,1,'Stop and Shop','Store Employee','2023-05-01',NULL),(5,1,'Wamart','Cashier','2023-10-10',NULL),(6,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `resident_employment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resident_health`
--

DROP TABLE IF EXISTS `resident_health`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resident_health` (
  `resident_id` int DEFAULT NULL,
  `health_report_date` date NOT NULL,
  `health_report_details` varchar(1000) NOT NULL,
  `resident_condition` varchar(512) DEFAULT NULL,
  `resident_allergies` varchar(512) DEFAULT NULL,
  `resident_medication` varchar(512) DEFAULT NULL,
  KEY `resident_id` (`resident_id`),
  CONSTRAINT `resident_health_ibfk_1` FOREIGN KEY (`resident_id`) REFERENCES `resident` (`resident_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resident_health`
--

LOCK TABLES `resident_health` WRITE;
/*!40000 ALTER TABLE `resident_health` DISABLE KEYS */;
INSERT INTO `resident_health` VALUES (1,'2023-11-26','Sustained head injuries','Low Blood Pressure',NULL,'Painkillers'),(2,'2023-11-21','Dental issues','Asthama','Peanuts','Cavity Evictor'),(3,'2023-11-01','In good health',NULL,NULL,NULL),(4,'2023-10-25','Heart related issues, must avoid extreme physical activities','Blood Sugar High','Clam','Heart Aid'),(5,'2023-12-02','In good health',NULL,NULL,NULL),(6,'2023-11-01','In good health',NULL,NULL,NULL),(12,'2023-12-07','Weak legs','Calcium Deficiency','','Calcium tablet'),(12,'2023-12-07','Leg cramps and weak bones','Calcium deficiency','','Calcium tablet');
/*!40000 ALTER TABLE `resident_health` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `service_name` varchar(255) NOT NULL,
  PRIMARY KEY (`service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES ('Beds'),('Counselling'),('Exercise'),('Yoga');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelter`
--

DROP TABLE IF EXISTS `shelter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelter` (
  `shelter_name` varchar(128) NOT NULL,
  `street_no` varchar(10) NOT NULL,
  `street_name` varchar(128) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(64) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `max_capacity` int NOT NULL,
  PRIMARY KEY (`shelter_name`),
  CONSTRAINT `shelter_chk_1` CHECK (regexp_like(`zipcode`,_utf8mb4'^[0-9]{5}(-[0-9]{4})?$')),
  CONSTRAINT `shelter_chk_2` CHECK (regexp_like(`phone_no`,_utf8mb4'^[0-9+()-]*$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter`
--

LOCK TABLES `shelter` WRITE;
/*!40000 ALTER TABLE `shelter` DISABLE KEYS */;
INSERT INTO `shelter` VALUES ('Boston Community Shelter','128','Smith St.','Boston','Massachusetts','02189','+1(762)-123-4567',120),('Brigham Shelter','1280','Tremont St.','Boston','Massachusetts','02120','+1(552)-123-4567',300),('Holy Hearts Shelter','551','Huntington Ave.','Boston','Massachusetts','02115','+1(890)-123-4567',120);
/*!40000 ALTER TABLE `shelter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelter_service`
--

DROP TABLE IF EXISTS `shelter_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelter_service` (
  `service_name` varchar(255) NOT NULL,
  `shelter_name` varchar(128) NOT NULL,
  KEY `service_name` (`service_name`),
  KEY `shelter_name` (`shelter_name`),
  CONSTRAINT `shelter_service_ibfk_1` FOREIGN KEY (`service_name`) REFERENCES `service` (`service_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shelter_service_ibfk_2` FOREIGN KEY (`shelter_name`) REFERENCES `shelter` (`shelter_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter_service`
--

LOCK TABLES `shelter_service` WRITE;
/*!40000 ALTER TABLE `shelter_service` DISABLE KEYS */;
INSERT INTO `shelter_service` VALUES ('Beds','Boston Community Shelter'),('Beds','Holy Hearts Shelter'),('Beds','Brigham Shelter'),('Counselling','Boston Community Shelter'),('Counselling','Brigham Shelter'),('Exercise','Boston Community Shelter'),('Exercise','Brigham Shelter'),('Yoga','Brigham Shelter'),('Yoga','Boston Community Shelter');
/*!40000 ALTER TABLE `shelter_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteer`
--

DROP TABLE IF EXISTS `volunteer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteer` (
  `volunteer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone_no` varchar(20) NOT NULL,
  PRIMARY KEY (`volunteer_id`),
  CONSTRAINT `volunteer_chk_1` CHECK (regexp_like(`phone_no`,_utf8mb4'^[0-9+()-]*$'))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteer`
--

LOCK TABLES `volunteer` WRITE;
/*!40000 ALTER TABLE `volunteer` DISABLE KEYS */;
INSERT INTO `volunteer` VALUES (2,'Daniel','Lawrence','+1(232)-459-7651'),(3,'John','Fitzgerald','+1(769)-123-4060');
/*!40000 ALTER TABLE `volunteer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteer_shelter`
--

DROP TABLE IF EXISTS `volunteer_shelter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteer_shelter` (
  `volunteer_id` int NOT NULL,
  `shelter_name` varchar(128) NOT NULL,
  KEY `volunteer_id` (`volunteer_id`),
  KEY `shelter_name` (`shelter_name`),
  CONSTRAINT `volunteer_shelter_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteer` (`volunteer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `volunteer_shelter_ibfk_2` FOREIGN KEY (`shelter_name`) REFERENCES `shelter` (`shelter_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteer_shelter`
--

LOCK TABLES `volunteer_shelter` WRITE;
/*!40000 ALTER TABLE `volunteer_shelter` DISABLE KEYS */;
INSERT INTO `volunteer_shelter` VALUES (2,'Boston Community Shelter'),(3,'Brigham Shelter'),(3,'Holy Hearts Shelter');
/*!40000 ALTER TABLE `volunteer_shelter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'project_roofs'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddDonationToShelter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDonationToShelter`(
    IN first_name_p VARCHAR(255),
    IN last_name_p VARCHAR(255),
    IN donation_date_p DATE,
    IN donation_description_p VARCHAR(255),
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    INSERT INTO donation (first_name, last_name, donation_date, donation_description, shelter_name)
    VALUES (first_name_p, last_name_p, donation_date_p, donation_description_p, shelter_name_p);
    SELECT '\nDonation added successfully.' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddHealthReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddHealthReport`(
    IN shelter_name_p VARCHAR(128),
    IN health_report_details_p VARCHAR(1000),
    IN resident_conditions_p VARCHAR(255),
    IN resident_allergies_p VARCHAR(255),
    IN resident_medication_p VARCHAR(255)
)
BEGIN
    DECLARE latest_resident_id INT;
    DECLARE join_date_resident DATE;

    SELECT resident_id, join_date INTO latest_resident_id, join_date_resident
    FROM resident
    WHERE shelter_name = shelter_name_p
    ORDER BY resident_id DESC
    LIMIT 1;

    INSERT INTO resident_health (resident_id, health_report_date, health_report_details, resident_condition, resident_allergies, resident_medication)
    VALUES (latest_resident_id, join_date_resident, health_report_details_p, resident_conditions_p, resident_allergies_p, resident_medication_p);

    SELECT '\nHealth report added successfully.' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddResidentEmploymentRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddResidentEmploymentRecord`(
    IN shelter_name_p VARCHAR(255),
    IN employment_status_p BOOLEAN,
    IN employer_name_p VARCHAR(255),
    IN job_title_p VARCHAR(255),
    IN employment_begin_date_p DATE,
    IN employment_end_date_p DATE
)
BEGIN
    DECLARE latest_resident_id INT;

    SELECT MAX(resident_id) INTO latest_resident_id
    FROM resident
    WHERE shelter_name = shelter_name_p;

    INSERT INTO resident_employment (resident_id, employment_status, employer_name, job_title, employment_begin, employment_end)
    VALUES (
        latest_resident_id,
        employment_status_p,
        employer_name_p,
        job_title_p,
        employment_begin_date_p,
        employment_end_date_p
    );
    SELECT '\nResident employment record added successfully.' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddResidentHealthRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddResidentHealthRecord`(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255),
    IN health_report_date_p DATE,
    IN health_report_details_p VARCHAR(255),
    IN resident_conditions_p VARCHAR(255),
    IN resident_allergies_p VARCHAR(255),
    IN resident_medications_p VARCHAR(255)
)
BEGIN
    DECLARE resident_shelter_name VARCHAR(255);

    SELECT shelter_name INTO resident_shelter_name
    FROM resident
    WHERE resident_id = resident_id_p
    LIMIT 1;  

    IF resident_shelter_name = shelter_name_p THEN
        INSERT INTO resident_health (
            resident_id,
            health_report_date,
            health_report_details,
            resident_condition,
            resident_allergies,
            resident_medication
        )
        VALUES (
            resident_id_p,
            health_report_date_p,
            health_report_details_p,
            resident_conditions_p,
            resident_allergies_p,
            resident_medications_p
        );

        SELECT '\nResident health record added successfully.' AS status;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteVolunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteVolunteer`(
    IN volunteer_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE volunteer_shelter_name VARCHAR(255);

    SELECT shelter_name INTO volunteer_shelter_name
    FROM volunteer_shelter
    WHERE volunteer_id = volunteer_id_p
    LIMIT 1;

    IF volunteer_shelter_name = shelter_name_p THEN
        DELETE FROM volunteer
        WHERE volunteer_id = volunteer_id_p;

        SELECT '\nVolunteer record deleted successfully.' AS status;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the volunteer\'s shelter.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllAdmins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllAdmins`()
BEGIN
    SELECT email_id, username, CAST(AES_DECRYPT(admin_password, 'CS5200') AS CHAR) AS pass
    FROM pr_admin;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllShelters` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllShelters`()
BEGIN
    SELECT * FROM shelter;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetGenderDistribution` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGenderDistribution`()
BEGIN
    SELECT gender, COUNT(*) as gender_count
    FROM resident
    GROUP BY gender;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetJoinCountByDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJoinCountByDate`()
BEGIN
    SELECT join_date, COUNT(*) AS join_count
    FROM resident
    GROUP BY join_date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetResidentCountByShelter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetResidentCountByShelter`()
BEGIN
    SELECT
        shelter_name,
        COUNT(*) AS resident_count
    FROM resident
    GROUP BY shelter_name
    ORDER BY shelter_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetShelterStatistics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetShelterStatistics`(IN shelter_name_p VARCHAR(255))
BEGIN
    DECLARE resident_count INT;
    DECLARE donation_count INT;
    DECLARE volunteer_count INT;
    DECLARE services_list VARCHAR(255);

	SELECT COUNT(*) INTO resident_count
	FROM resident
	WHERE shelter_name = shelter_name_p 
	AND (leave_date IS NULL OR leave_date > CURRENT_DATE);

    SELECT COUNT(*) INTO donation_count
    FROM donation
    WHERE shelter_name = shelter_name_p;

    SELECT COUNT(DISTINCT volunteer_id) INTO volunteer_count
    FROM volunteer_shelter
    WHERE shelter_name = shelter_name_p;

    SELECT GROUP_CONCAT(DISTINCT service_name) INTO services_list
    FROM shelter_service
    WHERE shelter_name = shelter_name_p;

    SELECT
        resident_count AS 'Number of Residents',
        donation_count AS 'Number of Donations',
        volunteer_count AS 'Number of Volunteers',
        services_list AS 'Services Provided'
    FROM DUAL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertNewAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewAdmin`(
    IN admin_email VARCHAR(255),
    IN admin_username VARCHAR(255),
    IN admin_password VARCHAR(255)
)
BEGIN
    DECLARE hashed_password VARBINARY(255);
    SET hashed_password = AES_ENCRYPT(admin_password, 'CS5200');
    INSERT INTO pr_admin (email_id, username, admin_password)
    VALUES (admin_email, admin_username, hashed_password);
    
    SELECT "\nNew admin added successfully" AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertNewResident` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewResident`(
    IN first_name_p VARCHAR(255),
    IN last_name_p VARCHAR(255),
    IN shelter_name_p VARCHAR(255),
    IN gender_p VARCHAR(20),
    IN dob_p DATE,
    IN phone_no_p VARCHAR(20),
    IN join_date_p DATE
)
BEGIN
    DECLARE new_resident_id INT;

    IF join_date_p > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid join date. Please enter a date not greater than the current date.';
    ELSE
        INSERT INTO resident (first_name, last_name, shelter_name, gender, dob, phone_no, join_date)
        VALUES (first_name_p, last_name_p, shelter_name_p, gender_p, dob_p, phone_no_p, join_date_p);
        SELECT LAST_INSERT_ID() INTO new_resident_id;
    END IF;
    SELECT new_resident_id AS new_resident_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertVolunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertVolunteer`(
    IN first_name_p VARCHAR(255),
    IN last_name_p VARCHAR(255),
    IN phone_no_p VARCHAR(20),
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE volunteer_id INT;

    INSERT INTO volunteer (first_name, last_name, phone_no)
    VALUES (first_name_p, last_name_p, phone_no_p);

    SELECT LAST_INSERT_ID() INTO volunteer_id;

    INSERT INTO volunteer_shelter (volunteer_id, shelter_name)
    VALUES (volunteer_id, shelter_name_p);

    SELECT '\nVolunteer added successfully.' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RemoveResident` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoveResident`(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);

    SELECT shelter_name INTO shelter_name_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db IS NOT NULL AND shelter_name_db = shelter_name_p THEN
        DELETE FROM resident
        WHERE resident_id = resident_id_p;

        SELECT '\nResident removed successfully.' AS status;
    ELSE
        SELECT '\nError: Resident not found or not part of the specified shelter.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateLeaveDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateLeaveDate`(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255),
    IN leave_date_p DATE
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);
    DECLARE join_date_db DATE;

    SELECT shelter_name, join_date INTO shelter_name_db, join_date_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db = shelter_name_p THEN
        IF leave_date_p IS NOT NULL AND leave_date_p <= CURRENT_DATE AND leave_date_p >= join_date_db THEN
            UPDATE resident
            SET leave_date = leave_date_p
            WHERE resident_id = resident_id_p;

            SELECT '\nLeave date updated successfully.' AS status;
        ELSE
            SELECT '\nError: Invalid leave date. Leave date must be less than or same as current date and greater than or equal to join date.' AS status;
        END IF;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateResidentEmploymentRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateResidentEmploymentRecord`(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255),
    IN employment_status_p BOOLEAN,
    IN employer_name_p VARCHAR(255),
    IN job_title_p VARCHAR(255),
    IN employment_begin_date_p DATE,
    IN employment_end_date_p DATE
)
BEGIN
    DECLARE matching_records_count INT;
    SELECT COUNT(*)
    INTO matching_records_count
    FROM resident
    WHERE resident_id = resident_id_p AND shelter_name = shelter_name_p;

    IF matching_records_count > 0 THEN
        UPDATE resident_employment
        SET
            employment_status = employment_status_p,
            employer_name = employer_name_p,
            job_title = job_title_p,
            employment_begin = employment_begin_date_p,
            employment_end = employment_end_date_p
        WHERE resident_id = resident_id_p;

        SELECT '\nResident employment record updated successfully.' AS status;
    ELSE
        SELECT '\nError: Provided Resident ID or Shelter Name does not match the existing records.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewEmploymentRecords` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewEmploymentRecords`(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);

    SELECT shelter_name INTO shelter_name_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db = shelter_name_p THEN
        SELECT *
        FROM resident_employment
        WHERE resident_id = resident_id_p;

    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewHealthRecords` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewHealthRecords`(
    IN resident_id_p INT,
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    DECLARE shelter_name_db VARCHAR(255);

    SELECT shelter_name INTO shelter_name_db
    FROM resident
    WHERE resident_id = resident_id_p;

    IF shelter_name_db IS NOT NULL AND shelter_name_db = shelter_name_p THEN
        SELECT health_report_date, health_report_details, resident_condition, resident_allergies, resident_medication
        FROM resident_health
        WHERE resident_id = resident_id_p;
    ELSE
        SELECT '\nError: Provided Shelter Name does not match the resident\'s shelter.' AS status;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewPastResidentsInShelter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewPastResidentsInShelter`(IN shelter_name_p VARCHAR(255))
BEGIN
    SELECT
		resident_id AS id,
        first_name AS FirstName,
        last_name AS LastName,
        gender AS Gender,
        TIMESTAMPDIFF(YEAR, dob, CURRENT_DATE) AS Age,
        phone_no AS PhoneNumber,
        join_date AS JoinDate,
        leave_date AS LeaveDate
    FROM resident
    WHERE shelter_name = shelter_name_p
    AND (leave_date IS NOT NULL OR leave_date < CURRENT_DATE);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewResidentsInShelter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewResidentsInShelter`(IN shelter_name_p VARCHAR(255))
BEGIN
    SELECT
        resident_id AS id,
        first_name AS FirstName,
        last_name AS LastName,
        gender AS Gender,
        TIMESTAMPDIFF(YEAR, dob, CURRENT_DATE) AS Age,
        phone_no AS PhoneNumber,
        join_date AS JoinDate,
        leave_date AS LeaveDate
    FROM resident
    WHERE shelter_name = shelter_name_p
    AND (leave_date IS NULL OR leave_date > CURRENT_DATE);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewShelterDonations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewShelterDonations`(
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    SELECT first_name, last_name, donation_date, donation_description
    FROM donation
    WHERE shelter_name = shelter_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewShelterVolunteers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewShelterVolunteers`(
    IN shelter_name_p VARCHAR(255)
)
BEGIN
    SELECT v.volunteer_id, v.first_name, v.last_name, v.phone_no
    FROM volunteer v
    INNER JOIN volunteer_shelter vs ON v.volunteer_id = vs.volunteer_id
    WHERE vs.shelter_name = shelter_name_p;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 18:06:27
