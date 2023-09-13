
-- vyřešená otázka číslo 1 --
SELECT average_payroll_year,
    	industry_branch_code,
		payroll_year 
FROM t_kamil_hybner_sql_primary_final_2
GROUP BY industry_branch_code, payroll_year;