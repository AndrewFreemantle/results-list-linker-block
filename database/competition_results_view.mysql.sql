CREATE
OR REPLACE VIEW `competition_results_view` AS
SELECT
  CAST(`position` AS UNSIGNED) AS `position`,
  CONCAT(`first_name`, ' ', `last_name`) AS `name`,
  CAST(`time` AS TIME) AS `time`,
  `bike` AS `bike`,
  `club` AS `club`,
  `class` AS `class`,
  `age_category` AS `age_category`,
  STR_TO_DATE(`date`, '%d/%m/%Y') AS `date`,
  YEAR(STR_TO_DATE(`date`, '%d/%m/%Y')) AS `year`,
  UPPER(`course`) AS `course`,
  CASE
    WHEN `standard` LIKE 'NA' THEN NULL
    ELSE CAST(`standard` AS TIME)
  END AS `standard`,
  CASE
    WHEN `mph` = 'NA' THEN NULL
    ELSE CAST(`mph` AS FLOAT)
  END AS `mph`,
  `miles` AS `miles`,

  CASE
    WHEN `bar_complete` = 'NA' THEN NULL
    ELSE CAST(`bar_complete` AS UNSIGNED)
  END AS `bar_complete`,
  CASE
    WHEN `bar_pos` = 'NA' THEN NULL
    ELSE CAST(`bar_pos` AS UNSIGNED)
  END AS `bar_position`,
  CASE
    WHEN `bar_average_mph` = 'NA' THEN NULL
    ELSE CAST(`bar_average_mph` AS FLOAT)
  END AS `bar_average_mph`,

  CASE
    WHEN `sbar_complete` = 'NA' THEN NULL
    ELSE CAST(`sbar_complete` AS UNSIGNED)
  END AS `sbar_complete`,
  CASE
    WHEN `sbar_pos` = 'NA' THEN NULL
    ELSE CAST(`sbar_pos` AS UNSIGNED)
  END AS `sbar_position`,
  NULL AS `sbar_average_mph`,
  CASE
    WHEN `sbar_standard` LIKE 'T%' THEN cast(substring(`sbar_standard`, 2) as time)  /* strip the leading 'T' and convert to time */
    ELSE NULL
  END AS `sbar_standard`,

  CASE
    WHEN `jbar_complete` = 'NA' THEN NULL
    ELSE CAST(`jbar_complete` AS UNSIGNED)
  END AS `jbar_complete`,
  CASE
    WHEN `jbar_pos` = 'NA' THEN NULL
    ELSE CAST(`jbar_pos` AS UNSIGNED)
  END AS `jbar_position`,
  CASE
    WHEN `jbar_average_mph` = 'NA' THEN NULL
    ELSE CAST(`jbar_average_mph` AS FLOAT)
  END AS `jbar_average_mph`,

  CASE
    WHEN `juvbar_complete` = 'NA' THEN NULL
    ELSE CAST(`juvbar_complete` AS UNSIGNED)
  END AS `juvbar_complete`,
  CASE
    WHEN `juvbar_pos` = 'NA' THEN NULL
    ELSE CAST(`juvbar_pos` AS UNSIGNED)
  END AS `juvbar_position`,
  CASE
    WHEN `juvbar_average_mph` = 'NA' THEN NULL
    ELSE CAST(`juvbar_average_mph` AS FLOAT)
  END AS `juvbar_average_mph`
FROM
  `wp_competition_results`;