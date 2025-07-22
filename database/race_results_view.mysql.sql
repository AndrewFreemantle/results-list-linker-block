CREATE
OR REPLACE VIEW `race_results_view` AS
SELECT
  `position` AS `position`,
  `name` AS `name`,
  cast(substring(`time`, 2) as time) AS `time`,  /* strip the leading 'T' and convert to time */
  `bike` AS `bike`,
  `club` AS `club`,
  `class` AS `class`,
  `age_category` AS `age_category`,
  str_to_date (`date`, '%Y-%m-%d') AS `date`,
  `course` AS `course`,
  CASE
    WHEN `standard` LIKE 'T%' THEN cast(substring(`standard`, 2) as time)  /* strip the leading 'T' and convert to time */
    ELSE NULL
  END AS `standard`,
  `mph` AS `mph`,
  `miles` AS `miles`
FROM
  `wp_race_results_2025`
UNION
SELECT
  `position`,
  `name`,
  cast(substring(`time`, 2) as time) AS `time`,  /* strip the leading 'T' and convert to time */
  `type` AS `bike`,
  `club` AS `club`,
  `classification` AS `class`,
  `cat` AS `age_category`,
  str_to_date (`date`, '%Y%m%d') AS `date`,
  `course` AS `course`,
  `standard` AS `standard`,
  `mph` AS `mph`,
  `distance` AS `miles`
FROM
  `wp_race_results`;