-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: 192.168.1.6    Database: social_network
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'social_network'
--
/*!50003 DROP PROCEDURE IF EXISTS `abc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `abc`(userA INT, userB INT, userC INT)
BEGIN

DROP TABLE IF EXISTS T1;
DROP TABLE IF EXISTS T2;
DROP TABLE IF EXISTS T3;
DROP TABLE IF EXISTS T4;
DROP TABLE IF EXISTS T5;

CREATE TEMPORARY TABLE T1 
SELECT `user_id`, `object_id`, `sent_by`, `user`.`name`, `user`.`lastname` FROM `like` 
INNER JOIN `object` ON (`like`.`object_id` = `object`.`id`)
INNER JOIN `user` ON (`object`.`user_id` = `user`.`id`);

CREATE TEMPORARY TABLE T2
SELECT `sent_by` FROM T1 WHERE `user_id` = userC 

GROUP BY `sent_by`;

CREATE TEMPORARY TABLE T3
SELECT * FROM T1 WHERE `user_id` = userA;

CREATE TEMPORARY TABLE T4
SELECT * FROM T1 WHERE `user_id` = userB;

CREATE TEMPORARY TABLE T5
SELECT T3.`sent_by` FROM T3 INNER JOIN T4 ON (T3.`sent_by` = T4.`sent_by`) LEFT OUTER JOIN T2 ON (T3.`sent_by` = T2.`sent_by`) WHERE T2.`sent_by` IS NULL GROUP BY T3.`sent_by`;

SELECT `user`.`id`, CONCAT(`user`.`name`, ' ', `user`.`lastname`) AS `Имя пользователя` FROM T5 INNER JOIN `user` ON (T5.`sent_by` = `user`.`id`);

DROP TABLE IF EXISTS T2;
DROP TABLE IF EXISTS T3;
DROP TABLE IF EXISTS T4;
DROP TABLE IF EXISTS T5;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `like_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `like_delete`(objid INT, sentby INT)
BEGIN
DELETE FROM
  `like`
WHERE
  `object_id` = objid AND `sent_by` = sentby;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `like_send` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `like_send`(objid INT, sentby INT)
BEGIN
INSERT INTO
  `like`
SET
  `object_id` = objid, `sent_by` = sentby
ON DUPLICATE KEY UPDATE
  `object_id` = objid, `sent_by` = sentby;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `object_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `object_info`(objectid INT)
BEGIN
DROP TABLE IF EXISTS T1;
DROP TABLE IF EXISTS T2;

CREATE TEMPORARY TABLE T1 
SELECT `user_id`, `object_id`, `sent_by`, CONCAT(`user`.`name`, ' ', `user`.`lastname`) AS `name` FROM `like` 
INNER JOIN `object` ON (`like`.`object_id` = `object`.`id`)
INNER JOIN `user` ON (`like`.`sent_by` = `user`.`id`)
WHERE `like`.`object_id` = objectid;

SET @a := (SELECT COUNT(`object_id`) FROM T1 GROUP by `object_id`);
SET @b := (SELECT GROUP_CONCAT(DISTINCT `name`) FROM T1);

CREATE TEMPORARY TABLE T2 (
`ID объекта` INT PRIMARY KEY ,
`Лайков всего` INT ,
`Лайки поставили` VARCHAR (1000));

INSERT INTO T2 (`ID объекта`, `Лайков всего`, `Лайки поставили`) VALUES (objectid, @a, @b);

SELECT * FROM T2;

DROP TABLE IF EXISTS T1;
DROP TABLE IF EXISTS T2;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `user_info`(userid INT)
BEGIN
DROP TABLE IF EXISTS T1;
DROP TABLE IF EXISTS T2;
DROP TABLE IF EXISTS T3;
DROP TABLE IF EXISTS T4;
DROP TABLE IF EXISTS T5;

CREATE TEMPORARY TABLE T1 
SELECT `user_id`, `object_id`, `sent_by`, `user`.`name`, `user`.`lastname` FROM `like` 
INNER JOIN `object` ON (`like`.`object_id` = `object`.`id`)
INNER JOIN `user` ON (`object`.`user_id` = `user`.`id`);

#Ему поставили
CREATE TEMPORARY TABLE T2
SELECT * FROM T1 WHERE `user_id` = userid;

#Он поставил
CREATE TEMPORARY TABLE T3
SELECT * FROM T1 WHERE `sent_by` = userid;

CREATE TEMPORARY TABLE T4
SELECT T2.`user_id`, T2.`sent_by` FROM T2 INNER JOIN T3 ON (T2.`sent_by` = T3.`user_id`) WHERE T2.`sent_by` != userid;

SET @a := (SELECT `user_id` FROM T1 WHERE `user_id`=userid LIMIT 1 );
SET @b := (SELECT `Name` FROM T1 WHERE `user_id`=userid LIMIT 1 );
SET @c := (SELECT `Lastname` FROM T1 WHERE `user_id`=userid LIMIT 1 );
SET @d := (SELECT COUNT(`user_id`) FROM T1 WHERE `user_id`=userid);
SET @e := (SELECT COUNT(`user_id`) FROM (SELECT * FROM T1 WHERE `sent_by` = userid) AS T3);
SET @f := (SELECT COUNT(*) FROM T4); 

CREATE TEMPORARY TABLE IF NOT EXISTS `T5` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`ID пользователя` INT ,
`Имя` VARCHAR (30) ,
`Фамилия` VARCHAR (30) ,
`Лайков получено` INT, 
`Лайков поставлено` INT,
`Взаимных лайков` INT );
INSERT INTO `T5` (`ID пользователя`, `Имя`, `Фамилия`, `Лайков получено`, `Лайков поставлено`, `Взаимных лайков`) VALUES (@a, @b, @c, @d, @e, @f);

SELECT * FROM T5;

DROP TABLE IF EXISTS T1;
DROP TABLE IF EXISTS T2;
DROP TABLE IF EXISTS T3;
DROP TABLE IF EXISTS T4;
DROP TABLE IF EXISTS T5;

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

-- Dump completed on 2019-04-08 17:48:46
