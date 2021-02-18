/***2
Cert, aquesta sentencia s'executa correctament***/
/***3
Fals, aquesta sentencia no s'executa correctament, ja que no existeix la taula job_grades***/
/***4
1. No existeix sal, es salary
2. Per multiplicar s'utilitza * (exemple: salary * 12)
3. Per donar nom a una columna, es fa [consulta] AS 'NOM'
4. Falta coma entre el segon i tercer item de la select***/
/***5***/
DESCRIBE departments;
SELECT * FROM departments;
/***6***/
DESCRIBE employees;
SELECT employee_id AS 'ID', last_name, job_id, hire_date
FROM employees;
/***7***/
SELECT DISTINCT(job_id)
FROM employees;
/***8***/
SELECT employee_id AS 'Emp#', last_name AS 'Employee', job_id AS 'Job', hire_date AS 'Hire Date'
FROM employees;
/***9***/
SELECT CONCAT(last_name,', ',job_id) AS 'Employee and Title'
FROM employees;
/***10***/
SELECT CONCAT(COALESCE(`employee_id`,''),', ', COALESCE(`first_name`,''),', ', COALESCE(`last_name`,''),', ', COALESCE(`email`,''),', ', COALESCE(`phone_number`,''),', ', COALESCE(`hire_date`,''),', ', COALESCE(`job_id`,''),', ', COALESCE(`salary`,''),', ', COALESCE(`commission_pct`,''),', ', COALESCE(`manager_id`,''),', ', COALESCE(`department_id`,''),', ') AS 'THE_OUTPUT'
FROM employees;
select * from employees