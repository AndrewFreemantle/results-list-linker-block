CREATE
OR REPLACE VIEW `competition_results_view` AS
SELECT
  `name` AS `name`,
  CAST(SUBSTRING(`time`, 2) AS TIME) AS `time`,
  `bike` AS `bike`,
  `club` AS `club`,
  `age_category` AS `age_category`,
  STR_TO_DATE(`date`, '%Y-%m-%d') AS `date`,
  YEAR(STR_TO_DATE(`date`, '%Y-%m-%d')) AS `year`,
  UPPER(`course`) AS `course`,
  CASE
    WHEN `plus` LIKE 'T-%'
      THEN CAST(CONCAT('-00:', SUBSTRING(`plus`, 3)) AS TIME)
    WHEN `plus` LIKE 'T%'
      THEN CAST(CONCAT('00:', SUBSTRING(`plus`, 2)) AS TIME)
    ELSE NULL
  END AS `plus`,
  CASE
    WHEN `plus` LIKE 'T-%'
      THEN CAST(CONCAT('00:', SUBSTRING(`plus`, 3)) AS TIME)
    WHEN `plus` LIKE 'T%'
      THEN CAST(CONCAT('01:', SUBSTRING(`plus`, 2)) AS TIME)
    ELSE NULL
  END AS `plus_order`,

  CASE
    WHEN `bar_complete` = 'NA' THEN NULL
    ELSE CAST(`bar_complete` AS UNSIGNED)
  END AS `bar_complete`,
  CASE
    WHEN `bar_position` = 'NA' THEN NULL
    ELSE CAST(`bar_position` AS UNSIGNED)
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
    WHEN `sbar_position` = 'NA' THEN NULL
    ELSE CAST(`sbar_position` AS UNSIGNED)
  END AS `sbar_position`,
  NULL AS `sbar_average_mph`,
  CASE
    WHEN `sbar_standard` LIKE 'T-%'
      THEN CAST(CONCAT('-00:', SUBSTRING(`sbar_standard`, 3)) AS TIME)
    WHEN `sbar_standard` LIKE 'T%'
      THEN CAST(CONCAT('00:', SUBSTRING(`sbar_standard`, 2)) AS TIME)
    ELSE NULL
  END AS `sbar_standard`,

  CASE
    WHEN `jbar_complete` = 'NA' THEN NULL
    ELSE CAST(`jbar_complete` AS UNSIGNED)
  END AS `jbar_complete`,
  CASE
    WHEN `jbar_position` = 'NA' THEN NULL
    ELSE CAST(`jbar_position` AS UNSIGNED)
  END AS `jbar_position`,

  CASE
    WHEN `juvbar_complete` = 'NA' THEN NULL
    ELSE CAST(`juvbar_complete` AS UNSIGNED)
  END AS `juvbar_complete`,
  CASE
    WHEN `juvbar_position` = 'NA' THEN NULL
    ELSE CAST(`juvbar_position` AS UNSIGNED)
  END AS `juvbar_position`
FROM
  `tvcc_competition_results`;