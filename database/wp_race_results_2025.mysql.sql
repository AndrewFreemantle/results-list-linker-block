/*
  Master Race Results Table - 2025 Data Structure (WIP)

  Structure matches the export produced by Nick Wild
*/

CREATE TABLE `wp_race_results_2025` (
  `position` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `bike` varchar(2) DEFAULT NULL,
  `club` varchar(255) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `age_category` varchar(50) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `standard` varchar(50) DEFAULT NULL,
  `mph` float DEFAULT NULL,
  `miles` int DEFAULT NULL
)