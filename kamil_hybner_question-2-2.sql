CREATE OR REPLACE VIEW v_czechia_price AS 
SELECT 
	Round (AVG (value), 2) AS average_value_price,
	cp.category_code , 
	YEAR (date_from) AS YEAR,
	cpc.name,
	cpc.price_value,
	cpc.price_unit 
FROM czechia_price cp 
LEFT JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
GROUP BY category_code , YEAR (date_from)	;	



CREATE OR REPLACE VIEW v_czechia_payroll AS
SELECT
		round ( avg(value)) AS avg_value_payroll,
		payroll_year 
FROM 	czechia_payroll cp 
WHERE 	value_type_code = 5958 AND  
		value IS NOT NULL AND 
		payroll_year !=2021
GROUP BY payroll_year 
ORDER BY payroll_year ;


CREATE OR REPLACE TABLE t_kamil_hybner_q_2 AS 
SELECT 
		vcp.average_value_price AS average_value_price_q2,
		vcp2.avg_value_payroll ,
		round( vcp2.avg_value_payroll/vcp.average_value_price) AS pieces_can_buy ,
		vcp.category_code AS category_code_q2,
		vcp.`YEAR`AS `YEAR_q2`,
		vcp.name AS name_q2,
		vcp.price_value ,
		vcp.price_unit 
FROM	v_czechia_price vcp 
LEFT JOIN	v_czechia_payroll vcp2 
		ON 	vcp.`YEAR` = vcp2.payroll_year ; 
	
	
	-- s filtrací dat --
SELECT 
		vcp.average_value_price AS average_value_price_q2,
		vcp2.avg_value_payroll ,
		round( vcp2.avg_value_payroll/vcp.average_value_price) AS pieces_can_buy ,
		vcp.category_code AS category_code_q2,
		vcp.`YEAR` AS `YEAR_q2`, 
		vcp.name AS name_q2,
		vcp.price_value ,
		vcp.price_unit 
FROM	v_czechia_price vcp 
LEFT JOIN	v_czechia_payroll vcp2 
		ON 	vcp.`YEAR` = vcp2.payroll_year  
WHERE	 	vcp.`YEAR` = 2006 AND  	vcp.category_code IN ( 111301, 114201) OR
			vcp.`YEAR` = 2018 AND	vcp.category_code IN ( 111301, 114201)
ORDER BY	category_code, 'Year';





-- VERZE 2 po připomínkách. Script jsem navázal na primární tabulku 2 --

SELECT	pieces_can_buy,
		category_code_q2,
		YEAR_q2,
		name_q2,
		price_value,
		price_unit 
FROM t_kamil_hybner_sql_primary_final_2
WHERE	YEAR_q2 = 2006 AND category_code_q2 IN (111301, 114201) OR 
		YEAR_q2 = 2018 AND category_code_q2 IN (111301, 114201)
GROUP BY category_code_q2, YEAR_q2 
ORDER BY category_code_q2, YEAR_q2 
















