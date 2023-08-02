

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