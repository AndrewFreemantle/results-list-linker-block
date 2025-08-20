SELECT
  crv.`sbar_position` AS `Position`,
  crv.`name` AS `Name`,
  crv.`club` AS `Club`,
  crv.`age_category` AS `Cat`,
  (
    SELECT `plus`
    FROM competition_results_view sub
    WHERE sub.`name` = crv.`name`
      AND sub.`club` = crv.`club`
      AND sub.`age_category` = crv.`age_category`
      AND sub.`year` = crv.`year`
      AND sub.`course` = 'M105'
      AND sub.`sbar_complete` = %VAR2%
    ORDER BY `plus_order` DESC
    LIMIT 1
  ) AS `M105.1`,
  (
    SELECT `plus`
    FROM competition_results_view sub
    WHERE sub.`name` = crv.`name`
      AND sub.`club` = crv.`club`
      AND sub.`age_category` = crv.`age_category`
      AND sub.`year` = crv.`year`
      AND sub.`course` = 'M105'
      AND sub.`sbar_complete` = %VAR2%
    ORDER BY `plus_order` DESC
    LIMIT 1 OFFSET 1
  ) AS `M105.2`,
  (
    SELECT `plus`
    FROM competition_results_view sub
    WHERE sub.`name` = crv.`name`
      AND sub.`club` = crv.`club`
      AND sub.`age_category` = crv.`age_category`
      AND sub.`year` = crv.`year`
      AND sub.`course` = 'M254'
      AND sub.`sbar_complete` = %VAR2%
    ORDER BY `plus_order` DESC
    LIMIT 1
  ) AS `M254`,
  crv.`sbar_standard` AS `Standard`
FROM
  `competition_results_view` crv
WHERE
  crv.`year` = %VAR1%
  AND crv.`sbar_complete` = %VAR2%
GROUP BY
  crv.`sbar_position`,
  crv.`name`,
  crv.`club`,
  crv.`age_category`,
  crv.`sbar_standard`;