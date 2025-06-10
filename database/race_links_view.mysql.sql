CREATE
OR REPLACE VIEW `race_links_view` AS
SELECT DISTINCT
  STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d') AS `date`,
  YEAR(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d')) AS `year`,
  MONTH(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d')) AS `month`,
  DAY(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d')) AS `day`,
  MONTHNAME(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d')) AS `month_name`,
  DAYNAME(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d')) AS `day_name`,
  `wp_race_results`.`distance` AS `distance`,
  `wp_race_results`.`course` AS `course`,
  `wp_race_results`.`event_type` AS `event_type`
FROM
  `wp_race_results`
