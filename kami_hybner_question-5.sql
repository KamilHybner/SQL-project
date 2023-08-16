CREATE OR REPLACE VIEW  v_avg_value_price_year AS
SELECT 
	round( avg(value),2) AS 'avg_value_price_year',
	YEAR (date_from) AS 'year_avg_price'
FROM czechia_price cp 
GROUP BY YEAR (date_from);


CREATE OR REPLACE  VIEW v_avg_payrol_2006_2018 AS
SELECT 	round( avg(value)),
		payroll_year 
FROM 	czechia_payroll cp 
WHERE 	value IS NOT NULL AND 
		value_type_code = 5958 AND 
		payroll_year BETWEEN 2006 AND 2018
GROUP  BY payroll_year;


 CREATE OR REPLACE VIEW v_czechia_GDP AS
 SELECT 
 	country, 
    YEAR AS 'year_GDP',
 	round(GDP) AS GDP
 FROM economies e 
 WHERE country = 'Czech Republic' AND
 YEAR BETWEEN 2006 AND  2018
 ORDER BY `year` ;
 

CREATE OR REPLACE TABLE t_kamil_hybner_project_SQL_secendary_final AS
SELECT 
		gdp.gdp,
		price.avg_value_price_year  AS avg_price_food ,
		py.`round( avg(value))` AS avg_payroll,
		gdp.year_GDP 
FROM	v_czechia_gdp gdp
LEFT JOIN 	v_avg_value_price_year price
	ON 		gdp.year_GDP = price .year_avg_price  
LEFT JOIN 	v_avg_payrol_2006_2018  py 
	ON 		gdp.year_GDP = py.payroll_year 
ORDER BY 	year_GDP ;