# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Värd: 127.0.0.1 (MySQL 5.7.29)
# Databas: holidaymaker
# Genereringstid: 2020-02-23 22:24:16 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Tabelldump all_booked_hotel_rooms
# ------------------------------------------------------------

DROP VIEW IF EXISTS `all_booked_hotel_rooms`;

CREATE TABLE `all_booked_hotel_rooms` (
   `room_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `hotel_city` VARCHAR(45) NULL DEFAULT NULL,
   `hotel_name` VARCHAR(45) NULL DEFAULT NULL,
   `type` ENUM('single','double','suite') NULL DEFAULT 'single',
   `price` DOUBLE NULL DEFAULT NULL,
   `pool` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `restaurant` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `children_activities` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `entertainment` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `distance_to_beach` INT(11) NULL DEFAULT NULL,
   `distance_to_centre` INT(11) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Tabelldump all_rooms
# ------------------------------------------------------------

DROP VIEW IF EXISTS `all_rooms`;

CREATE TABLE `all_rooms` (
   `booking_id` INT(11) UNSIGNED NULL DEFAULT NULL,
   `room_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `check_in` DATE NULL DEFAULT NULL,
   `check_out` DATE NULL DEFAULT NULL,
   `hotel_city` VARCHAR(45) NULL DEFAULT NULL,
   `hotel_name` VARCHAR(45) NULL DEFAULT NULL,
   `type` ENUM('single','double','suite') NULL DEFAULT 'single',
   `price` DOUBLE NULL DEFAULT NULL,
   `pool` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `restaurant` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `children_activities` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `entertainment` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `distance_to_beach` INT(11) NULL DEFAULT NULL,
   `distance_to_centre` INT(11) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Tabelldump all_unbooked_hotel_rooms
# ------------------------------------------------------------

DROP VIEW IF EXISTS `all_unbooked_hotel_rooms`;

CREATE TABLE `all_unbooked_hotel_rooms` (
   `booking_id` INT(11) UNSIGNED NULL DEFAULT NULL,
   `room_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `hotel_city` VARCHAR(45) NULL DEFAULT NULL,
   `hotel_name` VARCHAR(45) NULL DEFAULT NULL,
   `type` ENUM('single','double','suite') NULL DEFAULT 'single',
   `price` DOUBLE NULL DEFAULT NULL,
   `pool` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `restaurant` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `children_activities` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `entertainment` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0',
   `distance_to_beach` INT(11) NULL DEFAULT NULL,
   `distance_to_centre` INT(11) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Tabelldump bookings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bookings`;

CREATE TABLE `bookings` (
  `booking_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL,
  `number_of_guests` int(11) unsigned NOT NULL,
  `guest_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `guest_id` (`guest_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`guest_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;

INSERT INTO `bookings` (`booking_id`, `check_in`, `check_out`, `number_of_guests`, `guest_id`)
VALUES
	(1,'2020-06-04','2020-06-05',2,2),
	(2,'2020-06-23','2020-06-25',5,45),
	(3,'2020-07-02','2020-07-05',3,34),
	(4,'2020-06-28','2020-06-30',3,78),
	(5,'2020-06-01','2020-06-03',3,33),
	(6,'2020-07-15','2020-07-17',3,44),
	(7,'2020-07-09','2020-07-10',2,44),
	(8,'2020-07-09','2020-07-10',2,11),
	(9,'2020-06-02','2020-06-03',2,22),
	(10,'2020-06-02','2020-06-04',2,89),
	(11,'2020-06-05','2020-06-10',4,98),
	(12,'2020-07-19','2020-07-20',6,67),
	(13,'2020-07-24','2020-07-25',1,55),
	(14,'2020-06-04','2020-06-06',3,46),
	(15,'2020-06-01','2020-06-02',3,12),
	(16,'2020-06-28','2020-06-30',1,37),
	(17,'2020-06-28','2020-06-30',1,21),
	(18,'2020-07-10','2020-07-11',3,90),
	(19,'2020-06-19','2020-06-21',3,15),
	(20,'2020-07-08','2020-07-08',1,67),
	(21,'2020-07-12','2020-07-15',5,75),
	(22,'2020-06-04','2020-06-05',1,23);

/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump bookingsXrooms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bookingsXrooms`;

CREATE TABLE `bookingsXrooms` (
  `booking_id` int(11) unsigned DEFAULT NULL,
  `room_id` int(11) unsigned DEFAULT NULL,
  `meal` enum('none','half_board','full_board') DEFAULT 'none',
  `extra_bed` tinyint(2) unsigned DEFAULT '0',
  KEY `booking_id` (`booking_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `bookingsxrooms_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bookingsxrooms_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bookingsXrooms` WRITE;
/*!40000 ALTER TABLE `bookingsXrooms` DISABLE KEYS */;

INSERT INTO `bookingsXrooms` (`booking_id`, `room_id`, `meal`, `extra_bed`)
VALUES
	(1,12,'none',1),
	(2,5,'full_board',0),
	(3,7,'half_board',1),
	(4,7,'none',1),
	(5,7,'none',0),
	(5,8,'none',0),
	(6,8,'none',0),
	(6,7,'none',0),
	(6,7,'none',0),
	(7,12,'none',0),
	(9,12,'none',0),
	(10,20,'none',1),
	(11,34,'half_board',0),
	(12,40,'none',0),
	(12,37,'none',0),
	(12,38,'full_board',0),
	(13,31,'none',0),
	(15,11,'none',0),
	(15,32,'none',0),
	(15,33,'half_board',0),
	(16,39,'none',0),
	(17,6,'full_board',0),
	(18,29,'none',0),
	(19,36,'none',0),
	(20,16,'full_board',0),
	(21,10,'half_board',0),
	(21,9,'none',0),
	(22,26,'none',0),
	(22,27,'none',1),
	(22,28,'full_board',0),
	(22,1,'none',0),
	(22,2,'none',0);

/*!40000 ALTER TABLE `bookingsXrooms` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump facilities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `facilities`;

CREATE TABLE `facilities` (
  `facility_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pool` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `restaurant` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `children_activities` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `entertainment` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;

INSERT INTO `facilities` (`facility_id`, `pool`, `restaurant`, `children_activities`, `entertainment`)
VALUES
	(1,1,1,1,0),
	(2,0,1,0,1),
	(3,1,1,1,1),
	(4,0,0,0,0);

/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump guests
# ------------------------------------------------------------

DROP TABLE IF EXISTS `guests`;

CREATE TABLE `guests` (
  `guest_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `guest_first_name` varchar(255) DEFAULT NULL,
  `guest_last_name` varchar(255) DEFAULT NULL,
  `guest_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;

INSERT INTO `guests` (`guest_id`, `guest_first_name`, `guest_last_name`, `guest_email`)
VALUES
	(1,'Gabrila','Bermingham','gbermingham0@hao123.com'),
	(2,'Robbie','Otter','rotter1@aol.com'),
	(3,'Wilton','Pannett','wpannett2@tmall.com'),
	(4,'Hobard','Goodrich','hgoodrich3@sphinn.com'),
	(5,'Nichole','Curwen','ncurwen4@reuters.com'),
	(6,'Marc','Killen','mkillen5@yale.edu'),
	(7,'Wain','Fowlston','wfowlston6@weebly.com'),
	(8,'Emmye','Stubley','estubley7@flavors.me'),
	(9,'Justen','Pignon','jpignon8@gov.uk'),
	(10,'Bobette','Ratter','bratter9@umn.edu'),
	(11,'Brianne','Pickett','bpicketta@google.pl'),
	(12,'Jefferey','Bettenson','jbettensonb@godaddy.com'),
	(13,'Maryanna','Pandey','mpandeyc@google.com'),
	(14,'Camilla','Janaud','cjanaudd@cyberchimps.com'),
	(15,'Talya','Hourihan','thourihane@newsvine.com'),
	(16,'Prudence','Lemery','plemeryf@blogspot.com'),
	(17,'Valdemar','Cardenas','vcardenasg@google.com.br'),
	(18,'Virgie','Moughtin','vmoughtinh@seesaa.net'),
	(19,'Anthiathia','Gorey','agoreyi@opensource.org'),
	(20,'Tobiah','Ticic','tticicj@1und1.de'),
	(21,'Gardener','Wagner','gwagnerk@exblog.jp'),
	(22,'Wilhelmine','Sowray','wsowrayl@opensource.org'),
	(23,'Hildagard','Ducker','hduckerm@nbcnews.com'),
	(24,'Valerye','Stonhouse','vstonhousen@etsy.com'),
	(25,'Daile','Rimington','drimingtono@army.mil'),
	(26,'Vanna','Darkins','vdarkinsp@imageshack.us'),
	(27,'Kerrie','Jozefczak','kjozefczakq@printfriendly.com'),
	(28,'Merrill','Hedgeley','mhedgeleyr@bing.com'),
	(29,'Franny','Ahmad','fahmads@sfgate.com'),
	(30,'Jermain','Bernadot','jbernadott@google.ru'),
	(31,'Stacie','Sidworth','ssidworthu@cam.ac.uk'),
	(32,'Marshal','Crosier','mcrosierv@blog.com'),
	(33,'Arlen','Dundridge','adundridgew@artisteer.com'),
	(34,'Elayne','Caulfield','ecaulfieldx@blinklist.com'),
	(35,'Lettie','Beckitt','lbeckitty@bigcartel.com'),
	(36,'Tim','Dunsmuir','tdunsmuirz@house.gov'),
	(37,'Rog','Everton','reverton10@ning.com'),
	(38,'Marybeth','Jeffryes','mjeffryes11@meetup.com'),
	(39,'Wallace','Stalman','wstalman12@omniture.com'),
	(40,'Patric','Ballard','pballard13@sourceforge.net'),
	(41,'Alonso','Cullinane','acullinane14@imdb.com'),
	(42,'Winslow','Davidavidovics','wdavidavidovics15@mac.com'),
	(43,'Roy','Johnys','rjohnys16@upenn.edu'),
	(44,'Gail','Perot','gperot17@goo.ne.jp'),
	(45,'Olva','Ivett','oivett18@wordpress.com'),
	(46,'Cheryl','Broggetti','cbroggetti19@symantec.com'),
	(47,'Kori','Beades','kbeades1a@fotki.com'),
	(48,'Daphne','Pecht','dpecht1b@list-manage.com'),
	(49,'Aldous','Senyard','asenyard1c@time.com'),
	(50,'Mahalia','Newton','mnewton1d@drupal.org'),
	(51,'Chrisse','Dienes','cdienes1e@lulu.com'),
	(52,'Tome','Walkling','twalkling1f@shareasale.com'),
	(53,'Hadria','Gutierrez','hgutierrez1g@arizona.edu'),
	(54,'Ike','Airlie','iairlie1h@php.net'),
	(55,'Gail','Bittany','gbittany1i@cyberchimps.com'),
	(56,'Celia','Eary','ceary1j@statcounter.com'),
	(57,'Angy','Levison','alevison1k@webmd.com'),
	(58,'Leonie','Westwell','lwestwell1l@adobe.com'),
	(59,'Gae','Ainslie','gainslie1m@squarespace.com'),
	(60,'Esma','Ingon','eingon1n@sohu.com'),
	(61,'Jennica','Widdicombe','jwiddicombe1o@google.com'),
	(62,'Alexandr','Woollcott','awoollcott1p@ovh.net'),
	(63,'Glynda','Garlett','ggarlett1q@bloomberg.com'),
	(64,'Gradey','Bachman','gbachman1r@e-recht24.de'),
	(65,'Dolly','Bushel','dbushel1s@csmonitor.com'),
	(66,'Rasia','Scarsbrook','rscarsbrook1t@cnet.com'),
	(67,'Inna','Stuart','istuart1u@cnn.com'),
	(68,'Cleon','Avramovich','cavramovich1v@istockphoto.com'),
	(69,'Benedikta','Vaudrey','bvaudrey1w@youku.com'),
	(70,'Rolf','McArtan','rmcartan1x@fema.gov'),
	(71,'Leupold','Cowland','lcowland1y@intel.com'),
	(72,'Georgie','Reisenberg','greisenberg1z@flickr.com'),
	(73,'Giavani','Cullip','gcullip20@geocities.com'),
	(74,'Garvey','Frankcomb','gfrankcomb21@about.com'),
	(75,'Vern','Manning','vmanning22@icq.com'),
	(76,'Simone','Rankling','srankling23@census.gov'),
	(77,'Devy','Wardhaugh','dwardhaugh24@wp.com'),
	(78,'Trever','Digle','tdigle25@google.it'),
	(79,'Federica','Larkins','flarkins26@google.com.hk'),
	(80,'Chelsea','Giacomello','cgiacomello27@nsw.gov.au'),
	(81,'Mirna','Alexander','malexander28@nifty.com'),
	(82,'Ediva','Rantoul','erantoul29@addthis.com'),
	(83,'Rois','Sandell','rsandell2a@exblog.jp'),
	(84,'Joellyn','Lafont','jlafont2b@archive.org'),
	(85,'Wandis','Guillerman','wguillerman2c@hc360.com'),
	(86,'Albertina','Screeton','ascreeton2d@amazon.co.jp'),
	(87,'Jedediah','Madden','jmadden2e@ovh.net'),
	(88,'Jacklin','Coram','jcoram2f@hc360.com'),
	(89,'Germaine','Winch','gwinch2g@mozilla.com'),
	(90,'Ellynn','Strutz','estrutz2h@oakley.com'),
	(91,'Kenyon','Mordin','kmordin2i@usa.gov'),
	(92,'Corney','Cestard','ccestard2j@plala.or.jp'),
	(93,'Mareah','Probert','mprobert2k@miibeian.gov.cn'),
	(94,'Neila','Taylour','ntaylour2l@about.com'),
	(95,'Hilton','Osbourne','hosbourne2m@smh.com.au'),
	(96,'Betsey','Gravey','bgravey2n@hostgator.com'),
	(97,'Perren','Dady','pdady2o@goo.ne.jp'),
	(98,'Florina','Yarwood','fyarwood2p@patch.com'),
	(99,'Xerxes','Stiller','xstiller2q@jiathis.com'),
	(100,'Ricardo','Whales','rwhales2r@twitter.com');

/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump hotels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hotels`;

CREATE TABLE `hotels` (
  `hotel_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hotel_name` varchar(45) DEFAULT NULL,
  `hotel_city` varchar(45) DEFAULT NULL,
  `distance_to_centre` int(11) DEFAULT NULL,
  `distance_to_beach` int(11) DEFAULT NULL,
  `half_board_price` double DEFAULT NULL,
  `full_board_price` double DEFAULT NULL,
  `extra_bed_price` double DEFAULT NULL,
  `facility_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`hotel_id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`facility_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;

INSERT INTO `hotels` (`hotel_id`, `hotel_name`, `hotel_city`, `distance_to_centre`, `distance_to_beach`, `half_board_price`, `full_board_price`, `extra_bed_price`, `facility_id`)
VALUES
	(1,'Paganini','Nice',500,600,50,100,50,2),
	(2,'Renoir','Cannes',750,300,100,200,100,4),
	(3,'Le Quai','Marseille',200,75,150,250,150,3),
	(4,'Aragon','Montpellier',450,100,300,400,200,1),
	(5,'Odeon','Perpignan',1000,50,200,300,125,4),
	(6,'Boulevard','Nice',550,200,120,150,120,2),
	(7,'Figaro','Marseille',100,150,110,130,90,3),
	(8,'Pigalle','Antibes',300,250,250,350,200,4);

/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump latest_booking_id
# ------------------------------------------------------------

DROP VIEW IF EXISTS `latest_booking_id`;

CREATE TABLE `latest_booking_id` (
   `MAX(booking_id)` INT(11) UNSIGNED NULL DEFAULT NULL
) ENGINE=MyISAM;



# Tabelldump review
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `review_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rating` int(11) unsigned DEFAULT NULL,
  `hotel_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;

INSERT INTO `review` (`review_id`, `rating`, `hotel_id`)
VALUES
	(1,2,5);

/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump room_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `room_type`;

CREATE TABLE `room_type` (
  `room_type_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('single','double','suite') DEFAULT 'single',
  `price` double DEFAULT NULL,
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;

INSERT INTO `room_type` (`room_type_id`, `type`, `price`)
VALUES
	(1,'single',300),
	(2,'single',600),
	(3,'single',900),
	(4,'single',1200),
	(5,'double',400),
	(6,'double',800),
	(7,'double',1200),
	(8,'double',1600),
	(9,'suite',1500),
	(10,'suite',2000),
	(11,'single',2500),
	(12,'suite',3000);

/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;


# Tabelldump rooms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rooms`;

CREATE TABLE `rooms` (
  `room_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) unsigned NOT NULL,
  `room_type_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`room_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `room_type_id` (`room_type_id`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;

INSERT INTO `rooms` (`room_id`, `hotel_id`, `room_type_id`)
VALUES
	(1,1,3),
	(2,1,4),
	(3,1,7),
	(4,1,8),
	(5,1,10),
	(6,2,1),
	(7,2,5),
	(8,2,8),
	(9,2,9),
	(10,2,10),
	(11,3,7),
	(12,3,8),
	(13,3,10),
	(14,3,11),
	(15,3,12),
	(16,4,2),
	(17,4,3),
	(18,4,5),
	(19,4,7),
	(20,4,8),
	(21,5,2),
	(22,5,4),
	(23,5,7),
	(24,5,9),
	(25,5,11),
	(26,6,1),
	(27,6,2),
	(28,6,3),
	(29,6,5),
	(30,6,6),
	(31,7,4),
	(32,7,5),
	(33,7,7),
	(34,7,9),
	(35,7,11),
	(36,8,8),
	(37,8,9),
	(38,8,10),
	(39,8,11),
	(40,8,12);

/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;




# Replace placeholder table for latest_booking_id with correct view syntax
# ------------------------------------------------------------

DROP TABLE `latest_booking_id`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_booking_id`
AS SELECT
   max(`bookings`.`booking_id`) AS `MAX(booking_id)`
FROM `bookings`;


# Replace placeholder table for all_rooms with correct view syntax
# ------------------------------------------------------------

DROP TABLE `all_rooms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_rooms`
AS SELECT
   `bookingsxrooms`.`booking_id` AS `booking_id`,
   `rooms`.`room_id` AS `room_id`,
   `bookings`.`check_in` AS `check_in`,
   `bookings`.`check_out` AS `check_out`,
   `hotels`.`hotel_city` AS `hotel_city`,
   `hotels`.`hotel_name` AS `hotel_name`,
   `room_type`.`type` AS `type`,
   `room_type`.`price` AS `price`,
   `facilities`.`pool` AS `pool`,
   `facilities`.`restaurant` AS `restaurant`,
   `facilities`.`children_activities` AS `children_activities`,
   `facilities`.`entertainment` AS `entertainment`,
   `hotels`.`distance_to_beach` AS `distance_to_beach`,
   `hotels`.`distance_to_centre` AS `distance_to_centre`
FROM (((((`hotels` join `room_type`) join `facilities`) join `bookings`) join `bookingsxrooms`) join `rooms`);


# Replace placeholder table for all_unbooked_hotel_rooms with correct view syntax
# ------------------------------------------------------------

DROP TABLE `all_unbooked_hotel_rooms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_unbooked_hotel_rooms`
AS SELECT
   distinct `bookingsxrooms`.`booking_id` AS `booking_id`,
   `rooms`.`room_id` AS `room_id`,
   `hotels`.`hotel_city` AS `hotel_city`,
   `hotels`.`hotel_name` AS `hotel_name`,
   `room_type`.`type` AS `type`,
   `room_type`.`price` AS `price`,
   `facilities`.`pool` AS `pool`,
   `facilities`.`restaurant` AS `restaurant`,
   `facilities`.`children_activities` AS `children_activities`,
   `facilities`.`entertainment` AS `entertainment`,
   `hotels`.`distance_to_beach` AS `distance_to_beach`,
   `hotels`.`distance_to_centre` AS `distance_to_centre`
FROM (((`hotels` join `room_type`) join `facilities`) join (`rooms` left join `bookingsxrooms` on((`rooms`.`room_id` = `bookingsxrooms`.`room_id`)))) where (isnull(`bookingsxrooms`.`booking_id`) and (`hotels`.`hotel_id` = `rooms`.`hotel_id`) and (`rooms`.`room_type_id` = `room_type`.`room_type_id`) and (`facilities`.`facility_id` = `hotels`.`facility_id`));


# Replace placeholder table for all_booked_hotel_rooms with correct view syntax
# ------------------------------------------------------------

DROP TABLE `all_booked_hotel_rooms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all_booked_hotel_rooms`
AS SELECT
   distinct `rooms`.`room_id` AS `room_id`,
   `hotels`.`hotel_city` AS `hotel_city`,
   `hotels`.`hotel_name` AS `hotel_name`,
   `room_type`.`type` AS `type`,
   `room_type`.`price` AS `price`,
   `facilities`.`pool` AS `pool`,
   `facilities`.`restaurant` AS `restaurant`,
   `facilities`.`children_activities` AS `children_activities`,
   `facilities`.`entertainment` AS `entertainment`,
   `hotels`.`distance_to_beach` AS `distance_to_beach`,
   `hotels`.`distance_to_centre` AS `distance_to_centre`
FROM (((((`hotels` join `room_type`) join `facilities`) join `bookings`) join `bookingsxrooms`) join `rooms`) where ((`rooms`.`room_id` = `bookingsxrooms`.`room_id`) and (`bookings`.`booking_id` = `bookingsxrooms`.`booking_id`) and (`hotels`.`hotel_id` = `rooms`.`hotel_id`) and (`rooms`.`room_type_id` = `room_type`.`room_type_id`) and (`facilities`.`facility_id` = `hotels`.`facility_id`));

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
