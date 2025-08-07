/*
  Master Competition Results Table - 2025 Data Structure (WIP)

  Structure mostly matches the export produced by Nick Wild
*/

CREATE TABLE `wp_competition_results` (
  `bike` VARCHAR(2) DEFAULT NULL,
  `club` VARCHAR(255) DEFAULT NULL,
  `date` VARCHAR(10) DEFAULT NULL,
  `course` VARCHAR(50) DEFAULT NULL,
  `class` VARCHAR(50) DEFAULT NULL,
  `time` VARCHAR(10) DEFAULT NULL,
  `first_name` VARCHAR(100) DEFAULT NULL,
  `last_name` VARCHAR(100) DEFAULT NULL,
  `age_category` VARCHAR(50) DEFAULT NULL,
  `position` VARCHAR(50) DEFAULT NULL,
  `miles` INT DEFAULT NULL,
  `standard` VARCHAR(10) DEFAULT NULL,
  `plus` VARCHAR(10) DEFAULT NULL,
  `mph` VARCHAR(7) DEFAULT NULL,
  `bar_average_mph` VARCHAR(7) DEFAULT NULL,
  `bar_complete` VARCHAR(2) DEFAULT NULL,
  `sbar_standard` VARCHAR(10) DEFAULT NULL,
  `sbar_complete` VARCHAR(2) DEFAULT NULL,
  `juvbar_average_mph` VARCHAR(7) DEFAULT NULL,
  `juvbar_complete` VARCHAR(2) DEFAULT NULL,
  `jbar_average_mph` VARCHAR(7) DEFAULT NULL,
  `jbar_complete` VARCHAR(1) DEFAULT NULL,
  `bar_pos` VARCHAR(2) DEFAULT NULL,
  `sbar_pos` VARCHAR(2) DEFAULT NULL,
  `jbar_pos` VARCHAR(2) DEFAULT NULL,
  `juvbar_pos` VARCHAR(2) DEFAULT NULL
);