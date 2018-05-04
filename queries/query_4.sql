SELECT 
  city,
  '[' || array_to_string(array_agg(DISTINCT(district)), ', ') || ']' AS "Districts"
FROM
  land_registry_price_paid_uk
 GROUP BY city