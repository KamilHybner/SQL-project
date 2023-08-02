CREATE OR REPLACE TABLE t_kamil_hybner_q_3 AS 
SELECT 	vcp.category_code AS category_code_q3,
		vcp.average_value_price  AS 'first_average_value',
		vcp2.average_value_price  AS 'last_average_value' ,
		round( ((vcp2.average_value_price /vcp.average_value_price)*100)-100,2) AS percentage_change,
		vcp.`YEAR` AS 'first_year',
		vcp2.`YEAR`AS 'last_year', 
		vcp.name AS name_q3
		FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp2 
	ON vcp.category_code = vcp2.category_code AND 
 	vcp.`YEAR` = vcp2.`YEAR`-12
 	
 
 -- s filtrací--
 	
 	SELECT 	vcp.category_code AS category_code_q3,
		vcp.average_value_price  AS 'first_average_value',
		vcp2.average_value_price  AS 'last_average_value' ,
		round( ((vcp2.average_value_price /vcp.average_value_price)*100)-100,2) AS percentage_change,
		vcp.`YEAR` AS 'first_year',
		vcp2.`YEAR`AS 'last_year', 
		vcp.name AS name_q3
		FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp2 
	ON vcp.category_code = vcp2.category_code AND 
 	vcp.`YEAR` = vcp2.`YEAR`-12
 	ORDER BY percentage_change DESC  
 LIMIT 26;