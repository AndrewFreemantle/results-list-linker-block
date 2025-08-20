/*
  Master Competition Results Table - 2025 Data Structure (WIP)

  Structure mostly matches the export produced by Nick Wild
*/

CREATE TABLE `tvcc_competition_results` (
  `name` VARCHAR(255) DEFAULT NULL,
  `club` VARCHAR(255) DEFAULT NULL,
  `bike` VARCHAR(2) DEFAULT NULL,
  `date` VARCHAR(10) DEFAULT '2025-01-01',
  `course` VARCHAR(10) DEFAULT NULL,
  `time` VARCHAR(10) DEFAULT NULL,
  `age_category` VARCHAR(10) DEFAULT NULL,
  `plus` VARCHAR(10) DEFAULT NULL,
  `bar_complete` VARCHAR(2) DEFAULT NULL,
  `bar_average_mph` VARCHAR(7) DEFAULT NULL,
  `bar_position` VARCHAR(2) DEFAULT NULL,
  `sbar_complete` VARCHAR(2) DEFAULT NULL,
  `sbar_standard` VARCHAR(10) DEFAULT NULL,
  `sbar_position` VARCHAR(2) DEFAULT NULL,
  `jbar_complete` VARCHAR(2) DEFAULT NULL,
  `jbar_position` VARCHAR(2) DEFAULT NULL,
  `juvbar_complete` VARCHAR(2) DEFAULT NULL,
  `juvbar_position` VARCHAR(2) DEFAULT NULL
);