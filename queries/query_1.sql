WITH cte_d_property AS (

	SELECT
	price,
	property_type,
	city,
	district,
	county
	FROM
	land_registry_price_paid_uk
	WHERE
	property_type IN ('D'))
	
SELECT MAX(price), city
FROM cte_d_property 
GROUP BY city
ORDER BY MAX(price) DESC