CREATE OR REPLACE TABLE t_kamil_hybner_q_4 AS
SELECT 	vcp.average_value_price AS average_value_price_q4,
		vcp3.average_value_price AS average_value_price_plus_1,
		round( (vcp.average_value_price/vcp3.average_value_price )*100-100,2) AS year_on_year_price_increase_in_percent,
		vcp.category_code AS category_code_q4,
		vcp.`YEAR`AS year_q4,
		vcp3.`YEAR` AS year_plus_1,
		vcp.name AS name_q4
FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp3 
		ON	vcp.category_code = vcp3.category_code AND 
			vcp.`YEAR` = vcp3.`YEAR`+1;

		
-- s filtrací meziročních změn větších než 10% --
	
SELECT 	vcp.average_value_price AS average_value_price_q4,
		vcp3.average_value_price AS average_value_price_plus_1,
		round( (vcp.average_value_price/vcp3.average_value_price )*100-100,2) AS year_on_year_price_increase_in_percent,
		vcp.category_code,
		vcp.`YEAR`AS year_q4,
		vcp3.`YEAR` AS year_plus_1,
		vcp.name AS name_q4
FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp3 
		ON	vcp.category_code = vcp3.category_code AND 
			vcp.`YEAR` = vcp3.`YEAR`+1
HAVING 		year_on_year_price_increase_in_percent > 10
ORDER BY	vcp.category_code , vcp.`YEAR`;
	

-- VERZE 2 po připomínkách. Script jsem navázal na tabulku primary final 2 --


SELECT average_value_price_q4,
		average_value_price_plus_1,
		year_on_year_price_increase_in_percent,
		category_code_q4,
		year_q4,
		year_plus_1,
		name_q4 
FROM t_kamil_hybner_sql_primary_final_2 tkhspp 
GROUP BY category_code_q4 ,  year_q4, year_plus_1 
HAVING year_on_year_price_increase_in_percent > 10
ORDER BY category_code_q4, year_q4 