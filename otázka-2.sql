

-- vyřešená otázka číslo 2 --
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
ORDER BY category_code_q2, YEAR_q2;