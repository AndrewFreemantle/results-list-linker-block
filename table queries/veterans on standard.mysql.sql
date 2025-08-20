SELECT
  `sbar_position` as `Position`,
  `name` AS `Name`,
  `club` AS `Club`,
  `age_category` AS `Cat`,
  `time` AS `Time`,
  `sbar_standard` AS 'Standard',
  `plus` AS `Plus`
FROM
  `competition_results_view`
WHERE
  `year` = %VAR1%
  AND `sbar_complete` = 3
GROUP BY
  `sbar_position`,
  `name`,
  `club`,
  `age_category`;
