-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: videocalls
-- ------------------------------------------------------
-- Server version	5.6.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `usercontacts`
--

DROP TABLE IF EXISTS `usercontacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usercontacts` (
  `relationID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'DB internal id',
  `userID` int(11) NOT NULL COMMENT 'user''s IDs',
  `contactID` int(11) NOT NULL COMMENT 'contact ID = userID; just for simple connection amongst users',
  PRIMARY KEY (`relationID`),
  KEY `userID_index` (`userID`),
  CONSTRAINT `fk_users_usercontacts` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='managing contacts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercontacts`
--

LOCK TABLES `usercontacts` WRITE;
/*!40000 ALTER TABLE `usercontacts` DISABLE KEYS */;
INSERT INTO `usercontacts` VALUES (1,2,1),(2,1,2),(3,1,3),(4,1,4),(5,4,1),(6,1,5),(7,5,1),(8,5,2),(9,5,3),(10,5,4),(11,6,5),(12,5,6),(13,4,6),(14,6,4),(15,1,6),(16,6,1);
/*!40000 ALTER TABLE `usercontacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdescriptions`
--

DROP TABLE IF EXISTS `userdescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userdescriptions` (
  `userDescriptionID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `userStory` varchar(160) DEFAULT 'is happy',
  PRIMARY KEY (`userDescriptionID`),
  KEY `fk_users_userstories` (`userID`),
  CONSTRAINT `fk_users_userstories` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Text stories on every user\nFK to users table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdescriptions`
--

LOCK TABLES `userdescriptions` WRITE;
/*!40000 ALTER TABLE `userdescriptions` DISABLE KEYS */;
INSERT INTO `userdescriptions` VALUES (1,5,'quit his job to become a musician'),(2,5,'now has a dog'),(3,5,'loves to go hiking'),(4,1,'has 28 grandchildren'),(5,2,'nowadays lives in palma de mallorca'),(6,3,'likes beer'),(7,4,'still riding his motor bike'),(8,4,'still smoking 2 packs of cigarettes day in and day out'),(9,3,'goes to church every sunday'),(10,2,'plays the guitar every evening'),(11,2,'has won the \'best gardener\' contest in his city'),(12,6,'has her own social tailorshop'),(13,6,'has adopted her 26th dog last year');
/*!40000 ALTER TABLE `userdescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usernotifications`
--

DROP TABLE IF EXISTS `usernotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usernotifications` (
  `notID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `notText` varchar(160) DEFAULT NULL,
  `notRead` tinyint(4) DEFAULT NULL,
  `notLink` varchar(160) DEFAULT NULL,
  PRIMARY KEY (`notID`),
  KEY `fk_notifications_users_idx` (`userID`),
  CONSTRAINT `fk_notifications_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='table to notify users on call - invitations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usernotifications`
--

LOCK TABLES `usernotifications` WRITE;
/*!40000 ALTER TABLE `usernotifications` DISABLE KEYS */;
INSERT INTO `usernotifications` VALUES (1,1,'You are invited to answer the call by josef',NULL,'/yii/videocalls/index.php?r=site/room&roomId=josef'),(2,1,'You are invited to answer the call by josef',1,'/yii/videocalls/index.php?r=site/room&roomId=josef'),(3,2,'You are invited to answer the call by irma',1,'/yii/videocalls/index.php?r=site/room&roomId=irma'),(4,2,'You are invited to answer the call by irma',1,'/yii/videocalls/index.php?r=site/room&roomId=irma'),(5,2,'You are invited to answer the call by irma',1,'/yii/videocalls/index.php?r=site/room&roomId=irma'),(6,2,'You are invited to answer the call by irma',1,'/yii/videocalls/index.php?r=site/room&roomId=irma');
/*!40000 ALTER TABLE `usernotifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identifying a single user',
  `username` varchar(50) NOT NULL COMMENT 'userName used for log in',
  `creationDate` datetime NOT NULL COMMENT 'date of creation',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'irma','2015-06-22 00:00:00'),(2,'josef','2015-06-22 00:00:00'),(3,'theresia','2015-06-22 00:00:00'),(4,'georg','2015-06-22 00:00:00'),(5,'robert','2015-06-26 00:00:00'),(6,'geli','2015-06-26 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-10 14:49:30
