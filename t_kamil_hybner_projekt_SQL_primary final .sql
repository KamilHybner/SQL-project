
-- Tvorba pomocných tabulek, view a primární tabulky--

-- pomocná tabulka q1 --
CREATE OR REPLACE TABLE t_kamil_hybner_q_1 AS 
SELECT 
		ROUND( AVG(value))   AS average_payroll_year, 
		cp.industry_branch_code ,
		cp.payroll_year 
FROM	czechia_payroll cp 
WHERE	cp.value_type_code = 5958 AND 
		cp.value  IS NOT NULL AND 
		cp.industry_branch_code IS NOT NULL AND 
		calculation_code = 200 AND 
		payroll_year != 2021
GROUP BY payroll_year, industry_branch_code
ORDER BY industry_branch_code , payroll_year;



-- Vytvořený pomocný pohled na průměrné mzdy po letech pro pomocnou tabulku q2 -

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


-- vytvořený pomocný pohled a seskupená a zprůměrovaná data pro pomocnou tabulku q2 --
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
GROUP BY category_code , YEAR (date_from);


-- vytvořená pomocná tabulka q2 --
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


-- vytvořená pomocná tabulka q3 --
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
 	vcp.`YEAR` = vcp2.`YEAR`-12;

 	

-- vytvořená pomocná tabulka q4 --
CREATE OR REPLACE TABLE t_kamil_hybner_q_4 AS
SELECT 	vcp.average_value_price AS average_value_price_q4,
		vcp3.average_value_price AS average_value_price_plus_1,
		round( (vcp.average_value_price/vcp3.average_value_price )*100-100,2) AS year_on_year_price_increase_in_percent,
		vcp.category_code AS category_code_q4,
		vcp.`YEAR`AS 'year_q4',
		vcp3.`YEAR` AS year_plus_1,
		vcp.name AS name_q4
FROM 	v_czechia_price vcp 
LEFT JOIN v_czechia_price vcp3 
		ON	vcp.category_code = vcp3.category_code AND 
			vcp.`YEAR` = vcp3.`YEAR`+1;


-- tvorba primární final tabulky pro otázky 1-4 --	
 CREATE OR REPLACE TABLE t_kamil_hybner_SQL_primary_final_2 AS
 SELECT *
 FROM t_kamil_hybner_q_2 q2
 LEFT JOIN t_kamil_hybner_q_3 q3 
 	ON q2.category_code_q2 = q3.category_code_q3  AND 
 	q2.YEAR_q2  = q3.first_year 
 LEFT JOIN t_kamil_hybner_q_4 q4
 	ON q2.category_code_q2 = q4.category_code_q4 
 LEFT JOIN t_kamil_hybner_q_1 q1
 	ON q2.YEAR_q2  = q1.payroll_year;
		 	