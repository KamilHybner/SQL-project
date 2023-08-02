CREATE OR REPLACE TABLE t_kamil_hybner_q_1 AS
SELECT 
		round ( AVG(value))   AS average_payroll_year, 
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