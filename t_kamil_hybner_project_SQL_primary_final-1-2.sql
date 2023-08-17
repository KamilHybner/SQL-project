CREATE OR REPLACE TABLE t_kamil_hybner_SQL_primary_final AS
SELECT *
 FROM t_kamil_hybner_q_2 q2
 LEFT JOIN t_kamil_hybner_q_3 q3 
 	ON q2.category_code_q2 = q3.category_code_q3  AND 
 	q2.YEAR_q2  = q3.first_year 
 LEFT JOIN t_kamil_hybner_q_4 q4
 	ON q2.category_code_q2 = q4.year_q4 
 LEFT JOIN t_kamil_hybner_q_1 q1
 	ON q2.YEAR_q2  = q1.payroll_year 
 	
 	
-- VERZE 2 změna spojení oproti původní final tabulce. Bylo q4.year_q4 nyní je q4.category_code_q4 --

 CREATE OR REPLACE TABLE t_kamil_hybner_SQL_primary_final_2 AS
 SELECT *
 FROM t_kamil_hybner_q_2 q2
 LEFT JOIN t_kamil_hybner_q_3 q3 
 	ON q2.category_code_q2 = q3.category_code_q3  AND 
 	q2.YEAR_q2  = q3.first_year 
 LEFT JOIN t_kamil_hybner_q_4 q4
 	ON q2.category_code_q2 = q4.category_code_q4 
 LEFT JOIN t_kamil_hybner_q_1 q1
 	ON q2.YEAR_q2  = q1.payroll_year