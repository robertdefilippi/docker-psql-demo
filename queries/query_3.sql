-- Does not tell us much
SELECT
	city,
	district,
	property_type,
	AVG(price) OVER (PARTITION BY city, district, property_type)

FROM
	land_registry_price_paid_uk
	
-- Won't work ... window functions can't be used in HAVING or WHERE statements
SELECT
	transaction,
	street,
	price,
	AVG(price) OVER (PARTITION BY city, district, property_type),
	ROUND(((price - AVG(price) OVER (PARTITION BY city, district, property_type)) / (AVG(price) OVER (PARTITION BY city, district, property_type))) * 100, 4) || '%'  AS "Difference"

FROM
	land_registry_price_paid_uk

WHERE ((price - AVG(price) OVER (PARTITION BY city, district, property_type)) / (AVG(price) OVER (PARTITION BY city, district, property_type))) > .5
	

-- Create the window function and find the average price of a transaction by city, district, and property_type
WITH cte_above_average_price AS (
	SELECT
		transaction,
		city,
		district,
		property_type,
		street,
		price,
		-- This is the window function for the average
		AVG(price) OVER (PARTITION BY city, district, property_type) "Avg Price for City, District, and Property Type",
		-- Comparing the price column to the results in the window
		ROUND(((price - AVG(price) OVER (PARTITION BY city, district, property_type)) / (AVG(price) OVER (PARTITION BY city, district, property_type))) * 100, 2) AS "Difference"

	FROM
		land_registry_price_paid_uk
)

-- Select and count only specific results
SELECT COUNT(*),
	   city,
	   property_type

FROM cte_above_average_price

WHERE "Difference" > 500

GROUP BY cte_above_average_price.city, cte_above_average_price.property_type

ORDER BY COUNT(*) DESC
