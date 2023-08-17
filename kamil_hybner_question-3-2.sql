CREATE OR REPLACE TABLE t_kamil_hybner_q_3 AS 
SELECT 	vcp.category_code AS category_code_q3,
		vcp.average_value_price  AS first_average_value,
		vcp2.average_value_price  AS last_average_value ,
		round( ((vcp2.average_value_price /vcp.average_value_price)*100)-100,2) AS percentage_change,
		vcp.`YEAR` AS first_year,
		vcp2.`YEAR`AS last_year, 
		vcp.name AS name_q3
		FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp2 
	ON vcp.category_code = vcp2.category_code AND 
 	vcp.`YEAR` = vcp2.`YEAR`-12
 	
 
 -- s filtrací--
 	
 	SELECT 	vcp.category_code AS category_code_q3,
		vcp.average_value_price  AS first_average_value,
		vcp2.average_value_price  AS last_average_value,
		round( ((vcp2.average_value_price /vcp.average_value_price)*100)-100,2) AS percentage_change,
		vcp.`YEAR` AS first_year,
		vcp2.`YEAR`AS last_year, 
		vcp.name AS name_q3
		FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp2 
	ON vcp.category_code = vcp2.category_code AND 
 	vcp.`YEAR` = vcp2.`YEAR`-12
 	ORDER BY percentage_change DESC  
 LIMIT 26;
 

-- VERZE 2 po připomínkách. Scrip jsem navázal na tabulku primary final 2 --


SELECT	first_average_value,
		last_average_value,
		percentage_change,
		first_year,
		last_year,
		name_q3 
FROM t_kamil_hybner_sql_primary_final_2 tkhspf2 
WHERE last_average_value IS NOT NULL 
GROUP BY name_q3 
ORDER BY percentage_change
LIMIT 1