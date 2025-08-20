/*
  Master Race Results Table

  Structure matches the export produced by Nick Wild
*/

CREATE TABLE `tvcc_race_results` (
  `name` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `ctt` int DEFAULT NULL,
  `time_sec` int DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `position` int DEFAULT NULL,
  `club` varchar(255) DEFAULT NULL,
  `classification` char(1) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `cat` varchar(255) DEFAULT NULL,
  `standard` time DEFAULT NULL,
  `standard_sec` varchar(255) DEFAULT NULL,
  `plus_sec` varchar(255) DEFAULT NULL,
  `plus` varchar(255) DEFAULT NULL,
  `mph` float DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `distance` int DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `event_type` char(1) DEFAULT NULL,
  `organiser` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `process_date` varchar(255) DEFAULT NULL,
  `club_id` varchar(255) DEFAULT NULL
)