CREATE
OR REPLACE VIEW `race_results_view` AS
SELECT
  `wp_race_results`.`position` AS `rank`,
  `wp_race_results`.`name` AS `name`,
  cast(substr (`wp_race_results`.`time`, 2) as time) AS `time`,  /* strip the leading 'T' and convert to time */
  `wp_race_results`.`type` AS `type`,
  `wp_race_results`.`club` AS `club`,
  `wp_race_results`.`classification` AS `classification`,
  `wp_race_results`.`cat` AS `cat`,
  `wp_race_results`.`mph` AS `mph`,
  str_to_date (`wp_race_results`.`date`, '%Y%m%d') AS `date`,
  `wp_race_results`.`course` AS `course`,
  `wp_race_results`.`event_type` AS `event_type`
FROM
  `wp_race_results`;
