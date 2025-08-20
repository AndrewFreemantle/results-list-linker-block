SELECT
  crv.`bar_position` AS `Position`,
  crv.`name` AS `Name`,
  crv.`club` AS `Club`,
  crv.`age_category` AS `Cat`,
  (
    SELECT `time`
    FROM competition_results_view sub
    WHERE sub.`name` = crv.`name`
      AND sub.`club` = crv.`club`
      AND sub.`age_category` = crv.`age_category`
      AND sub.`year` = crv.`year`
      AND sub.`course` = 'M105'
    ORDER BY `time` ASC
    LIMIT 1
  ) AS `M105.1`,
  (
    SELECT `time`
    FROM competition_results_view sub
    WHERE sub.`name` = crv.`name`
      AND sub.`club` = crv.`club`
      AND sub.`age_category` = crv.`age_category`
      AND sub.`year` = crv.`year`
      AND sub.`course` = 'M105'
    ORDER BY `time` ASC
    LIMIT 1 OFFSET 1
  ) AS `M105.2`,
  (
    SELECT `time`
    FROM competition_results_view sub
    WHERE sub.`name` = crv.`name`
      AND sub.`club` = crv.`club`
      AND sub.`age_category` = crv.`age_category`
      AND sub.`year` = crv.`year`
      AND sub.`course` = 'M254'
    ORDER BY `time` ASC
    LIMIT 1
  ) AS `M254`,
  crv.`bar_average_mph` AS `Average MPH`
FROM
  `competition_results_view` crv
WHERE
  crv.`year` = %VAR1%
  AND crv.`bar_complete` = %VAR2%
GROUP BY
  crv.`bar_position`,
  crv.`name`,
  crv.`club`,
  crv.`age_category`,
  crv.`bar_average_mph`;