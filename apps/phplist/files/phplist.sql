-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: phplist
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

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
-- Table structure for table `phplist_admin`
--

DROP TABLE IF EXISTS `phplist_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(25) NOT NULL,
  `namelc` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedby` varchar(25) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `passwordchanged` date DEFAULT NULL,
  `superuser` tinyint(4) DEFAULT '0',
  `disabled` tinyint(4) DEFAULT '0',
  `privileges` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginnameidx` (`loginname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phplist_admin_attribute`
--

DROP TABLE IF EXISTS `phplist_admin_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_admin_attribute` (
  `adminattributeid` int(11) NOT NULL,
  `adminid` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`adminattributeid`,`adminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_admin_attribute`
--

LOCK TABLES `phplist_admin_attribute` WRITE;
/*!40000 ALTER TABLE `phplist_admin_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_admin_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_admin_password_request`
--

DROP TABLE IF EXISTS `phplist_admin_password_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_admin_password_request` (
  `id_key` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `key_value` varchar(32) NOT NULL,
  PRIMARY KEY (`id_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_admin_password_request`
--

LOCK TABLES `phplist_admin_password_request` WRITE;
/*!40000 ALTER TABLE `phplist_admin_password_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_admin_password_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_adminattribute`
--

DROP TABLE IF EXISTS `phplist_adminattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_adminattribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(30) DEFAULT NULL,
  `listorder` int(11) DEFAULT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  `required` tinyint(4) DEFAULT NULL,
  `tablename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_adminattribute`
--

