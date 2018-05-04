WITH cte_count_city_distr AS (

	SELECT
	count(*),
	city,
	district
	FROM
	land_registry_price_paid_uk
	GROUP BY city, district
),

cte_count_city AS (

	SELECT
	count(*),
	city
	FROM
	land_registry_price_paid_uk
	GROUP BY city
),

cte_city_district AS (
	
	SELECT
	city,
	city || ' ' || district AS "City-District"
	
	FROM
	land_registry_price_paid_uk
),
	
cte_count_per_city AS (
	
	SELECT
	cte_count_city_distr.count,
	ROUND(cte_count_city_distr.count/cte_count_city.count::DECIMAL * 100, 2) || '%' AS "Percent of City",
	cte_count_city_distr.city,
	cte_count_city_distr.district
	
	FROM cte_count_city_distr
	
	LEFT JOIN
	
	cte_count_city ON cte_count_city.city = cte_count_city_distr.city
	
	ORDER BY city, "Percent of City" DESC

)
	
SELECT 
	MAX("Percent of City"), 
	cte_city_district."City-District"

FROM 
	cte_count_per_city 

LEFT JOIN
	cte_city_district ON cte_city_district.city = cte_count_per_city.city

GROUP BY cte_city_district."City-District"