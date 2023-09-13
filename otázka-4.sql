

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
ORDER BY category_code_q4, year_q4;