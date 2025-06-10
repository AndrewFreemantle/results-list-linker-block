CREATE
OR REPLACE VIEW `race_links_view` AS
SELECT DISTINCT
  STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d') AS `date`,
  DATE_FORMAT(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d'), '%d/%m/%Y') AS `date_gb`,
  YEAR(STR_TO_DATE(`wp_race_results`.`date`, '%Y%m%d')) AS `year`,
  `wp_race_results`.`distance` AS `distance`,
  `wp_race_results`.`course` AS `course`,
  `wp_race_results`.`event_type` AS `event_type`
FROM
  `wp_race_results`
