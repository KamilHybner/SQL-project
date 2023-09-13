
-- vyřešená otázka číslo 3 --
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
LIMIT 1;