LOCK TABLES `phplist_adminattribute` WRITE;
/*!40000 ALTER TABLE `phplist_adminattribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_adminattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_admintoken`
--

DROP TABLE IF EXISTS `phplist_admintoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_admintoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminid` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `entered` int(11) NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_admintoken`
--

LOCK TABLES `phplist_admintoken` WRITE;
/*!40000 ALTER TABLE `phplist_admintoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_admintoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_attachment`
--

DROP TABLE IF EXISTS `phplist_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `remotefile` varchar(255) DEFAULT NULL,
  `mimetype` varchar(255) DEFAULT NULL,
  `description` text,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_attachment`
--

LOCK TABLES `phplist_attachment` WRITE;
/*!40000 ALTER TABLE `phplist_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_bounce`
--

DROP TABLE IF EXISTS `phplist_bounce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_bounce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `header` text,
  `data` blob,
  `status` varchar(255) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `dateindex` (`date`),
  KEY `statusidx` (`status`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_bounce`
--

LOCK TABLES `phplist_bounce` WRITE;
/*!40000 ALTER TABLE `phplist_bounce` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_bounce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_bounceregex`
--

DROP TABLE IF EXISTS `phplist_bounceregex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_bounceregex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `regex` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `listorder` int(11) DEFAULT '0',
  `admin` int(11) DEFAULT NULL,
  `comment` text,
  `status` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `regex` (`regex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_bounceregex`
--

LOCK TABLES `phplist_bounceregex` WRITE;
/*!40000 ALTER TABLE `phplist_bounceregex` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_bounceregex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_bounceregex_bounce`
--

DROP TABLE IF EXISTS `phplist_bounceregex_bounce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_bounceregex_bounce` (
  `regex` int(11) NOT NULL,
  `bounce` int(11) NOT NULL,
  PRIMARY KEY (`regex`,`bounce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_bounceregex_bounce`
--

LOCK TABLES `phplist_bounceregex_bounce` WRITE;
/*!40000 ALTER TABLE `phplist_bounceregex_bounce` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_bounceregex_bounce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_config`
--

DROP TABLE IF EXISTS `phplist_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_config` (
  `item` varchar(35) NOT NULL,
  `value` longtext,
  `editable` tinyint(4) DEFAULT '1',
  `type` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phplist_eventlog`
--

DROP TABLE IF EXISTS `phplist_eventlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_eventlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entered` datetime DEFAULT NULL,
  `page` varchar(100) DEFAULT NULL,
  `entry` text,
  PRIMARY KEY (`id`),
  KEY `enteredidx` (`entered`),
  KEY `pageidx` (`page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_eventlog`
--

LOCK TABLES `phplist_eventlog` WRITE;
/*!40000 ALTER TABLE `phplist_eventlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_eventlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_i18n`
--

DROP TABLE IF EXISTS `phplist_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_i18n` (
  `lan` varchar(10) NOT NULL,
  `original` text NOT NULL,
  `translation` text NOT NULL,
  UNIQUE KEY `lanorigunq` (`lan`,`original`(200)),
  KEY `lanorigidx` (`lan`,`original`(200))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_i18n`
--

LOCK TABLES `phplist_i18n` WRITE;
/*!40000 ALTER TABLE `phplist_i18n` DISABLE KEYS */;
INSERT INTO `phplist_i18n` VALUES ('en','Sorry, this page can only be used by super admins','Sorry, this page can only be used by super admins'),('en','Blacklisted by','Blacklisted by'),('en','All done, %d emails processed, %d emails marked unconfirmed, %d emails blacklisted<br/>','All done, %d emails processed, %d emails marked unconfirmed, %d emails blacklisted<br/>'),('en','Add more','Add more'),('en','Manage suppression list','Manage suppression list'),('en','Make suppression permanent','Make suppression permanent'),('en','Paste the emails to mark unconfirmed in this box, and click continue','Paste the emails to mark unconfirmed in this box, and click continue'),('en','continue','Continue'),('en','This page can only be called from the commandline','This page can only be called from the commandline'),('en','Bounce processing error','Bounce processing error'),('en','Bounce Processing info','Bounce processing info'),('en','system message bounced, user marked unconfirmed','system message bounced, subscriber marked unconfirmed'),('en','Bounced system message','Bounced system message'),('en','User marked unconfirmed','Subscriber marked unconfirmed'),('en','View Bounce','View bounce'),('en','system message bounced, but unknown user','system message bounced, but unknown subscriber'),('en','Cannot create POP3 connection to','Cannot create POP3 connection to'),('en','Cannot open mailbox file','Cannot open mailbox file'),('en','bounces to fetch from the mailbox','bounces to fetch from the mailbox'),('en','Please do not interrupt this process','Please do not interrupt this process'),('en','bounces to process','bounces to process'),('en','processing first','processing first'),('en','Bounces','Bounces'),('en','Running in test mode, not deleting messages from mailbox','Running in test mode, not deleting messages from mailbox'),('en','Processed messages will be deleted from mailbox','Processed messages will be deleted from mailbox'),('en','Deleting message','Deleting message'),('en','Not deleting processed message','Not deleting processed message'),('en','Not deleting unprocessed message','Not deleting unprocessed message'),('en','Closing mailbox, and purging messages','Closing mailbox, and purging messages'),('en','IMAP is not included in your PHP installation, cannot continue','IMAP is not included in your PHP installation, cannot continue'),('en','Check out','Check out'),('en','Bounce mechanism not properly configured','Bounce mechanism not properly configured'),('en','bounce_protocol not supported','bounce_protocol not supported'),('en','%d bounces to reprocess','%d bounces to reprocess'),('en','%d out of %d processed','%d out of %d processed'),('en','%d bounces were re-processed and %d bounces were re-identified','%d bounces were re-processed and %d bounces were re-identified'),('en','Processing bounces based on active bounce rules','Processing bounces based on active bounce rules'),('en','Process Killed by other process','Process Killed by other process'),('en','Auto unconfirmed','Auto unconfirmed'),('en','Subscriber auto unconfirmed for','Subscriber auto unconfirmed for'),('en','bounce rule','bounce rule'),('en','Auto Blacklisted','Auto blacklisted'),('en','User auto blacklisted for','User auto blacklisted for'),('en','Auto Unsubscribed','Auto unsubscribed'),('en','User auto unsubscribed for','User auto unsubscribed for'),('en','email auto blacklisted for','email auto blacklisted for'),('en','email auto unsubscribed for','email auto unsubscribed for'),('en','bounces processed by advanced processing','bounces processed by advanced processing'),('en','bounces were not matched by advanced processing rules','bounces were not matched by advanced processing rules'),('en','Identifying consecutive bounces','Identifying consecutive bounces'),('en','Nothing to do','Nothing to do'),('en','User (url:%s) has consecutive bounces (%d) over threshold (%d), user marked unconfirmed','Subscriber (url:%s) has consecutive bounces (%d) over threshold (%d), subscriber marked unconfirmed'),('en','Subscriber auto unconfirmed for %d consecutive bounces','Subscriber auto unconfirmed for %d consecutive bounces'),('en','%d consecutive bounces, threshold reached, blacklisting subscriber','%d consecutive bounces, threshold reached, blacklisting subscriber'),('en','%d consecutive bounces, threshold reached','%d consecutive bounces, threshold reached'),('en','Processed %d out of %d subscribers','Processed %d out of %d subscribers'),('en','total of %d subscribers processed','total of %d subscribers processed'),('en','Report:','Report:'),('en','Report of advanced bounce processing:','Report of advanced bounce processing:'),('en','Below are users who have been marked unconfirmed. The in () is the number of consecutive bounces.','Below are subscribers who have been marked unconfirmed. The in () is the number of consecutive bounces.'),('en','Error sending email to %s','Error sending email to %s'),('en','Error, empty message-body sending email to %s','Error, empty message-body sending email to %s'),('en','The temporary directory for uploading (%s) is not writable, so import will fail','The temporary directory for uploading (%s) is not writable, so import will fail'),('en','The maximum POST size is smaller than the maximum upload filesize. If your upload file is too large, import will fail. See the PHP documentation at <a href=\\\"%s\\\">%s</a>','The maximum POST size is smaller than the maximum upload filesize. If your upload file is too large, import will fail. See the PHP documentation at <a href=\\\"%s\\\">%s</a>'),('en','Import cleared','Import cleared'),('en','Are you sure you want to reset the import session?','Are you sure you want to reset the import session?'),('en','Reset Import session','Reset Import session'),('en','Invalid security token, please reload the page and try again','Invalid security token, please reload the page and try again'),('en','File is either too large or does not exist.','File is either too large or does not exist.'),('en','No file was specified. Maybe the file is too big?','No file was specified. Maybe the file is too big?'),('en','File too big, please split it up into smaller ones','File too big, please split it up into smaller ones'),('en','Please choose whether to sign up immediately or to send a notification','Please choose whether to sign up immediately or to send a notification'),('en','Cannot read %s. file is not readable !','Cannot read %s. file is not readable !'),('en','Something went wrong while uploading the file. Empty file received. Maybe the file is too big, or you have no permissions to read it.','Something went wrong while uploading the file. Empty file received. Maybe the file is too big, or you have no permissions to read it.'),('en','Reading emails from file ...','Reading emails from file ...'),('en','ok, %d lines','ok, %d lines'),('en','Create new one','Create new one'),('en','Skip Column','Skip Column'),('en','Import Attributes','Import Attributes'),('en','select','select'),('en','Please identify the target of the following unknown columns','Please identify the target of the following unknown columns'),('en','Cannot find column with email, you need to map at least one column to \\\"Email\\\"','Cannot find column with email, you need to map at least one column to \\\"Email\\\"'),('en','summary','summary'),('en','maps to','maps to'),('en','Create new Attribute','Create new Attribute'),('en','none','none'),('en','%d lines will be imported','%d lines will be imported'),('en','Confirm Import','Confirm Import'),('en','Test output','Test output'),('en','Importing %d subscribers to %d lists, please wait','Importing %d subscribers to %d lists, please wait'),('en','Record has no email','Record has no email'),('en','Invalid email','Invalid email'),('en','clear value','clear value'),('en','New Attribute','New Attribute'),('en','Skip value','Skip value'),('en','Test output<br/>If the output looks ok, click %s to submit for real','Test output<br/>If the output looks ok, click %s to submit for real'),('en','Import some more emails','Import some more emails'),('en','Adding users to list','Adding subscribers to list'),('en','Select the lists to add the emails to','Select the lists to add the emails to'),('en','No lists available','No lists available'),('en','Add a list','Add a list'),('en','Select the groups to add the users to','Select the groups to add the subscribers to'),('en','automatically added','automatically added'),('en','The file you upload will need to have the attributes of the records on    the first line.     Make sure that the email column is called \\\"email\\\" and not something like \\\"e-mail\\\" or     \\\"Email Address\\\".     Case is not important.          If you have a column called \\\"Foreign Key\\\", this will be used for synchronisation between an     external database and the phpList database. The foreignkey will take precedence when matching     an existing subscriber. This will slow down the import process. If you use this, it is allowed to have     records without email, but an \\\"Invalid Email\\\" will be created instead. You can then do     a search on \\\"invalid email\\\" to find those records. Maximum size of a foreign key is 100.          Warning: the file needs to be plain text. Do not upload binary files like a Word Document.','<p class=information>The file you upload will need to have the attributes of the records on    the first line.     Make sure that the email column is called email and not something like e-mail or     Email Address.     Case is not important.     </p>     If you have a column called Foreign Key, this will be used for synchronisation between an     external database and the phpList database. The foreignkey will take precedence when matching     an existing subscriber. This will slow down the import process. If you use this, it is allowed to have     records without email, but an Invalid Email will be created instead. You can then do     a search on invalid email to find those records. Maximum size of a foreign key is 100.     <br/><br/>     <b>Warning</b>: the file needs to be plain text. Do not upload binary files like a Word Document.     <br/>'),('en','File containing emails','File containing emails'),('en','The following limits are set by your server:<br/>Maximum size of a total data sent to server: %s<br/>Maximum size of each individual file: %s','The following limits are set by your server:<br/>Maximum size of a total data sent to server: %s<br/>Maximum size of each individual file: %s'),('en','phpList will not process files larger than %dMB','<br/>phpList will not process files larger than %dMB'),('en','Field Delimiter','Field Delimiter'),('en','default is TAB','default is TAB'),('en','Record Delimiter','Record Delimiter'),('en','default is line break','default is line break'),('en','If you check \\\"Test Output\\\", you will get the list of parsed emails on screen, and the database will not be filled with the information. This is useful to find out whether the format of your file is correct. It will only show the first 50 records.','If you check Test Output, you will get the list of parsed emails on screen, and the database will not be filled with the information. This is useful to find out whether the format of your file is correct. It will only show the first 50 records.'),('en','If you check \\\"Show Warnings\\\", you will get warnings for invalid records. Warnings will only be shown if you check \\\"Test Output\\\". They will be ignored when actually importing.','If you check Show Warnings, you will get warnings for invalid records. Warnings will only be shown if you check Test Output. They will be ignored when actually importing.'),('en','Show Warnings','Show Warnings'),('en','If you check \\\"Omit Invalid\\\", invalid records will not be added. Invalid records are records without an email. Any other attributes will be added automatically, ie if the country of a record is not found, it will be added to the list of countries.','If you check \\\"Omit Invalid\\\", invalid records will not be added. Invalid records are records without an email. Any other attributes will be added automatically, ie if the country of a record is not found, it will be added to the list of countries.'),('en','Omit Invalid','Omit Invalid'),('en','Assign Invalid will be used to create an email for subscribers with an invalid email address. You can use values between [ and ] to make up a value for the email. For example if your import file contains a column \\\"First Name\\\" and one called \\\"Last Name\\\", you can use \\\"[first name] [last name]\\\" to construct a new value for the email for this subscriber containing their first name and last name. The value [number] can be used to insert the sequence number for importing.','Assign Invalid will be used to create an email for subscribers with an invalid email address. You can use values between [ and ] to make up a value for the email. For example if your import file contains a column First Name and one called Last Name, you can use [first name] [last name] to construct a new value for the email for this subscriber containing their first name and last name. The value [number] can be used to insert the sequence number for importing.'),('en','Assign Invalid','Assign Invalid'),('en','If you check \\\"Overwrite Existing\\\", information about a subscriber in the database will be replaced by the imported information. Subscribers are matched by email or foreign key.','If you check \\\"Overwrite Existing\\\", information about a subscriber in the database will be replaced by the imported information. Subscribers are matched by email or foreign key.'),('en','Overwrite Existing','Overwrite Existing'),('en','If you check \\\"Retain Old Email\\\", a conflict of two emails being the same will keep the old one and add \\\"duplicate\\\" to the new one. If you don&quot;t check it, the old one will get \\\"duplicate\\\" and the new one will take precedence.','If you check \\\"Retain Old Email\\\", a conflict of two emails being the same will keep the old one and add \\\"duplicate\\\" to the new one. If you don\'t check it, the old one will get \\\"duplicate\\\" and the new one will take precedence.'),('en','Retain Old User Email','Retain Old Email'),('en','If you choose \\\"send notification email\\\" the subscribers you are adding will be sent the request for confirmation of subscription to which they will have to reply. This is recommended, because it will identify invalid emails.','If you choose \\\"send notification email\\\" the subscribers you are adding will be sent the request for confirmation of subscription to which they will have to reply. This is recommended, because it will identify invalid emails.'),('en','Send&nbsp;Notification&nbsp;email','Send&nbsp;Notification&nbsp;email'),('en','Make confirmed immediately','Make confirmed immediately'),('en','If you are going to send notification to users, you may want to add a little delay between messages','If you are going to send notification to subscribers, you may want to add a little delay between messages'),('en','Notification throttle','Notification throttle'),('en','(default is nothing, will send as fast as it can)','(default is nothing, will send as fast as it can)'),('en','import','Import'),('en','you only have privileges to view this page, not change any of the information','you only have privileges to view this page, not change any of the information'),('en','Delete will remove subscriber from the list','Delete will remove subscriber from the list'),('en','Delete will remove subscriber from the system','Delete will remove subscriber from the system'),('en','Error adding subscriber, please check that the subscriber exists','Error adding subscriber, please check that the subscriber exists'),('en','Uploaded avatar file too big','Uploaded avatar file too big'),('en','Subscriber added to group','Subscriber added to group'),('en','Subscriber removed from list %s','Subscriber removed from list %s'),('en','Subscriber added to list %s','Subscriber added to list %s'),('en','(no data)','(no data)'),('en','changed from','changed from'),('en','No data changed','No data changed'),('en','Subscribed to %s','Subscribed to %s'),('en','Unsubscribed from %s','Unsubscribed from %s'),('en','Update by %s','Update by %s'),('en','Changes saved','Changes saved'),('en','deleting','deleting'),('en','done','done'),('en','Subscriber removed from group','Subscriber removed from group'),('en','No such subscriber','No such subscriber'),('en','No Lists','No Lists'),('en','History','History'),('en','Delete','delete'),('en','Add a new subscriber','Add a new subscriber'),('en','Email address','Email address'),('en','Yes','Yes'),('en','No','No'),('en','Add to blacklist','Add to blacklist'),('en','Remove from blacklist','Remove from blacklist'),('en','save changes','Save changes'),('en','Subscriber is blacklisted. No emails will be sent to this email address.','Subscriber is blacklisted. No emails will be sent to this email address.'),('en','Mailinglist membership','Mailinglist membership'),('en','Group Membership','Group membership'),('en','Please select the groups this subscriber is a member of','Please select the groups this subscriber is a member of'),('en','details','details'),('en','lists','lists'),('en','Groups','Groups'),('en','no such User','no such subscriber'),('en','User','Subscriber'),('en','View','View'),('en','msg','msg'),('en','time','time'),('en','messages','Messages'),('en','messages sent to this user','messages sent to this subscriber'),('en','Clicks','Clicks'),('en','Sent','Sent'),('en','Viewed','Viewed'),('en','responsetime','responsetime'),('en','bounce','bounce'),('en','average','average'),('en','Campaigns','Campaigns'),('en','Subscription','Subscription'),('en','subscriber is blacklisted since','Subscriber is blacklisted since'),('en','Blacklist info','Blacklist info'),('en','Value','Value'),('en','are you sure you want to delete this subscriber from the blacklist','are you sure you want to delete this subscriber from the blacklist'),('en','it should only be done with explicit permission from this subscriber','it should only be done with explicit permission from this subscriber'),('en','remove subscriber from blacklist','remove subscriber from blacklist'),('en','remove','remove'),('en','For this subscriber to be removed from the blacklist, you need to ask them to re-subscribe using the phpList subscribe page','For this subscriber to be removed from the blacklist, you need to ask them to re-subscribe using the phpList subscribe page'),('en','Subscription History','Subscription history'),('en','no details found','no details found'),('en','ip','ip'),('en','Date','Date'),('en','detail','detail'),('en','info','info'),('en','Database structure check','Database structure check'),('en','Database structure','Database structure'),('en','Delete will delete user and all listmemberships','Delete will delete subscriber and all listmemberships'),('en','Your privileges for this page are insufficient','Your privileges for this page are insufficient'),('en','Delete will delete user from the list','Delete will delete subscriber from the list'),('en','Sorry, only super users can delete users','Sorry, only super users can delete subscribers'),('en','User added','Subscriber added'),('en','%s users in total','%s subscribers in total'),('en','Users marked <span class=\\\"highlight\\\">red</span> are unconfirmed','Subscribers marked <span class=\\\"highlight\\\">red</span> are unconfirmed'),('en','Show only unconfirmed users','Show only unconfirmed subscribers'),('en','Show only blacklisted users','Show only blacklisted subscribers'),('en','Sort by','Sort by'),('en','desc','desc'),('en','asc','asc'),('en','Go','Go'),('en','Listing user %d to %d','Listing subscriber %d to %d'),('en','subscribers','Subscribers'),('en','Find a user','Find a subscriber'),('en','email','email'),('en','Foreign Key','Foreign Key'),('en','reset','reset'),('en','Find subscribers','Find subscribers'),('en','Download all users as CSV file','Download all subscribers in a CSV file'),('en','Add a user','Add a subscriber'),('en','users','Subscribers'),('en','msgs','msgs'),('en','bncs','bncs'),('en','no results','no results'),('en','No users apply','No subscribers apply'),('en','Email is a system attribute','Email is a system attribute'),('en','Converting %s from %s to %s','Converting %s from %s to %s'),('en','Cannot delete attribute, it is being used by the following forms:','Cannot delete attribute, it is being used by the following forms:'),('en','cannot merge just one attribute','cannot merge just one attribute'),('en','Merging %s into %d','Merging %s into %d'),('en','Can only merge attributes of the same type','Can only merge attributes of the same type'),('en','Sorry, merging of checkbox groups is not implemented yet','Sorry, merging of checkbox groups is not implemented yet'),('en','Warning, changing types of attributes can take a long time','Warning, changing types of attributes can take a long time'),('en','Load data from','Load data from'),('en','predefined defaults','predefined defaults'),('en','Existing attributes','Existing attributes'),('en','No Attributes have been defined yet','No attributes have been defined yet'),('en','Attribute','Attribute'),('en','used in','used in'),('en','forms','forms'),('en','tag','tag'),('en','name','Name'),('en','Type','Type'),('en','authoritative list','authoritative list'),('en','edit values','edit values'),('en','Default Value','Default Value'),('en','Order of Listing','Order of Listing'),('en','Is this attribute required ?','Is this attribute required?'),('en','Delete tagged attributes','Delete tagged attributes'),('en','Merge tagged attributes','Merge tagged attributes'),('en','Add new Attribute','Add new Attribute'),('en','Is this attribute required?','Is this attribute required?'),('en','Removed from blacklist by %s','Removed from blacklist by %s'),('en','Removed from blacklist','Removed from blacklist'),('en','Added to blacklist','Added to blacklist'),('en','Added to blacklist for reason %s','Added to blacklist for reason %s'),('en','sort by %s','sort by %s'),('en','Previous','Previous'),('en','back','back'),('en','Next','Next'),('en','Close this box','Close this box'),('en','Hide','Hide'),('en','open','open'),('en','close','close'),('en','Choose a list','Choose a list'),('en','list','list'),('en','# bounced','# bounced'),('en','None found','None found'),('en','Select another list','Select another list'),('en','%d bounces to list %s','%d bounces to list %s'),('en','Bounces on','Bounces on'),('en','# bounces','# bounces'),('en','import is not available','import is not available'),('en','The temporary directory for uploading is not writable, so import will fail','The temporary directory for uploading is not writable, so import will fail'),('en','Cannot read file. It is not readable !','Cannot read file. It is not readable !'),('en','Test output:','Test output:'),('en','There should only be ONE email per line.','There should only be ONE email per line.'),('en','If the output looks ok, go','If the output looks ok, go'),('en','to resubmit for real','to resubmit for real'),('en','adding_users','Adding subscribers'),('en','The file you upload will need to contain the emails you want to add to these lists. Anything after the email will be added as attribute \\\"Info\\\" of the Subscriber. You can specify the rest of the attributes of these subscribers below. Warning: the file needs to be plain text. Do not upload binary files like a Word Document.','The file you upload will need to contain the emails you want to add to these lists. Anything after the email will be added as attribute Info of the Subscriber. You can specify the rest of the attributes of these subscribers below. <b>Warning</b>: the file needs to be plain text. Do not upload binary files like a Word Document.'),('en','File containing emails:','File containing emails:'),('en','send notification email','send notification email'),('en','File is either to large or does not exist.','File is either to large or does not exist.'),('en','No file was specified.','No file was specified.'),('en','Some characters that are not valid have been found. These might be delimiters. Please check the file and select the right delimiter. Character found:','Some characters that are not valid have been found. These might be delimiters. Please check the file and select the right delimiter. Character found:'),('en','Name cannot be empty','Name cannot be empty'),('en','Name is not unique enough','Name is not unique enough'),('en','Cannot find the email in the header','Cannot find the email in the header'),('en','Cannot find the password in the header','Cannot find the password in the header'),('en','Cannot find the loginname in the header','Cannot find the loginname in the header'),('en','Import administrators, please wait','Importing administrators, please wait'),('en','Record has more values than header indicated, this may cause trouble','Record has more values than header indicated, this may cause trouble'),('en','Test output: If the output looks ok, go Back to resubmit for real','Test output<br/>If the output looks ok, go Back to submit for real'),('en','Password','Password'),('en','login','login'),('en','Empty loginname, using email:','Empty loginname, using email:'),('en','added to attribute','added to attribute'),('en','List for','List for'),('en','new administrator was','new administrator was'),('en','new administrators were','new administrators were'),('en','All the administrators already exist in the database','All the administrators already exist in the database'),('en','Information has been updated from the import','Information has been updated from the import'),('en','succesfully imported to the database and added to the system.','succesfully imported to the database and added to the system.'),('en','Import some more administrators','Import some more administrators'),('en','The file you upload will need to contain the administrators you want to add to the system. The columns need to have the following headers: email, loginname, password. Any other columns will be added as admin attributes.  Warning: the file needs to be plain text. Do not upload binary files like a Word Document.','The file you upload will need to contain the administrators you want to add to the system. The columns need to have the following headers: <b>email</b>, <b>loginname</b>, <b>password</b>. Any other columns will be added as admin attributes.  <b>Warning</b>: the file needs to be plain text. Do not upload binary files like a Word Document.'),('en','Check this box to create a list for each administrator, named after their loginname','Check this box to create a list for each administrator, named after their loginname'),('en','Privileges','Privileges'),('en','Manage Subscribers','Manage subscribers'),('en','Send Campaigns','Send campaigns'),('en','View statistics','View statistics'),('en','Change Settings','Change settings'),('en','Do Import','Do Import'),('en','File not found','File not found'),('en','Import of existing subscriber','Import of existing subscriber'),('en','Import of new subscriber','Import of new subscriber'),('en','List subscriptions:','List subscriptions:'),('en','Was subscribed to:','Was subscribed to:'),('en','Is now subscribed to:','Is now subscribed to:'),('en','Not subscribed to any lists','Not subscribed to any lists'),('en','Import by','Import by'),('en','new email was','new email was'),('en','new emails were','new emails were'),('en','email was','email was'),('en','emails were','emails were'),('en','%d emails already existed in the database','%d emails already existed in the database'),('en','All the emails already exist in the database.','All the emails already exist in the database.'),('en','succesfully imported to the database and added to','succesfully imported to the database and added to'),('en','subscribed to the','subscribed to the'),('en','Manually blacklisted by %s','Manually blacklisted by %s'),('en','Unable to fetch list of languages, please check your network or try again later','Unable to fetch list of languages, please check your network or try again later'),('en','updated %d language terms','updated %d language terms'),('en','Network error updating language, please try again later','Network error updating language, please try again later'),('en','duplicate','duplicate'),('en','Duplicate Email','Duplicate Email'),('en','user imported as','subscriber imported as'),('en','All the emails already exist in the database and are member of the lists','All the emails already exist in the database and are member of the lists'),('en','%s emails succesfully imported to the database and added to %d lists.','%s emails succesfully imported to the database and added to %d lists.'),('en','%d emails subscribed to the lists','%d emails subscribed to the lists'),('en','%s emails already existed in the database','%s emails already existed in the database'),('en','%d Invalid Emails found.','%d Invalid Emails found.'),('en','These records were added, but the email has been made up from','These records were added, but the email has been made up from'),('en','These records were deleted. Check your source and reimport the data. Duplicates will be identified.','These records were deleted. Check your source and reimport the data. Duplicates will be identified.'),('en','%d duplicate emails found.','%d duplicate emails found.'),('en','Subscriber data was updated for %d subscribers','Subscriber data was updated for %d subscribers'),('en','%s emails were on the blacklist and have not been added to the lists','%s emails were on the blacklist and have not been added to the lists'),('en','%d subscribers were matched by foreign key, %d by email','%d subscribers were matched by foreign key, %d by email'),('en','phplist Import Results','phplist Import Results'),('en','Invalid Request','invalid request'),('en','Editing','Editing'),('en','Don\'t know how to handle type','Don\'t know how to handle type'),('en','Email address added','Email address added'),('en','Adding email address failed','Adding email address failed'),('en','Unknown','Unknown'),('en','%s left until embargo','%s left until embargo'),('en','Requeue','Requeue'),('en','still to process','still to process'),('en','limit reached','limit reached'),('en','next batch of %s in %s','next batch of %s in %s'),('en','Stalled','Stalled'),('en','Send the queue','Send the queue'),('en','processing','processing'),('en','ETA','ETA'),('en','msgs/hr','msgs/hr'),('en','You are trying to send a remote URL, but PEAR::HTTP_Request is not available, so this will fail','You are trying to send a remote URL, but PEAR::HTTP_Request is not available, so this will fail'),('en','Sample Newsletter Content','Sample newsletter content'),('en','The following restrictions have been set by your ISP:','The following restrictions have been set by your ISP:'),('en','Maximum time for queue processing','Maximum time for queue processing'),('en','Running in safe mode','Running in safe mode'),('en','Script stage','Script stage'),('en','Finished, Nothing to do','Finished, Nothing to do'),('en','Calculating','Calculating'),('en','messages sent in','messages sent in'),('en','seconds','seconds'),('en','%d invalid email addresses','%d invalid email addresses'),('en','%d failed (will retry later)','%d failed (will retry later)'),('en','%d emails unconfirmed (not sent)','%d emails unconfirmed (not sent)'),('en','Warning: script never reached stage 5','Warning: script never reached stage 5'),('en','This may be caused by a too slow or too busy server','This may be caused by a too slow or too busy server'),('en','Less than batch size were sent, so reloading imminently','Less than batch size were sent, so reloading imminently'),('en','Waiting for %d seconds before reloading','Waiting for %d seconds before reloading'),('en','Finished, All done','Finished, All done'),('en','All Done','All done'),('en','Script finished, but not all messages have been sent yet.','Script finished, but not all messages have been sent yet.'),('en','Maillist errors','Maillist errors'),('en','Maillist Processing info','Maillist Processing info'),('en','Finished this run','Finished this run'),('en','(test)','(test)'),('en','Would have sent','Would have sent'),('en','to','to'),('en','Started','Started'),('en','Time now','Time now'),('en','Unable get lock for processing','Unable get lock for processing'),('en','Error processing','Error processing'),('en','Processing blocked by plugin %s','Processing blocked by plugin %s'),('en','Processing has been suspended by your ISP, please try again later','Processing has been suspended by your ISP, please try again later'),('en','In safe mode, batches are set to a maximum of 100','In safe mode, batches are set to a maximum of 100'),('en','Sending in batches of %d messages','Sending in batches of %d messages'),('en','This batch will be %d emails, because in the last %d seconds %d emails were sent','This batch will be %d emails, because in the last %d seconds %d emails were sent'),('en','Sending in batches of %d emails','Sending in batches of %d emails'),('en','In the last %d seconds more emails were sent (%d) than is currently allowed per batch (%d)','In the last %d seconds more emails were sent (%d) than is currently allowed per batch (%d)'),('en','Sent in last run','Sent in last run'),('en','Skipped in last run','Skipped in last run'),('en','Processing has started,','Processing has started,'),('en','message(s) to process.','message(s) to process.'),('en','Please leave this window open. You have batch processing enabled, so it will reload several times to send the messages. Reports will be sent by email to','Please leave this window open. You have batch processing enabled, so it will reload several times to send the messages. Reports will be sent by email to'),('en','Your webserver is running in safe_mode. Please keep this window open. It may reload several times to make sure all messages are sent.','Your webserver is running in safe_mode. Please keep this window open. It may reload several times to make sure all messages are sent.'),('en','Reports will be sent by email to','Reports will be sent by email to'),('en','sending of this campaign will stop, if it is still going in %s','sending of this campaign will stop, if it is still going in %s'),('en','Error loading message, please check the eventlog for details','Error loading message, please check the eventlog for details'),('en','Campaign started','Campaign started'),('en','phplist has started sending the campaign with subject %s','phplist has started sending the campaign with subject %s'),('en','to view the progress of this campaign, go to http://%s','to view the progress of this campaign, go to http://%s'),('en','Processing message','Processing message'),('en','Looking for users','Looking for subscribers'),('en','users apply for attributes, now checking lists','subscribers apply for attributes, now checking lists'),('en','No users apply for attributes','No subscribers apply for attributes'),('en','looking for users who can be excluded from this mailing','looking for subscribers who can be excluded from this mailing'),('en','Warning, finding the subscribers to send out to takes a long time, consider changing to commandline sending','Warning, finding the subscribers to send out to takes a long time, consider changing to commandline sending'),('en','Found them','Found them'),('en','to process','to process'),('en','No users to process for this batch','No subscribers to process for this batch'),('en','Processing batch of','Processing batch of'),('en','batch limit reached','batch limit reached'),('en','queue processing time has exceeded max processing time','queue processing has exceeded maximum processing time'),('en','Campaign sending timed out, is past date to process until','Campaign sending timed out, is past date to process until'),('en','Message I was working on has disappeared','Message I was working on has disappeared'),('en','Sending of this message has been suspended','Sending of this message has been suspended'),('en','There have been more than 10 attempts to send to %s that have been blocked for domain throttling.','There have been more than 10 attempts to send to %s that have been blocked for domain throttling.'),('en','Introducing extra delay to decrease throttle failures','Introducing extra delay to decrease throttle failures'),('en','%s is currently over throttle limit of %d per %d seconds','%s is currently over throttle limit of %d per %d seconds'),('en','Sending','Sending'),('en','It took','It took'),('en','seconds to send','seconds to send'),('en','Failed sending to','Failed sending to'),('en','waiting for %.1f seconds to meet target of %s seconds per message','waiting for %.1f seconds to meet target of %s seconds per message'),('en','Not sending to','Not sending to'),('en','Unconfirmed user','Unconfirmed subscriber'),('en','Invalid email address','Invalid email address'),('en','Marked unconfirmed while sending campaign %d','Marked unconfirmed while sending campaign %d'),('en','Subscriber marked unconfirmed for invalid email address','Subscriber marked unconfirmed for invalid email address'),('en','already sent','already sent'),('en','Hmmm, No users found to send to','Hmmm, No subscribers found to send to'),('en','Message campaign finished','Campaign finished'),('en','phpList has finished sending the campaign with subject %s','phpList has finished sending the campaign with subject %s'),('en','to view the results of this campaign, go to http://%s','to view the progress of this campaign, go to http://%s'),('en','to send this message','to send this message'),('en','Error fetching URL','Error fetching URL'),('en','Check your \\\"remoteurl_append\\\" setting.','Check your \\\"remoteurl_append\\\" setting.'),('en','URL is valid','URL is valid'),('en','Please verify that the URL entered is correct.','Please verify that the URL entered is correct.'),('en','Updating the regular expression of this rule caused an Sql conflict<br/>This is probably because there is already a rule like that. Do you want to delete this rule instead?','Updating the regular expression of this rule caused an Sql conflict<br/>This is probably because there is already a rule like that. Do you want to delete this rule instead?'),('en','back to list of bounce rules','back to list of bounce rules'),('en','Regular Expression','Regular Expression'),('en','Created By','Created By'),('en','action','action'),('en','Status','Status'),('en','Select Status','Select Status'),('en','Memo for this rule','Memo for this rule'),('en','related bounces','related bounces'),('en','no related bounces found','no related bounces found'),('en','and more, %d in total','and more, %d in total'),('en','Sending message %d with subject %s to %s','Sending message %d with subject %s to %s'),('en','sendingtextonlyto','Sending text only to'),('en','Error sending message %d (%d/%d) to %s (%s)','Error sending message %d (%d/%d) to %s (%s)'),('en','Delete will remove subscriber from the database','Delete will delete subscriber from the database'),('en','The default system template already exists','The default system template already exists'),('en','Go back to templates','Go back to templates'),('en','The default system template has been added as template with ID','The default system template has been added as template with ID'),('en','Edit template','Edit template'),('en','Never','Never'),('en','Last updated','Last updated'),('en','Last modified','Last modified'),('en','choose','choose'),('en','Your database version','Your database version'),('en','Your database is already the correct version, there is no need to upgrade','Your database is already the correct version, there is no need to upgrade'),('en','Please wait, upgrading your database, do not interrupt','Please wait, upgrading your database, do not interrupt'),('en','Upgrading the database to use UTF-8, please wait','Upgrading the database to use UTF-8, please wait'),('en','Upgrading table','Upgrading table'),('en','Upgrading column','Upgrading column'),('en','upgrade to UTF-8, done','upgrade to UTF-8, done'),('en','Database requires converting to UTF-8.','Database requires converting to UTF-8.'),('en','However, there is too little diskspace for this conversion','However, there is too little diskspace for this conversion'),('en','Please do a manual conversion.','Please do a manual conversion.'),('en','Run manual conversion to UTF8','Run manual conversion to UTF8'),('en','success','success'),('en','The clicktracking system has changed','The clicktracking system has changed'),('en','You have %s entries in the old statistics table','You have %s entries in the old statistics table'),('en','Convert Old data to new','Convert old data to new'),('en','Upgrade successful','Upgrade successful'),('en','Upgrade failed','Upgrade failed'),('en','Your database requires upgrading, please make sure to create a backup of your database first.','Your database requires upgrading, please make sure to create a backup of your database first.'),('en','If you have a large database, make sure you have sufficient diskspace available for upgrade.','If you have a large database, make sure you have sufficient diskspace available for upgrade.'),('en','upgrade','Upgrade'),('en','When you are ready click %s Depending on the size of your database, this may take quite a while. Please make sure not to interrupt the process, once it started.','When you are ready click %s Depending on the size of your database, this may take quite a while. Please make sure not to interrupt the process, once it started.'),('en','Please choose one of the import methods below','Please choose one of the import methods below'),('en','copy and paste list of emails','copy and paste list of emails'),('en','import by uploading a file with emails','import by uploading a file with emails'),('en','import by uploading a CSV file with emails and additional data','import by uploading a CSV file with emails and additional data'),('en','Sunday','Sunday'),('en','Monday','Monday'),('en','Tuesday','Tuesday'),('en','Wednesday','Wednesday'),('en','Thursday','Thursday'),('en','Friday','Friday'),('en','Saturday','Saturday'),('en','January','January'),('en','February','February'),('en','March','March'),('en','April','April'),('en','May','May'),('en','June','June'),('en','July','July'),('en','August','August'),('en','September','September'),('en','October','October'),('en','November','November'),('en','December','December'),('en','That rule exists already','That rule exists already'),('en','Number of %s rules: %d','Number of %s rules: %d'),('en','active','active'),('en','candidate','Candidate'),('en','Bounce Regular Expressions','Bounce Regular Expressions'),('en','No Rules found','No Rules found'),('en','rule','rule'),('en','match','match'),('en','expression','expression'),('en','#bncs','#bncs'),('en','Order','Order'),('en','Del','Del'),('en','with tagged rules:','with tagged rules:'),('en','make active','make active'),('en','make inactive','make inactive'),('en','add a new rule','add a new rule'),('en','Add new Rule','Add new Rule'),('en','Process Next %d','Process Next %d'),('en','No match','No match'),('en','bounces did not match any current active rule','bounces did not match any current active rule'),('en','bounce matched current active rules','bounce matched current active rules'),('en','Go there','Go there'),('en','Initialise Database','Initialise Database'),('en','Change admin password','Change admin password'),('en','Verify Settings','Verify settings'),('en','Configure Attributes','Configure attributes'),('en','Create public lists','Create public lists'),('en','Create a subscribe page','Create a subscribe page'),('en','Add some subscribers','Add some subscribers'),('en','Congratulations, phpList is set up, you are ready to start mailing','Congratulations, phpList is set up, you are ready to start mailing'),('en','Start a message campaign','Start a message campaign'),('en','configuration steps','Configuration steps'),('en','Overview','Overview'),('en','View Clicks by URL','View clicks per URL'),('en','View Clicks by Message','View clicks by campaign'),('en','View Opens by Message','View opens by campaign'),('en','Domain Statistics','Domain statistics'),('en','To avoid overloading the system, this will convert 10000 records at a time','To avoid overloading the system, this will convert 10000 records at a time'),('en','Admin Authentication initialisation failure','Admin Authentication initialisation failure'),('en','invalid login from %s, tried logging in as %s','invalid login from %s, tried logging in as %s'),('en','Failed sending a change password token','Failed sending a change password token'),('en','login ip invalid from %s for %s (was %s)','login ip invalid from %s for %s (was %s)'),('en','Your IP address has changed. For security reasons, please login again','Your IP address has changed. For security reasons, please login again'),('en','invalidated login from %s for %s (error %s)','invalidated login from %s for %s (error %s)'),('en','Your session timed out, please login again','Your session timed out, please login again'),('en','goodbye','goodbye'),('en','good morning','good morning'),('en','good afternoon','good afternoon'),('en','good evening','good evening'),('en','Continue Configuration','Continue Configuration'),('en','phpList will work without Javascript, but it will be easier to use if you switch it on.','phpList will work without Javascript, but it will be easier to use if you switch it on.'),('en','Running in testmode, no emails will be sent. Check your config file.','Running in testmode, no emails will be sent. Check your config file.'),('en','phpList requires PHP version 5.1.2 or higher','phpList requires PHP version 5.1.2 or higher'),('en','You are trying to use RSS, but XML is not included in your PHP','You are trying to use RSS, but XML is not included in your PHP'),('en','open_basedir restrictions are in effect, which may be the cause of the next warning','open_basedir restrictions are in effect, which may be the cause of the next warning'),('en','The attachment repository does not exist or is not writable','The attachment repository does not exist or is not writable'),('en','Process the queue','Process the queue'),('en','View the queue','View the queue'),('en','You have %s message(s) waiting to be sent','You have %s message(s) waiting to be sent'),('en','You are trying to use PDF support without having FPDF loaded','You are trying to use PDF support without having FPDF loaded'),('en','The pageroot in your config does not match the current locationCheck your config file.','The pageroot in your config does not match the current location<br/>Check your config file.'),('en','Access Denied','Access denied'),('en','Sorry this page was not found in the plugin','Sorry this page was not found in the plugin'),('en','Sorry, that module does not exist','Sorry, that module does not exist'),('en','Sorry, not implemented yet','Sorry not Implemented yet'),('en','Download as CSV file','Download as CSV file'),('en','Top 50 domains with more than 5 emails','Top 50 domains with more than 5 emails'),('en','confirmed','confirmed'),('en','perc','perc'),('en','unconfirmed','unconfirmed'),('en','num','num'),('en','Top 25 pre-@ of email addresses','Top 25 pre-@ of email addresses'),('en','amount','amount'),('en','Process Next Batch','Process Next Batch'),('en','Hmm, duplicate entry,','Hmm, duplicate entry,'),('en','new rules found','new rules found'),('en','bounces not matched','bounces not matched'),('en','bounces matched to existing rules','bounces matched to existing rules'),('en','Name cannot be empty:','Name cannot be empty'),('en','Existing attributes:','Existing attributes:'),('en','Attribute:','Attribute:'),('en','Name:','Name:'),('en','Default Value:','Default value:'),('en','Order of Listing:','Order of listing:'),('en','Is this attribute required?:','Is this attribute required?:'),('en','Add a new Attribute:','Add a new attribute:'),('en','statistics','statistics'),('en','Send Campaign','Send campaign'),('en','You should not paste the results of a test message back into the editor<br/>This will break the click-track statistics, and overload the server.','You should not paste the results of a test message back into the editor<br/>This will break the click-track statistics, and overload the server.'),('en','Warning: You indicated the content was not HTML, but there were  some HTML  tags in it. This  may  cause  errors','Warning: You indicated the content was not HTML, but there were some HTML tags in it. This may cause errors'),('en','You are trying to send a remote URL, but PEAR::HTTP_Request or CURL is not available, so this will fail','You are trying to send a remote URL, but PEAR::HTTP_Request or CURL is not available, so this will fail'),('en','Mime Type is longer than 255 characters, this is trouble','Mime Type is longer than 255 characters, this will cause problems'),('en','Attachment %d succesfully added','Attachment %d succesfully added'),('en','Adding attachment %d failed','Adding attachment %d failed'),('en','Uploaded file not properly received, empty file','Uploaded file not properly received, empty file'),('en','Adding attachment','Adding attachment'),('en','Campaign saved as draft','Campaign saved as draft'),('en','Campaign added','Campaign added'),('en','This campaign is scheduled to stop sending before the embargo time. No mails will be sent.','This campaign is scheduled to stop sending before the embargo time. No mails will be sent.'),('en','Review Scheduling','Review scheduling'),('en','Campaign queued','Campaign queued'),('en','processqueue','process queue'),('en','view progress','view progress'),('en','Sorry, you used invalid characters in the Subject field.','Sorry, you used invalid characters in the \\\"subject\\\" field.'),('en','Sorry, you used invalid characters in the From field.','Sorry, you used invalid characters in the \\\"from\\\" field.'),('en','Please enter a from line.','Please enter a from line.'),('en','Please enter a message','Please add some content'),('en','Please enter a subject','Please enter a subject'),('en','Error: you can use an attribute in one rule only','Error: you can use an attribute in one rule only'),('en','Please select the list(s) to send the campaign to','Please select the list(s) to send the campaign to'),('en','You can send a test mail once every %d seconds','You can send a test mail once every %d seconds'),('en','No target email addresses listed for testing.','No target email addresses listed for testing.'),('en','There is a maximum of %d test emails allowed','There is a maximum of %d test emails allowed'),('en','Sent test mail to','Sent test mail to'),('en','FAILED','FAILED'),('en','Email address not found to send test message.','Email address not found to send test message.'),('en','Add','Add'),('en','Removed Attachment','Removed attachment'),('en','Content','Content'),('en','text','text'),('en','Forward','Forward'),('en','Format','Format'),('en','Attach','Attach'),('en','Scheduling','Scheduling'),('en','Finish','Finish'),('en','What is prepare a message','What is prepare a message'),('en','subject','subject'),('en','From Line','From line'),('en','Send a Webpage','Send a webpage'),('en','Compose Message','Compose message'),('en','Send a Webpage - URL','Send a webpage - URL'),('en','phpList operates in the time zone','phpList operates in the time zone'),('en','Dates and times are relative to the Server Time','Dates and times are relative to the Server Time'),('en','Current Server Time is','Current Server Time is'),('en','Embargoed Until','Embargoed until'),('en','Stop sending after','Stop sending after'),('en','Repeat campaign every','Repeat campaign every'),('en','no repetition','no repetition'),('en','hour','hour'),('en','day','day'),('en','week','week'),('en','fortnight','fortnight'),('en','four weeks','four weeks'),('en','Repeat Until','Repeat until'),('en','Requeue every','Requeue every'),('en','do not requeue','do not requeue'),('en','Requeue Until','Requeue until'),('en','Send as','Send as'),('en','HTML','HTML'),('en','Use Template','Use template'),('en','select one','select one'),('en','Plain text version of message','Plain text version of message'),('en','generate from HTML','generate from HTML'),('en','Footer','Footer'),('en','forwardfooter','Forward footer'),('en','Add attachments to your campaign','Add attachments to your campaign'),('en','The upload has the following limits set by the server','The upload has the following limits set by the server'),('en','Maximum size of total data being sent to the server','Maximum size of total data being sent to the server'),('en','Maximum size of each individual file','Maximum size of each individual file'),('en','Current Attachments','Current attachments'),('en','Filename','Filename'),('en','Size','Size'),('en','file','file'),('en','delchecked','delete checked'),('en','New Attachment','New attachment'),('en','Add (and save)','Add (and save)'),('en','or','or'),('en','Path to file on server','Path to file on server'),('en','Description of attachment','Description of attachment'),('en','Send Test','Send test'),('en','to email address(es)','to email address(es)'),('en','(comma separate addresses - all must be existing subscribers)','(comma separate addresses - all must be existing subscribers)'),('en','email to alert when sending of this message starts','email to alert when sending of this message starts'),('en','separate multiple with a comma','separate multiple with a comma'),('en','email to alert when sending of this message has finished','email address to alert when sending of this campaign has finished'),('en','add Google Analytics tracking code','add Google Analytics tracking code'),('en','Reset click statistics','Reset click statistics'),('en','Estimated size of HTML email','Estimated size of HTML message'),('en','Estimated size of text email','Estimated size of text message'),('en','Estimated size of mailout','Estimated size of mailout'),('en','About %d users to receive HTML and %s users to receive text version of email','About %d subscribers to receive HTML version and %s subscribers to receive text version'),('en','subject missing','subject missing'),('en','message content missing','message content missing'),('en','From missing','From missing'),('en','destination lists missing','destination lists missing'),('en','Content contains click track links.','Content contains click track links.'),('en','Some required information is missing. The send button will be enabled when this is resolved.','Some required information is missing. The send button will be enabled when this is resolved.'),('en','Save as draft','Save as draft'),('en','You do not have access to this page','You do not have access to this page'),('en','Select Message to view','Select Campaign to view'),('en','There are currently no messages to view','There are currently no campaigns to view'),('en','Campaigns in the last year','Campaigns in the last year'),('en','fwds','fwds'),('en','views','views'),('en','rate','rate'),('en','Comparison to other admins','Comparison to other admins'),('en','View all campaigns','View all campaigns'),('en','Date entered','Date entered'),('en','Date sent','Date sent'),('en','Sent as HTML','Sent as HTML'),('en','Sent as text','Sent as text'),('en','Bounced','Bounced'),('en','Opened','Opened'),('en','% Opened','% Opened'),('en','Clicked','Clicked'),('en','% Clicked','% Clicked'),('en','Forwarded','Forwarded'),('en','Available URLs','Available URLs'),('en','last clicked','last clicked'),('en','Select URL to view','Select URL to view'),('en','There are currently no statistics available','There are currently no statistics available'),('en','URL Click Statistics','URL click statistics'),('en','Click Details for a URL','Click details for a URL'),('en','firstclick','first click'),('en','latestclick','latest click'),('en','view users','view subscribers'),('en','Click Rate','Click rate'),('en','Total','Total'),('en','To install phpList, you need to enable Javascript','To install phpList, you need to enable Javascript'),('en','The default system language is different from your browser language.','The default system language is different from your browser language.'),('en','You can set <pre>$default_system_language = \\\"%s\\\";</pre> in your config file, to use your language as the fallback language.','You can set <pre>$default_system_language = \\\"%s\\\";</pre> in your config file, to use your language as the fallback language.'),('en','It is best to do this before initialising the database.','It is best to do this before initialising the database.'),('en','phpList initialisation','phpList initialisation'),('en','Please enter your name.','Please enter your name.'),('en','The name of your organisation','The name of your organisation'),('en','Please enter your email address.','Please enter your email address.'),('en','The initial <i>login name</i> will be','The initial <i>login name</i> will be'),('en','Please enter the password you want to use for this account.','Please enter the password you want to use for this account.'),('en','minimum of 8 characters.','minimum of 8 characters.'),('en','creating tables','creating tables'),('en','Initialising table','Initialising table'),('en','Table already exists','Table already exists'),('en','OK','OK'),('en','Initialise plugin','Initialise plugin'),('en','List for testing.','List for testing.'),('en','Sign up to our newsletter','Sign up to our newsletter'),('en','Tell us about it','Tell us about it'),('en','Please make sure to read the file README.security that can be found in the zip file.','Please make sure to read the file README.security that can be found in the zip file.'),('en','Please make sure to','Please make sure to'),('en','subscribe to the announcements list','subscribe to the announcements list'),('en','to make sure you are updated when new versions come out. Sometimes security bugs are found which make it important to upgrade. Traffic on the list is very low.','to make sure you are updated when new versions come out. Sometimes security bugs are found which make it important to upgrade. Traffic on the list is very low.'),('en','Continue with','Continue with'),('en','phpList Setup','phpList Setup'),('en','Maybe you want to','Maybe you want to'),('en','instead?','instead?'),('en','Force Initialisation','Force Initialisation'),('en','(will erase all data!)','(will erase all data!)'),('en','Your database is out of date, please make sure to upgrade','Your database is out of date, please make sure to upgrade'),('en','Your version','Your version'),('en','phplist version','<a href=http://www.phplist.com>phpList</a> version'),('en','Database has not been initialised','Database has not been initialised'),('en','go to','go to'),('en','to continue','to continue'),('en','A new version of phpList is available!','A new version of phpList is available!'),('en','The new version may have fixed security issues,<br/>so it is recommended to upgrade as soon as possible','The new version may have fixed security issues,<br/>so it is recommended to upgrade as soon as possible'),('en','Latest version','Latest version'),('en','Read what has changed in the new version','Read what has changed in the new version'),('en','View what has changed','View what has changed'),('en','Download the new version','Download the new version'),('en','Download','Download'),('en','Continue the Configuration process of phpList','Continue the Configuration process of phpList'),('en','Send a campaign','Send a campaign'),('en','Start or continue a campaign','Start or continue a campaign'),('en','Manage Campaigns','Manage campaigns'),('en','View current campaigns','View current campaigns'),('en','Search, edit and add Subscribers','Search, edit and add subscribers'),('en','Main','Main'),('en','Manage Lists','Manage lists'),('en','View, edit and add lists, that your subscribers can sign up to','View, edit and add lists, that your subscribers can sign up to'),('en','List all Users','List all subscribers'),('en','Import Users','Import subscribers'),('en','Export','Export'),('en','Export Users','Export subscribers'),('en','reconcileusers','Reconcile subscribers'),('en','Reconcile the User Database','Reconcile the subscriber database'),('en','List and user functions','List and user functions'),('en','Configure','Configure'),('en','attributes','Attributes'),('en','Control values for','Control values for'),('en','spage','Subscribe page'),('en','Configure Subscribe Pages','Configure subscribe pages'),('en','Configuration Functions','Configuration functions'),('en','admins','admins'),('en','Add, edit and remove Administrators','Add, edit and remove Administrators'),('en','adminattributes','Admin attributes'),('en','Configure Attributes for administrators','Configure Attributes for administrators'),('en','Administrator Functions','Administrator functions'),('en','send','Send'),('en','Send a Message','Send a campaign'),('en','preparesend','preparesend'),('en','Prepare a Message','Prepare a Message'),('en','sendprepared','sendprepared'),('en','Send a Prepared Message','Send a Prepared Message'),('en','templates','templates'),('en','Configure Templates','Configure templates'),('en','List all Messages','List all campaigns'),('en','Process the Message Queue','Process the Queue'),('en','warning','Warning'),('en','You have set TEST in config.php to 1, so it will only show what would be sent','You have set TEST in config.php to 1, so it will only show what would be sent'),('en','processbounces','Process bounces'),('en','Process Bounces','Process Bounces'),('en','View Bounces','View Bounces'),('en','Message Functions','Campaign functions'),('en','Plugins','Plugins'),('en','Setup','Setup'),('en','dbcheck','Check database'),('en','Check Database structure','Check Database structure'),('en','eventlog','Eventlog'),('en','View the eventlog','View the eventlog'),('en','admin','admin'),('en','Change your details (e.g. password)','Change your details (e.g. password)'),('en','System Functions','System functions'),('en','Sorry, this help topic does not exist in your language. Below is the english version.','Sorry, this help topic does not exist in your language. Below is the english version.'),('en','Sorry, this help topic does not exist in your language.','Sorry, this help topic does not exist in your language.'),('en','The settings have been reset to the phpList default','The settings have been reset to the phpList default'),('en','Are you sure you want to reset the configuration to the default?','Are you sure you want to reset the configuration to the default?'),('en','Reset to default','Reset to default'),('en','You can edit all of the values in this page, and click the \\\"save changes\\\" button once to save all the changes you made.','You can edit all of the values in this page, and click the \\\"save changes\\\" button once to save all the changes you made.'),('en','cannot be empty','cannot be empty'),('en','Changes not saved','Changes not saved'),('en','settings','settings'),('en','edit this value','edit this value'),('en','Edit','Edit'),('en','No such record','No such record'),('en','Back to the list of bounces','Back to the list of bounces'),('en','Not Found','Not Found<br/>'),('en','Added %s to bouncecount for subscriber %s','Added %s to bouncecount for subscriber %s<br/>'),('en','Made subscriber %s unconfirmed','Made subscriber %s unconfirmed'),('en','Made subscriber %d to receive text','Made subscriber %d to receive text'),('en','Deleted subscriber %d','Deleted subscriber %d'),('en','Deleting bounce %d ..','Deleting bounce %d  ..'),('en','..Done, loading next bounce..','..Done, loading next bounce..'),('en','This bounce no longer exists in the database.','This bounce no longer exists in the database.'),('en','For subscriber with email','For subscriber with email'),('en','Increase bouncecount with','Increase bouncecount with'),('en','(use negative numbers to decrease)','(use negative numbers to decrease)'),('en','Mark subscriber as unconfirmed','Mark subscriber as unconfirmed'),('en','(so you can resend the request for confirmation)','(so you can resend the request for confirmation)'),('en','Set subscriber to receive text instead of HTML','Set subscriber to receive text instead of HTML'),('en','delete subscriber','delete subscriber'),('en','Delete this bounce and go to the next','Delete this bounce and go to the next'),('en','Do the above','Do the above'),('en','Create New Rule based on this bounce','Create New Rule based on this bounce'),('en','Possible Actions:','Possible Actions:'),('en','ID','ID'),('en','Comment','Comment'),('en','Header','Header'),('en','Body','Body'),('en','Bounce Details','Bounce details'),('en','New Rule','New rule'),('en','Test email not set','Test email address not set'),('en','Sending HTML version to','Sending HTML version to'),('en','Sending Text version to','Sending text version to'),('en','Note: Links in emails will not work, because this is a test message, which is deleted after sending','Note: Links in emails will not work, because this is a test message, which is deleted after sending'),('en','Check your INBOX to see if all worked ok','Check your INBOX to see if all worked ok'),('en','Converting to UTF-8 requires sufficient diskspace on your system.','Converting to UTF-8 requires sufficient diskspace on your system.'),('en','The maximum table size in your system is %s and space available on the root filesystem is %s, which means %s is required.','The maximum table size in your system is %s and space available on the root filesystem is %s, which means %s is required.'),('en','This is not a problem if your Database server is on a different filesystem. Click the button to continue.','This is not a problem if your Database server is on a different filesystem. Click the button to continue.'),('en','Otherwise, free up some diskspace and try again','Otherwise, free up some diskspace and try again'),('en','Confirm UTF8 conversion','Confirm UTF8 conversion'),('en','Converting DB to use UTF-8, please wait','Converting DB to use UTF-8, please wait'),('en','Unable to determine the name of the database to convert','Unable to determine the name of the database to convert'),('en','The DB was already converted to UTF-8 on','The DB was already converted to UTF-8 on'),('en','Certified Secure by','Certified secure by'),('en','phpList is licensed with the %sGNU Public License (GPL)%s','phpList is licensed with the %sGNU Public License (GPL)%s'),('en','Developers','Developers'),('en','Contributors','Contributors'),('en','Design','Design'),('en','Design implementation','Design implementation'),('en','Documentation','Documentation'),('en','Translations','Translations'),('en','The translations are provided by the phpList community (that includes you :-) )','The translations are provided by the phpList community (that includes you :-) )'),('en','The <a href=\\\"http://translate.phplist.com/\\\" target=\\\"translate\\\">translation site</a> runs <a href=\\\"http://translate.sourceforge.net/\\\" target=\\\"pootle\\\">Pootle</a> an Open Source translation tool, provided by <a href=\\\"http://translatehouse.org\\\" target=\\\"translatehouse\\\">Translate House</a>','The <a href=\\\"http://translate.phplist.com/\\\" target=\\\"translate\\\">translation site</a> runs <a href=\\\"http://translate.sourceforge.net/\\\" target=\\\"pootle\\\">Pootle</a> an Open Source translation tool, provided by <a href=\\\"http://translatehouse.org\\\" target=\\\"translatehouse\\\">Translate House</a>'),('en','Acknowledgements','Acknowledgements'),('en','The developers wish to thank the many contributors to this system, who have helped out with bug reports, suggestions, donations, feature requests, sponsoring, translations and many other contributions.','The developers wish to thank the many contributors to this system, who have helped out with bug reports, suggestions, donations, feature requests, sponsoring, translations and many other contributions.'),('en','Portions of the system include','Portions of the system include'),('en','All done, %d emails processed<br/>%d emails blacklisted<br/>%d emails deleted<br/>%d emails not found','All done, %d emails processed<br/>%d emails blacklisted<br/>%d emails deleted<br/>%d emails not found'),('en','Remove more','Remove more'),('en','Mass remove email addresses','Mass remove email addresses'),('en','Check to also add the emails to the blacklist','Check to also add the emails to the blacklist'),('en','Paste the emails to remove in this box, and click continue','Paste the emails to remove in this box, and click continue'),('en','List of Administrators','List of administrators'),('en','No Access','You do not have sufficient access'),('en','Error adding new admin, login name and/or email not inserted, email not valid or admin already exists','Error adding new administrator. Login name and/or email not inserted, email address not valid or admin already exists'),('en','Failed, you cannot delete yourself','Failed, you cannot delete yourself'),('en','Edit Administrator','Edit administrator'),('en','Add a new administrator','Add a new administrator'),('en','hidden','hidden'),('en','Update it?','Update it?'),('en','Remind it?','Remind it?'),('en','Login Name','Login name'),('en','You do not have enough priviliges to view this page','You do not have enough priviliges to view this page'),('en','Members of','Members of'),('en','edit list details','edit list details'),('en','Download subscribers','Download subscribers'),('en','Import Subscribers to this list','Import subscribers to this list'),('en','subscribers were moved to','subscribers were moved to'),('en','subscribers were copied to','subscribers were copied to'),('en','subscribers were deleted from this list','subscribers were deleted from this list'),('en','Users found, click add to add this user','subscribers found, click add to add this subscriber'),('en','No user found with that email','No subscriber found with that email'),('en','add user','Add subscriber'),('en','Inserting user','Inserting subscriber'),('en','Removing %d from this list','Removing %d from this list'),('en','Listing subscriber %d to %d','Listing subscriber %d to %d'),('en','Listing subscriber 1 to 50','Listing subscriber 1 to 50'),('en','%d subscribers','%d subscribers'),('en','Tag all users in this page','Tag all subscribers in this page'),('en','Members','Members'),('en','Actions','Actions'),('en','What to do with \\\"Tagged\\\" users','What to do with \\\"Tagged\\\" subscribers'),('en','This will only process the users in this page that have the \\\"Tag\\\" checkbox checked','This will only process the subscribers in this page that have the \\\"Tag\\\" checkbox checked'),('en','from this list','from this list'),('en','Move','Move'),('en','Copy','Copy'),('en','Nothing','Nothing'),('en','What to do with all subscribers','What to do with all subscribers'),('en','This will process all subscribers on this list, confirmed and unconfirmed','This will process all subscribers on this list, confirmed and unconfirmed'),('en','do it','do it'),('en','Connection refused, check your host, user or password','Connection refused, check your host, user or password'),('en','Processed','Processed'),('en','unidentified','unidentified'),('en','view bounces by list','view bounces by list'),('en','are you sure you want to delete all unidentified bounces older than 2 months','are you sure you want to delete all unidentified bounces older than 2 months'),('en','delete all unidentified (&gt; 2 months old)','delete all unidentified (&gt; 2 months old)'),('en','are you sure you want to delete all bounces older than 2 months','Are you sure you want to delete all bounces older than 2 months'),('en','delete all processed (&gt; 2 months old)','Delete all processed (&gt; 2 months old)'),('en','are you sure you want to delete all bounces','are you sure you want to delete all bounces'),('en','delete all','delete all'),('en','no unidentified bounces available','no unidentified bounces available'),('en','no processed bounces available','no processed bounces available'),('en','System Message','System message'),('en','Message','Message'),('en','Website address (without http://)','Website address (without http://)'),('en','Domain Name of your server (for email)','Domain Name of your server (for email)'),('en','Person in charge of this system (one email address)','Person in charge of this system (one email address)'),('en','Name of the organisation','Name of the organisation'),('en','How often do you want to check for a new version of phplist (days)','How often do you want to check for a new version of phpList (days)'),('en','List of email addresses to CC in system messages (separate by commas)','List of email addresses to CC in system messages (separate by commas)'),('en','Default for \'From:\' in a campaign','Default for \'From:\' in a campaign'),('en','Default for \'address to alert when sending starts\'','Default for \'email address to alert when sending starts\''),('en','Default for \'address to alert when sending finishes\'','Default for \'email address to alert when sending finishes\''),('en','Always add Google tracking code to campaigns','Always add Google tracking code to campaigns'),('en','Who gets the reports (email address, separate multiple emails with a comma)','Who gets the reports (email address, separate multiple emails with a comma)'),('en','From email address for system messages','From email address for system messages'),('en','Webmaster','Webmaster'),('en','Name for system messages','Name for system messages'),('en','Reply-to email address for system messages','Reply-to email address for system messages'),('en','If there is only one visible list, should it be hidden in the page and automatically subscribe users who sign up','If there is only one visible list, should it be hidden in the page and automatically subscribe users who sign up'),('en','Categories for lists. Separate with commas.','Categories for lists. Separate with commas.'),('en','Width of a textline field (numerical)','width of a textline field (numerical)'),('en','Dimensions of a textarea field (rows,columns)','dimensions of a textarea field (rows,columns)'),('en','Send notifications about subscribe, update and unsubscribe','Send notifications about subscribe, update and unsubscribe'),('en','The default subscribe page when there are multiple','The default subscribe page when there are multiple'),('en','The default HTML template to use when sending a message','The default HTML template to use when sending a message'),('en','The HTML wrapper template for system messages','The HTML wrapper template for system messages'),('en','URL where subscribers can sign up','URL where subscribers can sign up'),('en','URL where subscribers can unsubscribe','URL where subscribers can unsubscribe'),('en','URL where unknown users can unsubscribe (do-not-send-list)','URL where unknown visitors can unsubscribe (do-not-send-list)'),('en','URL where subscribers have to confirm their subscription','URL where subscribers have to confirm their subscription'),('en','URL where subscribers can update their details','URL where subscribers can update their details'),('en','URL for forwarding messages','URL for forwarding messages'),('en','<h3>Thanks, you have been added to our newsletter</h3><p>You will receive an email to confirm your subscription. Please click the link in the email to confirm</p>','<h3>Thanks, you have been added to our newsletter</h3><p>You will receive an email message to confirm your subscription. Please click the link in the email to confirm</p>'),('en','Text to display when subscription with an AJAX request was successful','Text to display when subscription with an AJAX request was successful'),('en','Request for confirmation','Request for confirmation'),('en','Subject of the message subscribers receive when they sign up','Subject of the message subscribers receive when they sign up'),('en','Message subscribers receive when they sign up','Message subscribers receive when they sign up'),('en','Goodbye from our Newsletter','Goodbye from our newsletter'),('en','Subject of the message subscribers receive when they unsubscribe','Subject of the message subscribers receive when they unsubscribe'),('en','Message subscribers receive when they unsubscribe','Message subscribers receive when they unsubscribe'),('en','Welcome to our Newsletter','Welcome to our Newsletter'),('en','Subject of the message subscribers receive after confirming their email address','Subject of the message subscribers receive after confirming their email address'),('en','Message subscribers receive after confirming their email address','Message subscribers receive after confirming their email address'),('en','[notify] Change of List-Membership details','[notify] Change of List-Membership details'),('en','Subject of the message subscribers receive when they have changed their details','Subject of the message subscribers receive when they have changed their details'),('en','Message subscribers receive when they have changed their details','Message content subscribers receive when they have changed their details'),('en','Part of the message that is sent to their new email address when subscribers change their information, and the email address has changed','Part of the message that is sent to their new email address when subscribers change their information, and the email address has changed'),('en','Part of the message that is sent to their old email address when subscribers change their information, and the email address has changed','Part of the message that is sent to their old email address when subscribers change their information, and the email address has changed'),('en','Your personal location','Your personal location'),('en','Subject of message when subscribers request their personal location','Subject of message to send when subscribers request their personal location'),('en','Message when subscribers request their personal location','Content of message to send when subscribers request their personal location'),('en','Default footer for sending a campaign','Default footer for sending a campaign'),('en','Footer used when a message has been forwarded','Footer used when a message has been forwarded'),('en','Header of public pages.','Header of public pages'),('en','Footer of public pages','Footer of public pages'),('en','Message to send when they request their personal location','Message to send when they request their personal location'),('en','String to always append to remote URL when using send-a-webpage','String to always append to remote URL when using send-a-webpage'),('en','Width for Wordwrap of Text messages','Width for Wordwrap of Text messages'),('en','CSS for HTML messages without a template','CSS for HTML messages without a template'),('en','Domains that only accept text emails, one per line','Domains that only accept text emails, one per line'),('en','last time TLDs were fetched','last time TLDs were fetched'),('en','Top level domains','Top level domains'),('en','Back to edit template','Back to edit template'),('en','phplist test suite','phplist test suite'),('en','Test passed','Test passed'),('en','Test failed','Test failed'),('en','Tests available','Tests available'),('en','Purpose','Purpose'),('en','This page requires Javascript to be enabled.','This page requires Javascript to be enabled.'),('en','Processing queued campaigns','Processing queued campaigns'),('en','List Bounce Rules','List Bounce Rules'),('en','View Bounces per list','View Bounces per list'),('en','Check Current Bounce Rules','Check Current Bounce Rules'),('en','You currently have no rules defined.      You can click \\\"Generate Bounce Rules\\\" in order to auto-generate rules from your existing bounces.      This will results in a lot of rules which you will need to review and activate.      It will however, not catch every single bounce, so it will be necessary to add new rules over      time when new bounces come in.','You currently have no rules defined. You can click Generate Bounce Rules in order to auto-generate rules from your existing bounces. This will results in a lot of rules which you will need to review and activate. It will however, not catch every single bounce, so it will be necessary to add new rules over time when new bounces come in.'),('en','You have already defined bounce rules in your system.      Be careful with generating new ones, because these may interfere with the ones that exist.','You have already defined bounce rules in your system.      Be careful with generating new ones, because these may interfere with the ones that exist.'),('en','Generate Bounce Rules','Generate Bounce Rules'),('en','over treshold, user marked unconfirmed','over treshold, subscriber marked unconfirmed'),('en','Invalid security token. Please reload the page and try again.','Invalid security token, please reload the page and try again'),('en','phpList Export on %s from %s to %s (%s).csv','phpList subscribers on %s from %s to %s (%s).csv'),('en','phpList Export from %s to %s (%s).csv','phpList subscribers from %s to %s (%s).csv'),('en','List Membership','List Membership'),('en','Export subscribers on %s','<h4>Export subscribers on %s</h4>'),('en','What date needs to be used:','What date needs to be used:'),('en','Any date','Any date'),('en','When they signed up','When they signed up'),('en','When the record was changed','When the record was changed'),('en','Based on changelog','Based on changelog'),('en','When they subscribed to','When they subscribed to'),('en','Date From:','Date From:'),('en','Date To:','Date To:'),('en','Select the columns to include in the export','Select the columns to include in the export'),('en','add_list','Add a new list'),('en','Please enter details of the remote Server','Please enter details of the remote server'),('en','Server:','Server'),('en','Password:','Password'),('en','Database Name:','Database Name'),('en','Table prefix:','Table prefix'),('en','Usertable prefix:','Usertable prefix'),('en','select_lists','Select the lists'),('en','Copy lists from remote server (lists are matched by name)','Copy lists from remote server (lists are matched by name)'),('en','Mark new users as HTML:','Mark new subscribers as HTML'),('en','If you check \\\"Overwrite Existing\\\", information about a user in the database will be replaced by the imported information. Users are matched by email.','If you check \\\"Overwrite existing\\\", information about a subscriber in the database will be replaced by the imported information. Subscribers are matched by email.'),('en','Overwrite Existing:','Overwrite existing'),('en','Making connection with remote database','Making connection with remote database'),('en','cannot connect to remote database','Unable to connect to the remote database'),('en','Getting data from','Getting data from'),('en','Remote version is','Remote version is'),('en','Remote version has','Remote version has'),('en','No users to copy, is the prefix correct?','No subscribers to copy, is the prefix correct?'),('en','Copying lists','Copying lists'),('en','exists locally','exists locally'),('en','created locally','created locally'),('en','Remote list','Remote list'),('en','not created','not created'),('en','Copying attributes','Copying attributes'),('en','Copying users','Copying subscribers'),('en','Error, no mapped attribute for','Error, no mapped attribute for'),('en','Error, no local list defined for','Error, no local list defined for'),('en','new users','new subscribers'),('en','and','and'),('en','existing users','existing subscribers'),('en','pagetitle:home','Dashboard'),('en','pagetitle:setup','Configuration'),('en','pagetitle:about','About phpList'),('en','pagetitle:attributes','Configure attributes'),('en','pagetitle:stresstest','Stress test'),('en','pagetitle:list','Subscriber lists'),('en','pagetitle:catlists','Categorise lists'),('en','pagetitle:editattributes','Configure attributes'),('en','pagetitle:editlist','Edit a list'),('en','pagetitle:checki18n','Check that translations exist'),('en','pagetitle:importsimple','Import subscribers by copy-and-paste'),('en','pagetitle:import4','Import subscribers from a remote database'),('en','pagetitle:import3','Import subscribers from IMAP'),('en','pagetitle:import2','Import subscribers from CSV file'),('en','pagetitle:import1','Import subscribers from text file'),('en','pagetitle:import','Import emails'),('en','pagetitle:export','Export subscribers'),('en','pagetitle:initialise','Initialise the database'),('en','pagetitle:send','Send a campaign'),('en','pagetitle:preparesend','Prepare a message for sending'),('en','pagetitle:sendprepared','Send a prepared message'),('en','pagetitle:members','List membership'),('en','pagetitle:users','Search subscribers'),('en','pagetitle:reconcileusers','Reconcile subscribers'),('en','pagetitle:user','Details of a subscriber'),('en','pagetitle:userhistory','History of a subscriber'),('en','pagetitle:messages','List of campaigns'),('en','pagetitle:message','View a campaign'),('en','pagetitle:processqueue','Send the queue'),('en','pagetitle:defaults','Some default attribute values'),('en','pagetitle:upgrade','Upgrade phpList'),('en','pagetitle:templates','Manage campaign templates'),('en','pagetitle:template','Add or edit a template'),('en','pagetitle:viewtemplate','Template preview'),('en','pagetitle:configure','Settings'),('en','pagetitle:admin','Edit or add an administrator'),('en','pagetitle:admins','Manage administrators'),('en','pagetitle:adminattributes','Configure administrator attributes'),('en','pagetitle:processbounces','Process bounces'),('en','pagetitle:bounces','View bounces'),('en','pagetitle:bounce','View a bounce'),('en','pagetitle:spageedit','Edit a subscribe page'),('en','pagetitle:spage','Subscribe pages'),('en','pagetitle:eventlog','Log of events'),('en','pagetitle:getrss','Retrieve RSS feeds'),('en','pagetitle:viewrss','View RSS items'),('en','pagetitle:community','Help'),('en','pagetitle:vote','Vote for phpList'),('en','pagetitle:login','Login'),('en','pagetitle:logout','Log out'),('en','pagetitle:mclicks','Campaign click statistics'),('en','pagetitle:uclicks','URL click statistics'),('en','pagetitle:massunconfirm','Suppression list'),('en','pagetitle:massremove','Remove subscribers'),('en','pagetitle:usermgt','Manage subscribers'),('en','pagetitle:bouncemgt','Manage bounces'),('en','pagetitle:domainstats','Domain statistics'),('en','pagetitle:mviews','View opens'),('en','pagetitle:statsmgt','Manage statistics'),('en','pagetitle:statsoverview','Statistics overview'),('en','pagetitle:subscriberstats','Subscriber statistics'),('en','pagetitle:dbcheck','Verify the DB structure'),('en','pagetitle:importadmin','Import administrators'),('en','pagetitle:dbadmin','DB management'),('en','pagetitle:usercheck','Verify that subscribers exist'),('en','pagetitle:listbounces','View bounces per list'),('en','pagetitle:bouncerules','Bounce rules'),('en','pagetitle:checkbouncerules','Check bounce rules'),('en','pagetitle:translate','Translate phpList'),('en','pagetitle:ajaxform','Ajax integration'),('en','pagetitle:updatetranslation','Update translations'),('en','pagetitle:reindex','Rebuild DB indexes'),('en','pagetitle:config','Settings'),('en','pagetitle:info','System info'),('en','pagetitle:converttoutf8','Convert to UTF8'),('en','pagetitlehover:home','Go to the dashboard page'),('en','pagetitlehover:setup','List of things to do to configure phpList correctly'),('en','pagetitlehover:about','More information about the phpList application'),('en','pagetitlehover:attributes','Create, edit and change attributes for subscribers'),('en','pagetitlehover:stresstest','Stress test'),('en','pagetitlehover:list','Lists that subscribers can sign up to'),('en','pagetitlehover:catlists','Organise the subscriber lists in categories'),('en','pagetitlehover:editattributes','Edit the details for an attribute'),('en','pagetitlehover:editlist','Change the details for a list'),('en','pagetitlehover:checki18n','Verify the existing translations'),('en','pagetitlehover:importsimple','Import subscribers by copying them from a document and pasting them into phpLIst'),('en','pagetitlehover:import4','Import subscribers from a remote database'),('en','pagetitlehover:import3','Import subscribers from IMAP'),('en','pagetitlehover:import2','Import subscribers from a file containing their email and additional information'),('en','pagetitlehover:import1','Import subscribers by uploading a plan-text file with email addresses'),('en','pagetitlehover:import','Import subscribers into the database'),('en','pagetitlehover:export','Download subscribers in the system'),('en','pagetitlehover:initialise','Create all the database tables required for phpList to work correctly'),('en','pagetitlehover:send','Create a campaign to send out to your subscribers'),('en','pagetitlehover:preparesend','Prepare a message for sending'),('en','pagetitlehover:sendprepared','Send a prepared message'),('en','pagetitlehover:members','View the subscribers who are member of a list'),('en','pagetitlehover:users','Search subscribers in the system'),('en','pagetitlehover:reconcileusers','Several functions to clean up the database of subscribers'),('en','pagetitlehover:user','View the details of a subscriber'),('en','pagetitlehover:userhistory','View the history of the profile  of a subscriber'),('en','pagetitlehover:messages','View the list of campaigns'),('en','pagetitlehover:message','View details for a campaign'),('en','pagetitlehover:processqueue','Send the queued campaigns'),('en','pagetitlehover:defaults','Choose from some common attributes provided by the phpList community'),('en','pagetitlehover:upgrade','Upgrade the phpList database to be in line with the current version of the code'),('en','pagetitlehover:templates','View and manage campaign templates, that are used to send out HTML emails'),('en','pagetitlehover:template','Add or edit a campaign template'),('en','pagetitlehover:viewtemplate','Template preview'),('en','pagetitlehover:configure','Change the settings that control how phpList behaves'),('en','pagetitlehover:admin','Edit or add an administrator who can login to phpList to manage aspects of the system'),('en','pagetitlehover:admins','View, edit and add administrators who have access to all or part of the phpList system'),('en','pagetitlehover:adminattributes','Configure administrator attributes'),('en','pagetitlehover:processbounces','Fetch the bounced emails from the bounce mailbox and process them'),('en','pagetitlehover:bounces','View the bounced emails in the system'),('en','pagetitlehover:bounce','View a bounce'),('en','pagetitlehover:spageedit','Edit a page your subscribers can use to sign up to the system'),('en','pagetitlehover:spage','View and edit the pages that subscribers can use to sign up to the system'),('en','pagetitlehover:eventlog','View some interesting events that have happened in phpList'),('en','pagetitlehover:getrss','Retrieve RSS feeds'),('en','pagetitlehover:viewrss','View RSS items'),('en','pagetitlehover:community','How to get help and how to help out with phpList'),('en','pagetitlehover:vote','Vote for phpList on sites around the world'),('en','pagetitlehover:login','Login'),('en','pagetitlehover:logout','Log out'),('en','pagetitlehover:mclicks','Statistics of subscribers who clicked on links in the campaigns'),('en','pagetitlehover:uclicks','Statistics for URLs that were sent out across all campaigns, listed by URL'),('en','pagetitlehover:massunconfirm','Manage the list of subscribers who should NOT be sent emails'),('en','pagetitlehover:massremove','Remove subscribers from the system.'),('en','pagetitlehover:usermgt','Common functions to manage the subscribers'),('en','pagetitlehover:bouncemgt','Manage messages that were returned due to delivery errors'),('en','pagetitlehover:domainstats','Statistics of domains of the subscribers in the system'),('en','pagetitlehover:mviews','View who opened the campaigns that were sent out'),('en','pagetitlehover:statsmgt','List of common statistics functions in phpList'),('en','pagetitlehover:statsoverview','Summary of statistics of the last few campaigns sent out'),('en','pagetitlehover:subscriberstats','Subscriber statistics'),('en','pagetitlehover:dbcheck','Verify that the current database structure is correct for the current version of the code'),('en','pagetitlehover:importadmin','Import administrators who have access to all or some parts of the system'),('en','pagetitlehover:dbadmin','DB management'),('en','pagetitlehover:usercheck','Copy and paste a list of emails and verify that they exist in the system, without adding them'),('en','pagetitlehover:listbounces','View bounced emails per subscriber list'),('en','pagetitlehover:bouncerules','Manage the rules that determine what to do with bounced emails'),('en','pagetitlehover:checkbouncerules','Check bounce rules'),('en','pagetitlehover:translate','Translate phpList'),('en','pagetitlehover:ajaxform','Ajax integration'),('en','pagetitlehover:updatetranslation','Fetch the latest translation from the community translation system'),('en','pagetitlehover:reindex','Rebuild database indexes to speed up database queries'),('en','pagetitlehover:config','Configuration functions'),('en','pagetitlehover:info','System information, useful for developers and more technical people'),('en','pagetitlehover:converttoutf8','Check and action upgrade of the phpList database to use UTF8, which allows the use of special characters'),('en','Subscribe page information saved','Subscribe page information saved'),('en','Title of this set of lists','Title of this set of lists'),('en','Please indicate how often you want to receive messages','Please indicate how often you want to receive messages'),('en','General Information','General Information'),('en','title','title'),('en','default','default'),('en','Language file to use','Language file to use'),('en','Intro','Intro'),('en','Thank you page','Thank you page'),('en','Text for Button','Text for button'),('en','HTML Email choice','HTML Email choice'),('en','Don\'t offer choice, default to <b>text</b>','Don\'t offer choice, default to <b>text</b>'),('en','Don\'t offer choice, default to <b>HTML</b>','Don\'t offer choice, default to <b>HTML</b>'),('en','Offer checkbox for text','Offer checkbox for text'),('en','Offer checkbox for HTML','Offer checkbox for HTML'),('en','Radio buttons, default to text','Radio buttons, default to text'),('en','Radio buttons, default to HTML','Radio buttons, default to HTML'),('en','Display email confirmation','Display email address confirmation field'),('en','Don\'t display email confirmation','Don\'t display email address confirmation field'),('en','Transaction messages','Transaction messages'),('en','Message they receive when they subscribe','Content of message subscribers receive when they subscribe'),('en','Message they receive when they confirm their subscription','Message they receive when they confirm their subscription'),('en','Message they receive when they unsubscribe','Content of the message they receive when they unsubscribe'),('en','Select the attributes to use','Select the attributes to use'),('en','Check this box to use this attribute in the page','Check this box to use this attribute in the page'),('en','Information needed for %s','Information needed for %s'),('en','Select the lists to offer','Select the lists to offer'),('en','You can only select \\\"public\\\" lists for subscribe pages.','You can only select \\\"public\\\" lists for subscribe pages.'),('en','No lists available, please create one first','No lists available, please create one first'),('en','owner','owner'),('en','default login is','Default login is'),('en','with password','with password'),('en','In order to login, you need to enable cookies in your browser','In order to login, you need to enable cookies in your browser'),('en','Forgot password','Forgot Password?'),('en','Enter your email address','Enter your email address'),('en','Send password','Send Password'),('en','Your password was changed succesfully','Your password was changed successfully'),('en','The passwords you entered are not the same.','The passwords you entered are not the same.'),('en','You have requested a password update','You have requested a password update'),('en','New password','New password'),('en','Confirm password','confirm password'),('en','Unknown token or time expired (More than 24 hrs. passed since the notification email was sent)','Unknown token or time expired (More than 24 hrs. passed since the notification email was sent)'),('en','Choose a message','Choose a campaign'),('en','Listing %s to %s','Listing %s to %s'),('en','Add new admin','Add new admin'),('en','You cannot delete yourself','You cannot delete yourself'),('en','Admin added','Admin added'),('en','Administrators','Administrators'),('en','found','found'),('en','Find an admin','Find an admin'),('en','Show','Show'),('en','Import list of admins','Import list of admins'),('en','Open Source','Open Source'),('en','How to get help','How to get help'),('en','How to help out','How to help out'),('en','phpList is Open Source software','phpList is Open Source software'),('en','The concept behind open source is collaboration. A loosely organised network of many contributors where the whole is greater than the sum of its parts.','The concept behind open source is collaboration. A loosely organised network of many contributors where the whole is greater than the sum of its parts.'),('en','If you are interested to know more about Open Source, you can visit the links below','If you are interested to know more about Open Source, you can visit the links below'),('en','Get help with phpList','Get help with phpList'),('en','To be written. In the meantime you can <a href=\\\"http://www.phplist.com/support\\\">visit the support section on the phpList website</a>','To be written. In the meantime you can <a href=\\\"http://www.phplist.com/support\\\">visit the support section on the phpList website</a>'),('en','Help out with phpList','Help out with phpList'),('en','To be written. In the meantime you can <a href=\\\"http://www.phplist.com/developers\\\">visit the developers section on the phpList website</a>','To be written. In the meantime you can <a href=\\\"http://www.phplist.com/developers\\\">visit the developers section on the phpList website</a>'),('en','Initialising language','Initialising language'),('en','Up to date','Up to date'),('en','The plugin','The plugin'),('en','Invalid download URL, please reload the page and try again','Invalid download URL, please reload the page and try again'),('en','Fetching plugin','Fetching plugin'),('en','developer','Developer'),('en','Project','Project'),('en','Unable to download plugin package, check your connection','Unable to download plugin package, check your connection'),('en','Installing plugin','Installing plugin'),('en','updating existing plugin','updating existing plugin'),('en','new plugin','new plugin'),('en','Plugin installed successfully','Plugin installed successfully'),('en','Error installing plugin','Error installing plugin'),('en','Plugin directory is not writable','Plugin directory is not writable'),('en','Plugin installation failed','Plugin installation failed'),('en','The plugin root directory is not writable, please install plugins manually','The plugin root directory is not writable, please install plugins manually'),('en','PHP has no <a href=\\\"http://php.net/zip\\\">Zip capability</a>. This is required to allow installation from a remote URL','PHP has no <a href=\\\"http://php.net/zip\\\">Zip capability</a>. This is required to allow installation from a remote URL'),('en','Install a new plugin','Install a new plugin'),('en','Find plugins','Find plugins'),('en','Plugin package URL','Plugin package URL'),('en','Install plugin','Install plugin'),('en','Installed plugins','Installed plugins'),('en','version','version'),('en','Description','Description'),('en','installed','installed'),('en','installation Url','installation Url'),('en','enabled','enabled'),('en','Initialise','Initialise'),('en','delete this plugin','delete this plugin'),('en','update this plugin','update this plugin'),('en','update','update'),('en','unconfirm subscriber','unconfirm subscriber'),('en','blacklist subscriber','blacklist subscriber'),('en','blacklist email address','blacklist email address'),('en','delete subscriber and bounce','delete subscriber and bounce'),('en','unconfirm subscriber and delete bounce','unconfirm subscriber and delete bounce'),('en','blacklist subscriber and delete bounce','add subscriber to the do-not-send-list and delete bounce'),('en','blacklist email address and delete bounce','add email address to the do-no-send-list and delete bounce'),('en','delete bounce','delete bounce'),('en','Unnamed List','Unnamed list'),('en','Hello','Hello'),('en','You have requested a new password for phpList.','You have requested a new password for phpList.'),('en','To enter a new one, please visit the following link:','To enter a new one, please visit the following link:'),('en','You have 24 hours left to change your password. After that, your token won\'t be valid.','You have 24 hours left to change your password. After that, your token won\'t be valid.'),('en','A password change token has been sent to the corresponding email address.','A password change token has been sent to the corresponding email address.'),('en','Error sending password change token','Error sending password change token'),('en','Sending admin copy to','Sending admin copy to'),('en','very little time','very little time'),('en','This is the Newsletter Subject','This is the Newsletter Subject'),('en','A process for this page is already running and it was still alive %s seconds ago','A process for this page is already running and it was still alive %s seconds ago'),('en','Running commandline, quitting. We\'ll find out what to do in the next run.','Running commandline, quitting. We\'ll find out what to do in the next run.'),('en','Sleeping for 20 seconds, aborting will quit','Sleeping for 20 seconds, aborting will quit'),('en','We have been waiting too long, I guess the other process is still going ok','We have been waiting too long, I guess the other process is still going ok'),('en','Categorise lists','Categorise lists'),('en','Uncategorised','Uncategorised'),('en','You seem to have quite a lot of lists, do you want to organise them in categories?','You seem to have quite a lot of lists, do you want to organise them in categories?'),('en','Great idea!','Great idea!'),('en','View Members','View members of this list'),('en','Public','Public'),('en','Are you sure you want to delete this list?','Are you sure you want to delete this list?'),('en','delete this list','delete this list'),('en','Edit this list','Edit this list'),('en','start a new campaign targetting this list','start a new campaign targetting this list'),('en','Add Members','Add members'),('en','No lists, use Add List to add one','No lists, use Add List to add one'),('en','Import emails from IMAP folders','Import emails from IMAP folders'),('en','can\'t connect','can\'t connect'),('en','imap_getmailboxes failed','imap_getmailboxes failed'),('en','Please enter details of the IMAP account','Please enter details of the IMAP account'),('en','Server','Server'),('en','Select the headers fields to search','Select the headers fields to search'),('en','Mark new users as HTML','Mark new subscribers as HTML'),('en','If you check','If you check'),('en','information about a user in the database will be replaced by the imported information. Users are matched by email.','information about a subscriber in the database will be replaced by the imported information. Subscribers are matched by email.'),('en','Only use complete addresses','Only use complete addresses'),('en','addresses that do not have a real name will be ignored. Otherwise all emails will be imported.','addresses that do not have a real name will be ignored. Otherwise all emails will be imported.'),('en','If you choose','If you choose'),('en','the users you are adding will be sent the request for confirmation of subscription to which they will have to reply. This is recommended, because it will identify invalid emails.','the subscribers you are adding will be sent the request for confirmation of subscription to which they will have to reply. This is recommended, because it will identify invalid emails.'),('en','Send&nbsp;Notification&nbsp;email&nbsp;','Send&nbsp;Notification&nbsp;email&nbsp;'),('en','There are two ways to add the names of the users,  either one attribute for the entire name or two attributes, one for first name and one for last name. If you use &quot;two attributes&quot;, the name will be split after the first space.','There are two ways to add the names of the subscribers,  either one attribute for the entire name or two attributes, one for first name and one for last name. If you use \'two attributes\', the name will be split after the first space.'),('en','Use one attribute for name','Use one attribute for name'),('en','Use two attributes for the name','Use two attributes for the name'),('en','Attribute one','Attribute one'),('en','Create Attribute','Create Attribute'),('en','Attribute two','Attribute two'),('en','Cannot continue','Cannot continue'),('en','Process Selected Folders','Process Selected Folders'),('en','folders and','folders and'),('en','unique emails found','unique emails found'),('en','All the emails already exist in the database and are members of the','All the emails already exist in the database and are members of the'),('en','emails already existed in the database','emails already existed in the database'),('en','Invalid Emails found.','Invalid Emails found.'),('en','These records were added, but the email has been made up. You can find them by doing a search on','These records were added, but the email has been made up. You can find them by doing a search on'),('en','No emails found','No emails found'),('en','Please select a message to display','Please select a message to display'),('en','campaign requeued','Campaign re-queued'),('en','This campaign is scheduled to stop sending in the past. No mails will be sent.','This campaign is scheduled to stop sending in the past. No mails will be sent.'),('en','No such message','No such message'),('en','Edit this message','Edit this campaign'),('en','Attachments for this message','Attachments for this message'),('en','No attachments','No attachments'),('en','Mime Type','Mime Type'),('en','This campaign has been sent to subscribers, who are member of the following lists','This campaign has been sent to subscribers, who are member of the following lists'),('en','None yet','None yet'),('en','Except when they were also member of these lists','Except when they were also member of these lists'),('en','Send this (same) message to (a) new list(s)','Send this (same) message to (a) new list(s)'),('en','List is Active','List is Active'),('en','List is not Active','List is not Active'),('en','<b>Note:</b> this message has already been sent to all lists. To resend it to new users use the \\\"Requeue\\\" function.','<b>Note:</b> this message has already been sent to all lists. To resend it to new subscribers use the \\\"requeue\\\" function.'),('en','Resend','Resend'),('en','Existing subscribers','Existing subscribers'),('en','Non existing subscribers','Non existing subscribers'),('en','key','key'),('en','What is the type of information you want to check','What is the type of information you want to check'),('en','Paste the values to check in this box, one per line','Paste the values to check in this box, one per line'),('en','search subscribers','search subscribers'),('en','manage subscriber attributes','manage subscriber attributes'),('en','edit values for attributes','edit values for attributes'),('en','Reconcile Subscribers','Reconcile Subscribers'),('en','Suppression list','Suppression list'),('en','Bulk remove subscribers','Bulk remove subscribers'),('en','Verify subscribers','Verify subscribers'),('en','Import subscribers','Import subscribers'),('en','Export subscribers','Export subscribers'),('en','subscriber management functions','subscriber management functions'),('en','Available Messages','Available campaigns'),('en','in progress','in progress'),('en','entered','entered'),('en','Open statistics','Open statistics'),('en','Entries','Entries'),('en','firstview','firstview'),('en','lastview','lastview'),('en','Jan','Jan'),('en','Feb','Feb'),('en','Mar','Mar'),('en','Apr','Apr'),('en','Jun','Jun'),('en','Jul','Jul'),('en','Aug','Aug'),('en','Sep','Sep'),('en','Oct','Oct'),('en','Nov','Nov'),('en','Dec','Dec'),('en','Adding index <b>%s</b> to %s</li>','Adding index <b>%s</b> to %s</li>'),('en','Adding index <b>%s</b> to %s<br/>','Adding index <b>%s</b> to %s<br/>'),('en','Adding unique index <b>%s</b> to %s</li>','Adding unique index <b>%s</b> to %s</li>'),('en','Adding unique index <b>%s</b> to %s<br/>','Adding unique index <b>%s</b> to %s<br/>'),('en','Ascending','Ascending'),('en','Descending','Descending'),('en','Embargo','Embargo'),('en','Start a new campaign','Start a new campaign'),('en','draft','draft'),('en','static','static'),('en','Clear','Clear'),('en','Requeuing','Requeuing'),('en','Suspending','Suspending'),('en','Marking as sent','Marking as sent'),('en','Suspending all','Suspending all'),('en','Marking all as sent','Marking all as sent'),('en','Unique Views','Unique Views'),('en','Time to send','Time to send'),('en','PDF','PDF'),('en','both','both'),('en','Suspend','Suspend'),('en','Mark&nbsp;sent','Mark&nbsp;sent'),('en','Mark sent','Mark sent'),('en','Suspend All','Suspend all'),('en','Mark All Sent','Mark all sent'),('en','Deleted all entries older than 2 months','Deleted all entries older than 2 months'),('en','Deleted all entries','Deleted all entries'),('en','Events','Events'),('en','Are you sure you want to delete all events older than 2 months?','Are you sure you want to delete all events older than 2 months?'),('en','Delete all (&gt; 2 months old)','Delete all (&gt; 2 months old)'),('en','Are you sure you want to delete all events matching this filter?','Are you sure you want to delete all events matching this filter?'),('en','No events available','No events available'),('en','Filter','Filter'),('en','Exclude filter','Exclude filter'),('en','page','page'),('en','Hint: this page also works from commandline','Hint: this page also works from commandline'),('en','creating tables done','creating tables done'),('en','%d entries still to convert','%d entries still to convert'),('en','converting data','converting data'),('en','processing cancelled','processing cancelled'),('en','Optimizing table to recover space','Optimizing table to recover space'),('en','Finished','Finished'),('en','Convert some more','Convert some more'),('en','\\n-------------------------------------------------------------------------------- \\n    This is a notification of a possible spam attack to your phplist subscribe page.\\n    The data submitted has been copied below, so you can check whether this was actually the case.\\n    The submitted data has been converted into non-html characters, for security reasons.\\n    If you want to stop receiving this message, set \\n    \\n     define(\\\"NOTIFY_SPAM\\\",0);  \\n     \\n     in your phplist config file.  \\n     \\n     This subscriber has NOT been added to the database. \\n     If there is an error, you will need to  add them manually.\\n--------------------------------------------------------------------------------','\\n------------------------------------------------------------------------------- \\nThis is a notification of a possible spam attack to your phplist subscribe page.\\nThe data submitted has been copied below, so you can check whether this was actually the case. \\nThe submitted data has been converted into non-html characters, for security reasons.\\nIf you want to stop receiving this message, set \\n\\ndefine(NOTIFY_SPAM,0);\\n\\n in your phplist config file.\\nThis subscriber has not been added to the database.\\nIf there is an error, you will need to  add them manually\\n\\n --------------------------------------------------------------------------------  \\n'),('en','phplist Spam blocked','phplist Spam blocked'),('en','Email is blacklisted, so request for confirmation has been sent.','Subscriber is blacklisted, so request for confirmation has been sent.'),('en','If user confirms subscription, they will be removed from the blacklist.','If subscriber confirms subscription, they will be removed from the blacklist.'),('en','Deleted','Deleted'),('en','subscribe pages','Subscribe pages'),('en','not active','not active'),('en','Add a new subscribe page','Add a new subscribe page'),('en','Resending confirmation request to','Resending confirmation request to'),('en','user found','subscriber found'),('en','no user found','no subscriber found'),('en','unable to find original email','unable to find original email address'),('en','Marking all subscribers confirmed','Marking all subscribers confirmed'),('en','Marking all subscribers on list %s confirmed','Marking all subscribers on list %s confirmed'),('en','subscribers apply','subscribers apply'),('en','Creating UniqID for all subscribers who do not have one','Creating UniqID for all subscribers who do not have one'),('en','Marking all subscribers to receive HTML','Marking all subscribers to receive HTML'),('en','Marking all subscribers to receive text','Marking all subscribers to receive text'),('en','Deleting subscribers who are not on any list','Deleting subscribers who are not on any list'),('en','Moving subscribers who are not on any list to','Moving subscribers who are not on any list to'),('en','Deleting subscribers with more than','Deleting subscribers with more than'),('en','Resending request for confirmation to subscribers who signed up after','Resending request for confirmation to subscribers who signed up after'),('en','and before','and before'),('en','Deleting unconfirmed subscribers who signed up after','Deleting unconfirmed subscribers who signed up after'),('en','Trying to merge duplicates','Trying to merge duplicates'),('en','Don\'t know how to','Don\'t know how to'),('en','Trying to fix subscribers with an invalid email','Trying to fix subscribers with an invalid email address'),('en','subscribers fixed','subscribers fixed'),('en','subscribers could not be fixed','subscribers could not be fixed'),('en','Deleting subscribers with an invalid email','Deleting subscribers with an invalid email address'),('en','subscribers deleted','subscribers deleted'),('en','Marking subscribers with an invalid email as unconfirmed','Marking subscribers with an invalid email as unconfirmed'),('en','subscribers updated','subscribers updated'),('en','Cleaning some user tables of invalid entries','Cleaning some user tables of invalid entries'),('en','entries apply','entries apply'),('en','in the database','in the database'),('en','-All-','-All-'),('en','Mark all subscribers to receive HTML','Mark all subscribers to receive HTML'),('en','Mark all subscribers to receive text','Mark all subscribers to receive text'),('en','Mark all subscribers on list %s confirmed','Mark all subscribers on list %s confirmed'),('en','Click here','Click here'),('en','To move all subscribers who are not subscribed to any list to %s','To move all subscribers who are not subscribed to any list to %s'),('en','To delete all subscribers with more than','To delete all subscribers with more than'),('en','Note: this will use the total count of bounces on a subscriber, not consecutive bounces','Note: this will use the total count of bounces on a subscriber, not consecutive bounces'),('en','To delete subscribers who signed up and have not confirmed their subscription','To delete subscribers who signed up and have not confirmed their subscription'),('en','Date they signed up after','Date they signed up after'),('en','Date they signed up before','Date they signed up before'),('en','You cannot create a new list because you have reached maximum number of lists.','You cannot create a new list because you have reached maximum number of lists.'),('en','Members of this list','Members of this list'),('en','New list added','New list added'),('en','List name','List name'),('en','Public list (listed on the frontend)','Public list (listed on the frontend)'),('en','Order for listing','Order for listing'),('en','Category','Category'),('en','choose category','Choose category'),('en','List Description','List Description'),('en','save','Save'),('en','Cancel','Cancel'),('en','Do not save, and go back to the lists','Do not save, and go back to the lists'),('en','No list categories have been defined','No list categories have been defined'),('en','Once you have set up a few categories, come back to this page to classify your lists with your categories.','Once you have set up a few categories, come back to this page to classify your lists with your categories.'),('en','Configure Categories','Configure categories'),('en','Categories saved','Categories saved'),('en','All lists have already been assigned a category','All lists have already been assigned a category'),('en','Loading','Loading'),('en','return to editing attributes','return to editing attributes'),('en','N/A','N/A'),('en','links','links'),('en','user clicks','user clicks'),('en','clickrate','click rate'),('en','total clicks','total clicks'),('en','Click Details for a Message','Click details for a campaign'),('en','Sent to','Sent to'),('en','Message Click Statistics','Campaign click statistics'),('en','import_by','imported by'),('en','Imported','Imported'),('en','%d lines processed','%d lines processed'),('en','%d email imported','%d email imported'),('en','%d duplicates','%d duplicates'),('en','%d invalidated','%d invalidated'),('en','%d addresses were blacklisted and have not been subscribed to the list','%d addresses were blacklisted and have not been subscribed to the list'),('en','Adding subscribers','Adding subscribers'),('en','Please enter the emails to import, one per line, in the box below and click \\\"Import Emails\\\"','Please enter the email addresses to import, one per line, in the box below and click \\\"Import Emails\\\"'),('en','Check to skip emails that are not valid','Check to skip email addresses that are not valid'),('en','Import emails','Import emails'),('en','Invalid value for email address','Invalid value for email address'),('en','error','Error'),('en','fatalerror','Fatal error'),('en','Documentation about this error','Documentation about this error'),('en','Main Page','Dashboard'),('en','about','about'),('en','In this section','In this section'),('en','Recently visited','Recently Visited'),('en','All Lists','All Lists'),('en','All Active Lists','All Active Lists'),('en','Public list','Public list'),('en','Private list','Private list'),('en','There are no lists available','There are no lists available'),('en','years','years'),('en','days','days'),('en','hours','hours'),('en','mins','minutes'),('en','secs','seconds'),('en','Placeholder','Placeholder'),('en','Listing %d to %d of %d','Listing %d to %d of %d'),('en','Listing %d to %d','Listing %d to %d'),('en','First Page','First Page'),('en','Last Page','Last Page'),('en','All draft campaigns deleted','All draft campaigns deleted'),('en','campaigns deleted','campaigns deleted'),('en','Campaign deleted','Campaign deleted'),('en','start a new message','start a new campaign'),('en','Choose an existing draft message to work on','Choose an existing draft campaign to work on'),('en','Draft messages','Draft campaigns'),('en','age','age'),('en','Please select the lists you want to send your campaign to','Please select the lists you want to send your campaign to'),('en','Please select the lists you want to exclude from this campaign','Please select the lists you want to exclude from this campaign'),('en','The campaign will go to users who are a member of the lists above,     unless they are a member of one of the lists you select here.','The campaign will go to subscribers who are a member of the lists above, unless they are also a member of one of the lists you select here.'),('en','test processing error','test processing error'),('en','test Processing info','test processing info'),('en','mails in mailbox','mails in mailbox'),('en','tests','tests'),('en','test_protocol not supported','test_protocol not supported'),('en','User Click Statistics','Subscriber click statistics'),('en','User Click Details for a URL in a message','Subscriber click details for a URL in a message'),('en','User Click Details for a Message','Subscriber click details for a message'),('en','User Click Details for a URL','Subscriber click details for a URL'),('en','User Click Details','Subscriber click details'),('en','view user','view subscriber'),('en','No such attribute:','No such attribute'),('en','This datatype does not have editable values','This datatype does not have editable values'),('en','Back to attributes','Back to attributes'),('en','Add new','Add new'),('en','Are you sure you want to delete all values?','Are you sure you want to delete all values?'),('en','Alternatively you can replace all values with another one:','Alternatively you can replace all values with another one:'),('en','Replace with','Replace with'),('en','Delete and replace','Delete and replace'),('en','Cannot delete','Cannot delete'),('en','The following subscriber(s) are dependent on this value<br />Update the subscriber profiles to not use this attribute value and try again','The following subscriber(s) are dependent on this value<br />Update the subscriber profiles to not use this attribute value and try again'),('en','* Too many to list, total dependencies:','* Too many to list, total dependencies:'),('en','* Too many errors, quitting','* Too many errors, quitting'),('en','one per line','one per line'),('en','Change order','Change order'),('en','No template have been defined','No template have been defined'),('en','Existing templates','Existing templates'),('en','Campaign Default','Campaign default'),('en','System','System'),('en','Add new Template','Add new template'),('en','Add default system template','Add default system template'),('en','No such template','No such template'),('en','Images stored','Images stored'),('en','No images found','No images found'),('en','Template saved and ready for use in campaigns','Template saved and ready for use in campaigns'),('en','Image','Image'),('en','\\\"not full URL','not full URL'),('en','does not exist','does not exist'),('en','Not a full URL','Not a full URL'),('en','No Title','No title'),('en','Template does not contain the [CONTENT] placeholder','Template does not contain the [CONTENT] placeholder'),('en','Template saved','Template saved'),('en','Images','Images'),('en','Below is the list of images used in your template. If an image is currently unavailable, please upload it to the database.','Below is the list of images used in your template. If an image is currently unavailable, please upload it to the database.'),('en','This includes all images, also fully referenced ones, so you may choose not to upload some. If you upload images, they will be included in the campaigns that use this template.','This includes all images, also fully referenced ones, so you may choose not to upload some. If you upload images, they will be included in the campaigns that use this template.'),('en','Image name:','Image name'),('en','%d times used','%d times used'),('en','Save Images','Save images'),('en','Template does not contain local images','Template does not contain local images'),('en','Some errors were found, template NOT saved!','Some errors were found, template NOT saved!'),('en','Sending test','Sending test'),('en','Sending test \\\"Request for confirmation\\\" to','Sending test \\\"Request for confirmation\\\" to'),('en','Sending test \\\"Welcome\\\" to','Sending test \\\"Welcome\\\" to'),('en','Sending test \\\"Unsubscribe confirmation\\\" to','Sending test \\\"Unsubscribe confirmation\\\" to'),('en','Error sending test messages to','Error sending test messages to'),('en','List of Templates','List of templates'),('en','Title of this template','Title of this template'),('en','Content of the template.','Content of the template.'),('en','The content should at least have <b>[CONTENT]</b> somewhere.','The content should at least have <b>[CONTENT]</b> somewhere.'),('en','You can upload a template file or paste the text in the box below','You can upload a template file or paste the text in the box below'),('en','Template file.','Template file.'),('en','Check that all links have a full URL','Check that all links have a full URL'),('en','Check that all images have a full URL','Check that all images have a full URL'),('en','Check that all external images exist','Check that all external images exist'),('en','Send test message','Send test message'),('en','to email addresses','to email addresses'),('en','You are logged in as administrator (%s) of this phpList system','You are logged in as administrator (%s) of this phpList system'),('en','You are therefore offered the following choice, which your subscribers will not see when they load this page.','You are therefore offered the following choice, which your subscribers will not see when they load this page.'),('en','Go back to admin area','Go back to admin area'),('en','Please choose','Please choose'),('en','Make this subscriber confirmed immediately','Make this subscriber confirmed immediately'),('en','Send this subscriber a request for confirmation email','Send this subscriber a request for confirmation email'),('en','Subscriber removed from Blacklist for manual confirmation of subscription','Subscriber removed from do-not-send list for manual confirmation of subscription'),('en','Subscriber has been removed from blacklist','Subscriber has been removed from do-not-send list'),('en','Forwarded receiver requested blacklist','Forwarded receiver requested blacklist'),('en','\\\"Jump off\\\" used by subscriber, reason not requested','\\\"Jump off\\\" used by subscriber, reason not requested'),('en','\\\"Jump off\\\" set, reason not requested','\\\"Jump off\\\" set, reason not requested'),('en','When testing the phpList forward functionality, you need to be logged in as an administrator.','When testing the phpList forward functionality, you need to be logged in as an administrator.'),('en','Message Forwarded','Message forwarded'),('en','%s has forwarded message %d to %s','%s has forwarded message %d to %s'),('en','%s tried forwarding message %d to %s but failed','%s tried forwarding message %d to %s but failed'),('en','Forward request from invalid user ID: %s','Forward request from invalid user ID: %s');
/*!40000 ALTER TABLE `phplist_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_linktrack`
--

DROP TABLE IF EXISTS `phplist_linktrack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_linktrack` (
  `linkid` int(11) NOT NULL AUTO_INCREMENT,
  `messageid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `forward` text,
  `firstclick` datetime DEFAULT NULL,
  `latestclick` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `clicked` int(11) DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `miduidurlindex` (`messageid`,`userid`,`url`),
  KEY `midindex` (`messageid`),
  KEY `uidindex` (`userid`),
  KEY `urlindex` (`url`),
  KEY `miduidindex` (`messageid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_linktrack`
--

LOCK TABLES `phplist_linktrack` WRITE;
/*!40000 ALTER TABLE `phplist_linktrack` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_linktrack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_linktrack_forward`
--

DROP TABLE IF EXISTS `phplist_linktrack_forward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_linktrack_forward` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `personalise` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `urlunique` (`url`),
  KEY `urlindex` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_linktrack_forward`
--

LOCK TABLES `phplist_linktrack_forward` WRITE;
/*!40000 ALTER TABLE `phplist_linktrack_forward` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_linktrack_forward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_linktrack_ml`
--

DROP TABLE IF EXISTS `phplist_linktrack_ml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_linktrack_ml` (
  `messageid` int(11) NOT NULL,
  `forwardid` int(11) NOT NULL,
  `firstclick` datetime DEFAULT NULL,
  `latestclick` datetime DEFAULT NULL,
  `total` int(11) DEFAULT '0',
  `clicked` int(11) DEFAULT '0',
  `htmlclicked` int(11) DEFAULT '0',
  `textclicked` int(11) DEFAULT '0',
  PRIMARY KEY (`messageid`,`forwardid`),
  KEY `midindex` (`messageid`),
  KEY `fwdindex` (`forwardid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_linktrack_ml`
--

LOCK TABLES `phplist_linktrack_ml` WRITE;
/*!40000 ALTER TABLE `phplist_linktrack_ml` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_linktrack_ml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_linktrack_uml_click`
--

DROP TABLE IF EXISTS `phplist_linktrack_uml_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_linktrack_uml_click` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `messageid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `forwardid` int(11) DEFAULT NULL,
  `firstclick` datetime DEFAULT NULL,
  `latestclick` datetime DEFAULT NULL,
  `clicked` int(11) DEFAULT '0',
  `htmlclicked` int(11) DEFAULT '0',
  `textclicked` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `miduidfwdid` (`messageid`,`userid`,`forwardid`),
  KEY `midindex` (`messageid`),
  KEY `uidindex` (`userid`),
  KEY `miduidindex` (`messageid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_linktrack_uml_click`
--

LOCK TABLES `phplist_linktrack_uml_click` WRITE;
/*!40000 ALTER TABLE `phplist_linktrack_uml_click` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_linktrack_uml_click` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_linktrack_userclick`
--

DROP TABLE IF EXISTS `phplist_linktrack_userclick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_linktrack_userclick` (
  `linkid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `messageid` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `data` text,
  `date` datetime DEFAULT NULL,
  KEY `linkindex` (`linkid`),
  KEY `uidindex` (`userid`),
  KEY `midindex` (`messageid`),
  KEY `linkuserindex` (`linkid`,`userid`),
  KEY `linkusermessageindex` (`linkid`,`userid`,`messageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_linktrack_userclick`
--

LOCK TABLES `phplist_linktrack_userclick` WRITE;
/*!40000 ALTER TABLE `phplist_linktrack_userclick` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_linktrack_userclick` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_list`
--

DROP TABLE IF EXISTS `phplist_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `entered` datetime DEFAULT NULL,
  `listorder` int(11) DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `rssfeed` varchar(255) DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(4) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `nameidx` (`name`),
  KEY `listorderidx` (`listorder`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_list`
--

LOCK TABLES `phplist_list` WRITE;
/*!40000 ALTER TABLE `phplist_list` DISABLE KEYS */;
INSERT INTO `phplist_list` VALUES (1,'test','List for testing.','2015-03-12 06:21:59',NULL,NULL,NULL,'2015-03-12 10:21:59',0,1,''),(2,'newsletter','Sign up to our newsletter','2015-03-12 06:21:59',NULL,NULL,NULL,'2015-03-12 10:21:59',1,1,'');
/*!40000 ALTER TABLE `phplist_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_listmessage`
--

DROP TABLE IF EXISTS `phplist_listmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_listmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `messageid` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `entered` datetime DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `messageid` (`messageid`,`listid`),
  KEY `listmessageidx` (`listid`,`messageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_listmessage`
--

LOCK TABLES `phplist_listmessage` WRITE;
/*!40000 ALTER TABLE `phplist_listmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_listmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_listuser`
--

DROP TABLE IF EXISTS `phplist_listuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_listuser` (
  `userid` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `entered` datetime DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`,`listid`),
  KEY `userenteredidx` (`userid`,`entered`),
  KEY `userlistenteredidx` (`userid`,`listid`,`entered`),
  KEY `useridx` (`userid`),
  KEY `listidx` (`listid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_listuser`
--

LOCK TABLES `phplist_listuser` WRITE;
/*!40000 ALTER TABLE `phplist_listuser` DISABLE KEYS */;
INSERT INTO `phplist_listuser` VALUES (1,1,'2015-03-12 06:21:59','2015-03-12 10:21:59'),(1,2,'2015-03-12 06:21:59','2015-03-12 10:21:59');
/*!40000 ALTER TABLE `phplist_listuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_message`
--

DROP TABLE IF EXISTS `phplist_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL DEFAULT '(no subject)',
  `fromfield` varchar(255) NOT NULL DEFAULT '',
  `tofield` varchar(255) NOT NULL DEFAULT '',
  `replyto` varchar(255) NOT NULL DEFAULT '',
  `message` longtext,
  `textmessage` longtext,
  `footer` text,
  `entered` datetime DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `embargo` datetime DEFAULT NULL,
  `repeatinterval` int(11) DEFAULT '0',
  `repeatuntil` datetime DEFAULT NULL,
  `requeueinterval` int(11) DEFAULT '0',
  `requeueuntil` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `userselection` text,
  `sent` datetime DEFAULT NULL,
  `htmlformatted` tinyint(4) DEFAULT '0',
  `sendformat` varchar(20) DEFAULT NULL,
  `template` int(11) DEFAULT NULL,
  `processed` mediumint(8) unsigned DEFAULT '0',
  `astext` int(11) DEFAULT '0',
  `ashtml` int(11) DEFAULT '0',
  `astextandhtml` int(11) DEFAULT '0',
  `aspdf` int(11) DEFAULT '0',
  `astextandpdf` int(11) DEFAULT '0',
  `viewed` int(11) DEFAULT '0',
  `bouncecount` int(11) DEFAULT '0',
  `sendstart` datetime DEFAULT NULL,
  `rsstemplate` varchar(100) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_message`
--

LOCK TABLES `phplist_message` WRITE;
/*!40000 ALTER TABLE `phplist_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_message_attachment`
--

DROP TABLE IF EXISTS `phplist_message_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_message_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `messageid` int(11) NOT NULL,
  `attachmentid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `messageidx` (`messageid`),
  KEY `messageattidx` (`messageid`,`attachmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_message_attachment`
--

LOCK TABLES `phplist_message_attachment` WRITE;
/*!40000 ALTER TABLE `phplist_message_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_message_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_messagedata`
--

DROP TABLE IF EXISTS `phplist_messagedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_messagedata` (
  `name` varchar(100) NOT NULL,
  `id` int(11) NOT NULL,
  `data` longtext,
  PRIMARY KEY (`name`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_messagedata`
--

LOCK TABLES `phplist_messagedata` WRITE;
/*!40000 ALTER TABLE `phplist_messagedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_messagedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_sendprocess`
--

DROP TABLE IF EXISTS `phplist_sendprocess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_sendprocess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `started` datetime DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `alive` int(11) DEFAULT '1',
  `ipaddress` varchar(50) DEFAULT NULL,
  `page` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_sendprocess`
--

LOCK TABLES `phplist_sendprocess` WRITE;
/*!40000 ALTER TABLE `phplist_sendprocess` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_sendprocess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_subscribepage`
--

DROP TABLE IF EXISTS `phplist_subscribepage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_subscribepage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `active` tinyint(4) DEFAULT '0',
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_subscribepage`
--

LOCK TABLES `phplist_subscribepage` WRITE;
/*!40000 ALTER TABLE `phplist_subscribepage` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_subscribepage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_subscribepage_data`
--

DROP TABLE IF EXISTS `phplist_subscribepage_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_subscribepage_data` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data` text,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_subscribepage_data`
--

LOCK TABLES `phplist_subscribepage_data` WRITE;
/*!40000 ALTER TABLE `phplist_subscribepage_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_subscribepage_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_template`
--

DROP TABLE IF EXISTS `phplist_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `template` longblob,
  `listorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_template`
--

LOCK TABLES `phplist_template` WRITE;
/*!40000 ALTER TABLE `phplist_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_templateimage`
--

DROP TABLE IF EXISTS `phplist_templateimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_templateimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` int(11) NOT NULL DEFAULT '0',
  `mimetype` varchar(100) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `data` longblob,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `templateidx` (`template`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_templateimage`
--

LOCK TABLES `phplist_templateimage` WRITE;
/*!40000 ALTER TABLE `phplist_templateimage` DISABLE KEYS */;
INSERT INTO `phplist_templateimage` VALUES (1,0,'image/png','powerphplist.png','iVBORw0KGgoAAAANSUhEUgAAAEsAAAAhCAYAAACRIVbWAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAAB50RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNS4xqx9I6wAADmhJREFUaIHtmntw1FWWxz+/Xz/T6aQTQgIkJgR5LGRIFDcPsSAEWEFkZSIisPIcRaTKEkEMwUGXRRaZWlSylKPrqBDFGCXyUAqiKLUg6ADBhCRAEGQhWU1IIpru9Lt/j/2jkx/ppEOwZmoetX6rurrv45x77/fec+65t69AN4zOyMgDFgP5gK17+f8D2IG9QPGZmprDqqpqBULnj9EZGTFAMfDrv3Tv/obxEbC4trq6DTrI6iDqMHDbX69ff7OoBvJqq6vbxI6MYn4hqjfcRpAfhA4f9d9/zd78nWCiHljRW+nwzPGk507T0g11VZwqLwPAZLEybtbD2PoPxP7DVY59uA2f20lK2hgSBg/jVHkZtviBZE6bzaF3tgIwfdlv2f9fL/TQC3BoR7DO5AXLtbyuem9WpvaLci6eOtpjLLb4gSH1ju3aTkv9xaD8wuVaO+m50/C6neF0rBCBvN7IssUHiTj1SRmnPiljRJcOT1/2WwBOfVIWkva6nKTn3gtcJ9tksZKSNgZb/MCwek99Uoa99Sq2+EGYI61aHsC4WQ/ftEztF+VkTXuQ4Znjw4wltF5nfwFs/QeSPmGatgB8bmc4OvL09BEe2FubaDhXFfydOw1TpBVb/EBs8YPY/XKwwYZzVfxm03Zs8QNpqb+IuaNOyqgxAIzIHE9U3ACunKlEkiQURUFVFGRZBqD+bCUAsizjcbbzPzUVAPRPvpUBqSN+lozBbCF55G3UHQ/1LLIso6rBb0WWMVmsSJIEwJGdb/BgwX9gNEdy9fIFTZderw/hOyQVDuMeeJhxDzyskVJ7pJwBqcOxtzb1INUWPwh761UazlUxPHM8KWljOLZrGylpY4juP5CT+9/X6g/+1R3Y4geFDLwz/+nizzSdH/9+Q58y3fvxD1m5Ycts8YPIvncOAD53O+ZIK16Xk+YrF7lQcYTs6XN4o2Bhr1z0SdaxXds0P9UJr8uJOdIaktfZMEBz/UWyps2mpf4iDedOkzVtNiaLlfpz1wdYfXg/J/d/0KO9+rOVHCwuYsG/vUr14f00X7nYp0xIPyxWvOHNiOYrFyjbXAhA7oNLyMibrun7puKLjsluCisLIIbNVRRt6Ssdv7t+Gi/VYbJYSRs3FUmSSBs3FZPFSuOlOiRJ4nLtKUwWK+dPHqHxUh1eVzvNVy5qZPYFe2sTnxVvIffBJQxIHX5TMhCcsBHZE3pddV1hSxh003o70efK6g0f/34DMx5/jimLV/Qwl+YrF7G3NlF/thK9KFJ75ECwMTE4N6IgMG7WI+Q+uEST2V64mIDHhd/tRC+KXPr6GMc+fIs7p89l/2sbbyjT1XRPHdjJuS/KtbY60b1ew7kqznap17Xt3iCMzshQe+QqCpKi/CzyekM3J/l3jfAjEQSNYUEQkCQZj8eNXq8nOjqayMhIVFXF7XZjt9uRZRmLxYJOp6PrwfPPRfifikAggCAIf/LE9SIdHLAgCnjcHvz+AP+YeQdT7p7CqFGjSEhIQFVVWltbqamp4dChQ5w+fRqj0YjZbA4hDIA+SFMUBa/XS4TZjHADM7gRZFnG5/NhiYgAQQjJH5SQgM/vp62tDZ1O16sOt9uN0WjEYDAEGeiiB3oxQ0FVAAG3243BYGDZsmXMnTuXAQMGhG2ksbGR0tJS3nzzTRRFwWQyoaoqkqIEZ/MGZCmKgsViITMzk4qKCrxeL0K3TvYFRVGIjY0lLS2NEydOIMsygiAQCARISUlh586dtLS0MG/ePFwuV1jCVFVl7NixXLlyhe+//x6dXt+DrLDTqKgqfr8fm83GunXrePLJJ0OI8ng8vPLKKzz11FPU1dWRmJjIqlWreOaZZ1BVVVv2NwO/38+wYcN47bXXGDp0KD6f7+fwBIDX62Xs2LG8/vrrxMbGasGmqqrodDrMZjNms7nXPsmyTEREBC+99BL33HMPbrc7bL2wZujz+VBkBZPZRHZ2dkhZIBDgzbfe4tzZs9xySzKbfvc7Nmx4nsEpg5k/fz6XL1/hjTf/QGxMLBD0eV6fD6VjdXVG4IIgYDQaARA7TE+SJJxOJ5IkIQgCJpMJg8GALMt4vV5EUeyIxIPG0ElEpz5ZlkP8ktFopL6+nqlTpxIIBHC5XEiShMfj0eqIooher8fn8xEIBPB6vTidTqxRUT3IDUuWJEnceuutTJo4ibVr17Ju3TpGjhwJgMvlorLya+bOnsM/3X03CxYspKG+nsEpgxFFkYce+hcOHTrEd9//LyZzBH6/n7vuuouYmBgCgQD3338/UVFRVFdXU1payrfffhs0WUkiJyeHefPmkZSUREVFBSUlJbS2ttK/f39mzZrFhQsXmDx5Munp6TgcDvbs2cPnn38ePAqpqvbpCkVRmDFjBk1NTZSVlZGZmcns2bNJTU3l2rVrfPbZZxw/fpw1a9Zgs9mYP38+aWlp/PvGjfgDgRBdYc1QJ+rIysxi7dq1jL1rLAUFBZw/fx6AqKgoxt45lk8Pfsrb77zNwIEDGDp0mCY7ZMgQcsePx+/zB1ei309+fj5FRUUUFRXh9Xqprq5m4sSJfPDBB4waNQqPx4MgCKxevZr4+Hhqamq47777eP/990lISCA+Pp7169dTWlpKXl4eNTU1eDwetm7dypo1awh0G1QnOonLz88nJyeHkSNHsn37dpKSkqisrESWZZ5//nlycnI0nc3NzZw/f16zhD5XFoJAeno6AMufWI4syRQWFrJ582ZGjBjB0qWPMmPGr9lW/DZfHj1KYmLidYV6PWlpaRhNJk1Xpw8pKCjgww8/RBAEtm7dSklJCc899xxbtmxBp9Oxbds21q9fjyRJvPrqq+zdu5fly5dTXFwMwIkTJ3jkkUdoa2tDVVXmzJnDyy+/zL59+/B6vWGHAkEf297eTnZ2NhEREaxYsYILFy5gtVoZNmwYLpcLh8PB4sWLOXjwIFu2bGFQYmKPnTn8Pq2qxMXFacmVK1eSl5dHYWEhly5dYs+evcTFxTHvoYd45513sNvtIeK2WBtGg0FLG41GGhoa+PTTT4mOjiYmJob29naKi4u5/fbbSU5ORpIkDh48iF6vp1+/fly7do0DBw5wxx13aH7pvffew+l0EhsbS0xMDAcOHOC7775j0qRJmi/sDUajkZMnT+Lz+di5cyebNm1i4sSJNDc3Y7fbiY6ORhRFzGYzUWH8Va9kyYqCrIQ2vnLlSqb/83SWPraU3Xt2s3btWl568UX8AT+rV6/G5XJpdRVZQeW67xBFkZ9++glJkjRnbjAY+PHHHxEEAavVqm33neV6vV5z9IIgoCgKbW1tmgPvdOjXrl2jX79+NyQKwGQyUVtby6JFi6ipqWHmzJmUlJSwY8cOEhMT8fv9feoIS5bRaKChvqFHflJiEs3NzbQ72omNjcVsNrPh+Q1YrVaeLnha2/abmq/i811vXJZlEhMTsVgsmn/xer0MHz4cv99Pa2srer2+x2wKgqD5HVEUSU1N1cwtEAgQGRlJamoqly9f7nOgnTpOnjzJihUrmDp1KgsWLCA9PZ2FCxdqZPUIqPsiy2QyceLEiZC8uro6it9+m9LS98nLy2Pjxo2oqorVamXjxo1YIiyseWYNDoeDs2fOIklBUgSCoUh8fDyrVq3CaDTidDrJysriiSeeYN++fTQ3N6PT6cKS1UmYLMs8/vjjZGdn43Q6MRgMFBQUEBERQXl5OaYOH+nz+fB6vfh8Pi0cEAQBn8/HvHnzKCwsJDo6GrvdTlVVFQ6HQzu+GQwGRFHE6/WGJa2X445AZWUlx48f58477wSCUTqqyoCEBIaPGE5VVRV+vx+TyYTZbOaFF15g06ZNLF36GN83fkdkx32XSjAeamtr495772XKlCk4HA6SkpL46quv2Lx5M2lpaQAhfkdVVQRBwGAwQEeQ7PV62bFjB42NjVitVgwGAytXruTy5ctkZWVhMBgoKSnB7/drxO/atUtLe71eFi1axMyZM3E4HMTExOByuXj33Xfx+XwcPXqUpUuXkpmZyaqnn8bXzTSF0RkZbXS7WhZQcTpdZGdl8oc33iA6Khq3282zzz5Lyw+tSIEAc+fMJT8/P0RZa2sr+fn5NDY1ER0djT8QwO/3859btpCcnMzSRx8ld8IEoqxWvvnmGyoqKpAVhZiYGLKzszl+/DgejwexYwdNHTKEuLg4PB4Pu3fvZsmSJTgcDtLT03E6nXx57BiNTU2YTCZibDZyJ0wgMjIyZIWePXMGCO6I1TU1DE5JITMri9jYWFpaWvjjV3+kzR70hWazmcmTJ2PQ6zlQXg6hu6FdGJ2RsZdu/0ILqMiqgqPNzv33z2Tdv64jLq4fHo+H/Qf2k3xLMjk5OSFE/fDDD2x+8UX27fsYnU6PIEBAkvH7/WwtKmLw4MEs+s1iTOYIVEVBbzBgMpkQRQFFVvB4PERYIhAFsbMTBAIS9rY2hgwZwq6yMh5btoyvq6ow6PUIooDJZMag14MQXJVutxu6WY/RaERVVURRxGgyEggE8Pv8KIqCqBMxmczodboOHQoetxsEgcjISK42hdyafqQHirqTBQI6UUd0VDS7d++mtaWVJUseYfLkycx6YFZITVmWOXzkCNu3b+PYsS+DMysK0GHzqqqi1+vR6XToDUYyszK1sj4hCJw+Xa0lVYJBcTAGVK9n/rxz902jG1lFnX/fh6wuQSA4IEFEUSTaHU5stmgybruN9F+N5pbkZFRVpamxkZqaGmrPnsHe1kZkpBVRJ3aQIRCQJFRVJXPMGMwREXxx9GjwxH+ztwoqqKpCtM3GpEmTOHz4MD/9+CPiDa5Z/pzocs78qLa6Oj/sWwdR0PraQVxwl5EkCQQw6A0gCMiShKIqGPQG7VDcFf6AhMFgwOvxBK9iOnadnwtFUXB7PFgiIrQ47C8I7a3DL69oboyer2i64pf3Wb2/z/o/Z4jQ19LLyeMAAAAASUVORK5CYII=',70,30);
/*!40000 ALTER TABLE `phplist_templateimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_urlcache`
--

DROP TABLE IF EXISTS `phplist_urlcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_urlcache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `lastmodified` int(11) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `content` mediumtext,
  PRIMARY KEY (`id`),
  KEY `urlindex` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_urlcache`
--

LOCK TABLES `phplist_urlcache` WRITE;
/*!40000 ALTER TABLE `phplist_urlcache` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_urlcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_attribute`
--

DROP TABLE IF EXISTS `phplist_user_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(30) DEFAULT NULL,
  `listorder` int(11) DEFAULT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  `required` tinyint(4) DEFAULT NULL,
  `tablename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nameindex` (`name`),
  KEY `idnameindex` (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_attribute`
--

LOCK TABLES `phplist_user_attribute` WRITE;
/*!40000 ALTER TABLE `phplist_user_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_blacklist`
--

DROP TABLE IF EXISTS `phplist_user_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_blacklist` (
  `email` varchar(255) NOT NULL,
  `added` datetime DEFAULT NULL,
  UNIQUE KEY `email` (`email`),
  KEY `emailidx` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_blacklist`
--

LOCK TABLES `phplist_user_blacklist` WRITE;
/*!40000 ALTER TABLE `phplist_user_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_blacklist_data`
--

DROP TABLE IF EXISTS `phplist_user_blacklist_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_blacklist_data` (
  `email` varchar(150) NOT NULL,
  `name` varchar(25) NOT NULL,
  `data` text,
  UNIQUE KEY `email` (`email`),
  KEY `emailidx` (`email`),
  KEY `emailnameidx` (`email`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_blacklist_data`
--

LOCK TABLES `phplist_user_blacklist_data` WRITE;
/*!40000 ALTER TABLE `phplist_user_blacklist_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_blacklist_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_message_bounce`
--

DROP TABLE IF EXISTS `phplist_user_message_bounce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_message_bounce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `message` int(11) NOT NULL,
  `bounce` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `umbindex` (`user`,`message`,`bounce`),
  KEY `useridx` (`user`),
  KEY `msgidx` (`message`),
  KEY `bounceidx` (`bounce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_message_bounce`
--

LOCK TABLES `phplist_user_message_bounce` WRITE;
/*!40000 ALTER TABLE `phplist_user_message_bounce` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_message_bounce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_message_forward`
--

DROP TABLE IF EXISTS `phplist_user_message_forward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_message_forward` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `message` int(11) NOT NULL,
  `forward` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usermessageidx` (`user`,`message`),
  KEY `useridx` (`user`),
  KEY `messageidx` (`message`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_message_forward`
--

LOCK TABLES `phplist_user_message_forward` WRITE;
/*!40000 ALTER TABLE `phplist_user_message_forward` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_message_forward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_user`
--

DROP TABLE IF EXISTS `phplist_user_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `confirmed` tinyint(4) DEFAULT '0',
  `blacklisted` tinyint(4) DEFAULT '0',
  `optedin` tinyint(4) DEFAULT '0',
  `bouncecount` int(11) DEFAULT '0',
  `entered` datetime DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uniqid` varchar(255) DEFAULT NULL,
  `htmlemail` tinyint(4) DEFAULT '0',
  `subscribepage` int(11) DEFAULT NULL,
  `rssfrequency` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `passwordchanged` date DEFAULT NULL,
  `disabled` tinyint(4) DEFAULT '0',
  `extradata` text,
  `foreignkey` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `foreignkey` (`foreignkey`),
  KEY `idxuniqid` (`uniqid`),
  KEY `enteredindex` (`entered`),
  KEY `confidx` (`confirmed`),
  KEY `blidx` (`blacklisted`),
  KEY `optidx` (`optedin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_user`
--

LOCK TABLES `phplist_user_user` WRITE;
/*!40000 ALTER TABLE `phplist_user_user` DISABLE KEYS */;
INSERT INTO `phplist_user_user` VALUES (1,'jonathan@kyuss.org',1,0,0,0,'2015-03-12 06:21:59','2015-03-12 10:21:59','474763a61b0d54316fa95f84f965a153',1,NULL,NULL,'0192023a7bbd73250516f069df18b500','2015-03-12',0,NULL,NULL);
/*!40000 ALTER TABLE `phplist_user_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_user_attribute`
--

DROP TABLE IF EXISTS `phplist_user_user_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_user_attribute` (
  `attributeid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `value` text,
  PRIMARY KEY (`attributeid`,`userid`),
  KEY `userindex` (`userid`),
  KEY `attindex` (`attributeid`),
  KEY `attuserid` (`userid`,`attributeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_user_attribute`
--

LOCK TABLES `phplist_user_user_attribute` WRITE;
/*!40000 ALTER TABLE `phplist_user_user_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_user_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_user_user_history`
--

DROP TABLE IF EXISTS `phplist_user_user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_user_user_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `detail` text,
  `systeminfo` text,
  PRIMARY KEY (`id`),
  KEY `userididx` (`userid`),
  KEY `dateidx` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_user_user_history`
--

LOCK TABLES `phplist_user_user_history` WRITE;
/*!40000 ALTER TABLE `phplist_user_user_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_user_user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_usermessage`
--

DROP TABLE IF EXISTS `phplist_usermessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_usermessage` (
  `messageid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `entered` datetime NOT NULL,
  `viewed` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`,`messageid`),
  KEY `messageidindex` (`messageid`),
  KEY `useridindex` (`userid`),
  KEY `enteredindex` (`entered`),
  KEY `statusidx` (`status`),
  KEY `viewedidx` (`viewed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_usermessage`
--

LOCK TABLES `phplist_usermessage` WRITE;
/*!40000 ALTER TABLE `phplist_usermessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_usermessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phplist_userstats`
--

DROP TABLE IF EXISTS `phplist_userstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phplist_userstats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unixdate` int(11) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `listid` int(11) DEFAULT '0',
  `value` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry` (`unixdate`,`item`,`listid`),
  KEY `dateindex` (`unixdate`),
  KEY `itemindex` (`item`),
  KEY `listindex` (`listid`),
  KEY `listdateindex` (`listid`,`unixdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phplist_userstats`
--

LOCK TABLES `phplist_userstats` WRITE;
/*!40000 ALTER TABLE `phplist_userstats` DISABLE KEYS */;
/*!40000 ALTER TABLE `phplist_userstats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-12  6:22:20
