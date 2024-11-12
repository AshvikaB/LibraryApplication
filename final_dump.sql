CREATE DATABASE  IF NOT EXISTS `minilib_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `minilib_db`;
-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: minilib_db
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_num` int NOT NULL AUTO_INCREMENT,
  `account_state` int NOT NULL,
  `library_id` int NOT NULL,
  `pat_id` int NOT NULL,
  `num_borrowed` int DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`account_num`),
  KEY `pat_id` (`pat_id`),
  KEY `library_id` (`library_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`pat_id`) REFERENCES `patron` (`patronId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`library_id`) REFERENCES `library` (`libraryId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,1,1,1,2,'deshmukh.sq@northeastern.edu'),(2,1,1,1,1,'deshmukh@email.com'),(3,1,1,2,1,'raj.kat@northeastern.edu'),(4,0,1,3,0,'k.durant@northeastern.edu'),(5,1,1,4,12,'rajani.y@northeastern.edu'),(6,1,1,4,0,'rajani@email.com'),(7,1,1,5,3,'anand.y@northeastern.edu'),(8,0,1,5,0,'anand@gmail.com'),(9,1,1,6,1,'hebburshivakumar.e@northeastern.edu'),(10,1,1,7,2,'shash.samv@northeastern.edu'),(11,1,1,8,0,'shash.sanke@northeastern.edu');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `authorId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`authorId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Virginie Morana'),(2,'Virginie Fowler Elbert'),(3,'Virginie Boone'),(4,'Keith Harrell'),(5,'Dan Gutman'),(6,'Jeanne Betancourt'),(7,'Rudolf Steiner'),(8,'Ashvika'),(9,'Mickey Mouse');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authortobook`
--

DROP TABLE IF EXISTS `authortobook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authortobook` (
  `author_tag` int NOT NULL,
  `book_barcode` char(13) NOT NULL,
  PRIMARY KEY (`author_tag`,`book_barcode`),
  KEY `book_barcode` (`book_barcode`),
  CONSTRAINT `authortobook_ibfk_1` FOREIGN KEY (`author_tag`) REFERENCES `author` (`authorId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `authortobook_ibfk_2` FOREIGN KEY (`book_barcode`) REFERENCES `book` (`barcode`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authortobook`
--

LOCK TABLES `authortobook` WRITE;
/*!40000 ALTER TABLE `authortobook` DISABLE KEYS */;
INSERT INTO `authortobook` VALUES (5,'006123477X1'),(5,'006123477X2'),(5,'006123477X3'),(5,'006123477X4'),(5,'006123477X5'),(4,'14019020141'),(4,'14019020142'),(4,'14019020143'),(9,'333333333331'),(2,'48624585310'),(2,'48627730510'),(5,'59002376410'),(5,'59002376420'),(6,'59048583010'),(6,'59048583020'),(6,'59048584930'),(6,'59048584940'),(4,'60507136100'),(4,'60507136200'),(4,'60507136300'),(5,'61234796100'),(5,'61234796200'),(5,'61234796300'),(5,'61234796400'),(5,'61234796500'),(2,'67167203710'),(5,'68987680710'),(5,'68987680720'),(5,'68987884210'),(5,'68987884220'),(1,'78930372810'),(3,'87358849510'),(7,'88010198910');
/*!40000 ALTER TABLE `authortobook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `barcode` char(13) NOT NULL,
  `book_isbn` char(13) NOT NULL,
  `name` varchar(500) NOT NULL,
  `printDate` date DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  PRIMARY KEY (`barcode`),
  KEY `author_id` (`author_id`),
  KEY `account_id` (`account_id`),
  KEY `book_isbn` (`book_isbn`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`authorId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_ibfk_3` FOREIGN KEY (`book_isbn`) REFERENCES `book_details` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('006123477X1','006123477X','Dr. Carbles Is Losing His Marbles! (My Weird School, #19)','2015-12-31',5,11),('006123477X2','006123477X','Dr. Carbles Is Losing His Marbles! (My Weird School, #19)','2016-01-01',5,10),('006123477X3','006123477X','Dr. Carbles Is Losing His Marbles! (My Weird School, #19)','2016-01-02',5,NULL),('006123477X4','006123477X','Dr. Carbles Is Losing His Marbles! (My Weird School, #19)','2016-01-03',5,9),('006123477X5','006123477X','Dr. Carbles Is Losing His Marbles! (My Weird School, #19)','2016-01-04',5,5),('14019020141','1401902014','Attitude Is Everything for Success','2005-02-05',4,6),('14019020142','1401902014','Attitude Is Everything for Success','2017-09-08',4,NULL),('14019020143','1401902014','Attitude Is Everything for Success','2016-05-06',4,NULL),('333333333331','33333333333','Ashmita',NULL,9,NULL),('48624585310','486245853','Orchids of the World Coloring Book','2022-06-09',2,5),('48627730510','486277305','Shell Craft','2019-01-05',2,6),('59002376410','590023764','The Kid Who Became President (Kid President, #2)','2001-03-18',5,1),('59002376420','590023764','The Kid Who Became President (Kid President, #2)','2002-08-03',5,3),('59048583010','590485830','I Want a Pony (Pony Pals, #1)','1995-10-19',6,1),('59048583020','590485830','I Want a Pony (Pony Pals, #1)','2003-10-12',6,2),('59048584930','590485849','A Pony for Keeps (Pony Pals, #2)','2004-04-13',6,NULL),('59048584940','590485849','A Pony for Keeps (Pony Pals, #2)','2006-07-23',6,2),('60507136100','60507136','The Attitude Is Everything Workbook: Strategies and Tools for Developing Personal and Professional Success','2007-03-08',4,5),('60507136200','60507136','The Attitude Is Everything Workbook: Strategies and Tools for Developing Personal and Professional Success','2007-03-10',4,6),('60507136300','60507136','The Attitude Is Everything Workbook: Strategies and Tools for Developing Personal and Professional Success','2008-03-08',4,NULL),('61234796100','61234796','Mr. Louie Is Screwy! (My Weird School, #20)','2014-07-07',5,10),('61234796200','61234796','Mr. Louie Is Screwy! (My Weird School, #20)','2014-07-08',5,11),('61234796300','61234796','Mr. Louie Is Screwy! (My Weird School, #20)','2014-07-09',5,3),('61234796400','61234796','Mr. Louie Is Screwy! (My Weird School, #20)','2014-07-10',5,NULL),('61234796500','61234796','Mr. Louie Is Screwy! (My Weird School, #20)','2014-07-11',5,1),('67167203710','671672037','Down-Island Caribbean Cookery','2021-04-03',2,7),('68987680710','689876807','Getting Air','2021-12-13',5,NULL),('68987680720','689876807','Getting Air','2018-01-23',5,2),('68987884210','689878842','Back in Time with Benjamin Franklin (Qwerty Stevens, #2)','2012-06-02',5,7),('68987884220','689878842','Back in Time with Benjamin Franklin (Qwerty Stevens, #2)','2017-11-02',5,11),('78930372810','789303728','The Parisian Woman\'s Guide to Style','2018-02-05',1,2),('87358849510','873588495','Napa Valley & Sonoma: Heart of the California Wine Country','2022-12-13',3,2),('88010198910','880101989','Egyptian Myths and Mysteries','2023-08-15',7,7);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_details`
--

DROP TABLE IF EXISTS `book_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_details` (
  `isbn` char(13) NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `authorName` varchar(50) NOT NULL,
  `auth_id` int DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `language` varchar(3) DEFAULT NULL,
  `numPages` int DEFAULT NULL,
  `loanPeriod` int DEFAULT NULL,
  `numCopies` int DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `title` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_details`
--

LOCK TABLES `book_details` WRITE;
/*!40000 ALTER TABLE `book_details` DISABLE KEYS */;
INSERT INTO `book_details` VALUES ('006123477X','Fiction','Dan Gutman',5,'HarperTrophy','eng',112,30,5,'2007-08-21','Dr. Carbles Is Losing His Marbles! (My Weird School, #19)'),('1401902014','Self-Help','Keith Harrell',4,'Simon Schuster Books for Young','eng',240,20,3,'2004-01-01','Attitude Is Everything for Success'),('33333333333',NULL,'Mickey Mouse',9,NULL,NULL,NULL,NULL,NULL,NULL,'Ashmita'),('486245853','Art','Virginie Fowler Elbert',2,'Simon & Schuster','eng',364,15,1,'1984-01-01','Orchids of the World Coloring Book'),('486277305','Art','Virginie Fowler Elbert',2,'Cooper Square Pub','eng',72,15,1,'1993-10-18','Shell Craft'),('590023764','Fantasy','Dan Gutman',5,'Scholastic Paperbacks','eng',99,15,2,'2000-01-10','The Kid Who Became President (Kid President #2)'),('590485830','Fiction','Jeanne Betancourt',6,'Scholastic Paperbacks','eng',41,15,2,'1994-11-01','I Want a Pony (Pony Pals, #1)'),('590485849','Fiction','Jeanne Betancourt',6,'Scholastic Paperbacks','eng',192,15,2,'1995-01-01','A Pony for Keeps (Pony Pals, #2)'),('60507136','Self-Help','Keith Harrell',4,'Harper Business','eng',500,20,3,'2004-12-24','The Attitude is Everything Workbook: Strategies and Tools for Developing Personal and Professional Success'),('61234796','Fiction','Dan Gutman',5,'HarperTrophy','eng',192,30,5,'2001-01-12','Mr. Louie Is Screwy! (My Weird School, #20)'),('671672037','Cooking','Virginie Fowler Elbert',2,'Hay House','eng',240,15,1,'1991-12-31','Down-Island Caribbean Cookery'),('689876807','Adventure','Dan Gutman',5,'Readers','eng',223,15,2,'2007-04-24','Getting Air'),('689878842','Historical Fiction','Dan Gutman',5,'Simon Schuster Book for Young Readers','eng',92,15,2,'2005-06-01','Back in Time with Benjamin Franklin (Qwerty Stevens, #2)'),('789303728','Fashion','Virginie Morana',1,'Dover Publications','eng',304,15,1,'1999-10-29','The Parisian Woman\'s Guide to Style'),('873588495','Non-Fiction','Virginie Boone',3,'Dover Publications','eng',48,15,1,'2003-06-01','Napa Valley & Sonoma: Heart of the California Wine Country'),('880101989','Non-Fiction','Rudolf Steiner',7,'Steiner Books','eng',272,15,1,'1971-02-01','Egyptian Myths and Mysteries');
/*!40000 ALTER TABLE `book_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booktolibrary`
--

DROP TABLE IF EXISTS `booktolibrary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booktolibrary` (
  `b_barcode` char(13) NOT NULL,
  `libId` int NOT NULL,
  PRIMARY KEY (`b_barcode`,`libId`),
  KEY `libId` (`libId`),
  CONSTRAINT `booktolibrary_ibfk_1` FOREIGN KEY (`b_barcode`) REFERENCES `book` (`barcode`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `booktolibrary_ibfk_2` FOREIGN KEY (`libId`) REFERENCES `library` (`libraryId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booktolibrary`
--

LOCK TABLES `booktolibrary` WRITE;
/*!40000 ALTER TABLE `booktolibrary` DISABLE KEYS */;
INSERT INTO `booktolibrary` VALUES ('006123477X1',1),('006123477X2',1),('006123477X3',1),('006123477X4',1),('006123477X5',1),('14019020141',1),('14019020142',1),('14019020143',1),('333333333331',1),('48624585310',1),('48627730510',1),('59002376410',1),('59002376420',1),('59048583010',1),('59048583020',1),('59048584930',1),('59048584940',1),('60507136100',1),('60507136200',1),('60507136300',1),('61234796100',1),('61234796200',1),('61234796300',1),('61234796400',1),('61234796500',1),('67167203710',1),('68987680710',1),('68987680720',1),('68987884210',1),('68987884220',1),('78930372810',1),('87358849510',1),('88010198910',1);
/*!40000 ALTER TABLE `booktolibrary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `librarian`
--

DROP TABLE IF EXISTS `librarian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `librarian` (
  `librarianId` int NOT NULL AUTO_INCREMENT,
  `librarian_name` varchar(50) NOT NULL,
  `libraryid` int NOT NULL,
  PRIMARY KEY (`librarianId`),
  KEY `libraryid` (`libraryid`),
  CONSTRAINT `librarian_ibfk_1` FOREIGN KEY (`libraryid`) REFERENCES `library` (`libraryId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `librarian`
--

LOCK TABLES `librarian` WRITE;
/*!40000 ALTER TABLE `librarian` DISABLE KEYS */;
INSERT INTO `librarian` VALUES (1,'Sribindu Sreepada',1),(3,'John Rachlin',1);
/*!40000 ALTER TABLE `librarian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library` (
  `libraryId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `zipCode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`libraryId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library`
--

LOCK TABLES `library` WRITE;
/*!40000 ALTER TABLE `library` DISABLE KEYS */;
INSERT INTO `library` VALUES (1,'Husky Library','02115'),(2,'Terriers Library','02215');
/*!40000 ALTER TABLE `library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patron`
--

DROP TABLE IF EXISTS `patron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patron` (
  `patronId` int NOT NULL AUTO_INCREMENT,
  `patron_name` varchar(50) NOT NULL,
  `phoneNum` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`patronId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patron`
--

LOCK TABLES `patron` WRITE;
/*!40000 ALTER TABLE `patron` DISABLE KEYS */;
INSERT INTO `patron` VALUES (1,'Swarnima Pradeep Deshmukh','6173733323'),(2,'Katyaini Raj','6173732222'),(3,'Kathleen Durant','6173732772'),(4,'Yug Deepak Rajani','6173735085'),(5,'Yash Anand','6173732462'),(6,'Eshwar Hebbur Shivakumar','6173736300'),(7,'Samved Jogen Shah','6173735173'),(8,'Sanket Jogen Shah','6172629851');
/*!40000 ALTER TABLE `patron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'minilib_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `createBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createBook`(isbn_num VARCHAR(15), barcode_label varchar(15), book_title varchar(50), author_name varchar(50), libr_id int)
BEGIN 
	DECLARE isbn_count INT;
    DECLARE author_count INT;
    DECLARE author_book_cnt INT;
    DECLARE book_lib_cnt INT;
    DECLARE bar_cnt INT;
    DECLARE aut_id INT;
    DECLARE aut_id_2 INT;
    
    SELECT COUNT(*) INTO isbn_count FROM book_details WHERE book_details.isbn = isbn_num;
    SELECT COUNT(*) INTO author_count FROM author WHERE author.name = author_name;
    SELECT COUNT(*) INTO book_lib_cnt FROM booktolibrary WHERE booktolibrary.b_barcode = barcode_label;
    SELECT COUNT(*) INTO bar_cnt FROM book WHERE book.barcode = barcode_label;
    
    -- author
    IF author_name IS NULL THEN
		SELECT 1;
    ELSEIF author_count = 0 THEN 
		INSERT INTO author(name) VALUES (author_name);
        SELECT authorId INTO aut_id FROM author WHERE author.name = author_name;
	ELSEIF author_count > 0 THEN
		SELECT authorId INTO aut_id FROM author WHERE author.name = author_name;
	END IF;
    
    -- book_details
    IF isbn_num IS NULL THEN
		SELECT 1;
    ELSEIF isbn_count = 0 THEN 
		INSERT INTO book_details(isbn, title, auth_id, authorName, genre) VALUES (isbn_num, book_title, aut_id, author_name, NULL);
	END IF;
    
    -- book
    INSERT INTO book(barcode, book_isbn, name, author_id) VALUES (barcode_label, isbn_num, book_title, aut_id);
    
    -- authortobook
    SELECT COUNT(*) INTO author_book_cnt FROM authortobook WHERE authortobook.author_tag = aut_id AND authortobook.book_barcode = barcode_label;
    
    IF barcode_label IS NULL THEN
		SELECT 1;
    ELSEIF author_book_cnt = 0 THEN 
		SET FOREIGN_KEY_CHECKS=0;
		INSERT INTO authortobook(author_tag, book_barcode) VALUES (aut_id, barcode_label);
        SET FOREIGN_KEY_CHECKS=1;
	END IF;
    
    -- booktolibrary
	IF barcode_label IS NULL THEN
		SELECT 1;
    ELSEIF book_lib_cnt = 0 THEN 
		SET FOREIGN_KEY_CHECKS=0;
		INSERT INTO booktolibrary(b_barcode, libId) VALUES (barcode_label, libr_id);
        SET FOREIGN_KEY_CHECKS=1;
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delaccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delaccount`(acc_id INT)
Begin 
	SET sql_safe_updates=0;
	UPDATE book
    SET account_id = NULL
    WHERE account_id = acc_id;
    
	DELETE FROM account where account_num = acc_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delLibrarian` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delLibrarian`(librarianName varchar(30))
BEGIN 
	SET sql_safe_updates=0;
	DELETE FROM librarian WHERE librarian_name = librarianName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `genre_search` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `genre_search`(genre_name varchar(30))
BEGIN 
	SELECT title, authorName, isbn, genre, loanPeriod FROM book_details
    WHERE genre = genre_name;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updphone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updphone`(p_name varchar(50), patronphoneNumber varchar(10))
BEGIN 
	SET sql_safe_updates=0;
	UPDATE patron
    SET phoneNum = patronphoneNumber
    WHERE patron_name = p_name;
    
    SELECT patron_name, phoneNum FROM patron WHERE patron_name = p_name;

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

-- Dump completed on 2023-06-20 19:12:22
