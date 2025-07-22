CREATE
OR REPLACE VIEW `race_links_view` AS
SELECT DISTINCT
  `date`,
  DATE_FORMAT(`date`, '%d/%m/%Y') AS `date_gb`,
  YEAR(`date`) AS `year`,
  `course` AS `course`,
  `miles` AS `miles`
FROM
  `race_results_view`
