/*1*/
SELECT CURRENT_DATE AS 'Date';

/*2*/
SELECT employee_id, last_name, salary, ROUND(salary*1.15)
FROM employees;

/*3*/
SELECT employee_id, last_name, salary, ROUND(salary*1.15), ROUND(salary*1.15)-salary AS 'Increase'
FROM employees;

/*4*/
SELECT CONCAT(UCASE(LEFT(last_name, 1)),LCASE(SUBSTRING(last_name, 2))) AS 'Name' , LENGTH(last_name) AS 'Length'
FROM employees
WHERE last_name LIKE 'A%' OR last_name LIKE 'J%' OR last_name LIKE 'M%';

/*5*/
SELECT last_name, TIMESTAMPDIFF(MONTH, hire_date, CURRENT_DATE) AS 'MONTHS WORKED'
FROM employees
ORDER BY 2;

/*6*/
SELECT CONCAT(first_name, ' earns ', salary, ' monthly but wants ', salary*3) AS 'Dream Salaries'
FROM employees;

/*7*/
SELECT last_name, LPAD(salary, 15, '$') AS 'Salary'
FROM employees;

/*8*/
SELECT DATE_FORMAT(DATE_ADD(DATE_ADD(hire_date, INTERVAL( 9 - DAYOFWEEK('2020-11-30'))DAY), INTERVAL 6 MONTH), "%W %e %M %Y") AS 'REVIEW'
FROM employees;

/*9*/
SELECT last_name, hire_date, DATE_FORMAT(hire_date, '%W') AS 'DAY'
FROM employees
ORDER BY mod(dayofweek(hire_date)+5, 7);

/*10*/
SELECT last_name, IF(commission_pct IS NULL, 'No Commission', commission_pct)
FROM employees;

/*11*/
SELECT CONCAT(last_name, LPAD('*',salary*12/1000, '*')) AS 'EMPLOYEES_AND_THEIR_SALARIES'
FROM employees
ORDER BY salary DESC;

/*12*/
/*DECODE FUNCTION DOES NOT WORK LIKE THE CASE IN JAVA IN MYSQL, THE EQUIVALENT IN MYSQ IS IF(VAR, X, Y)*/
SELECT IF(job_id = 'AD_PRES', 'A', IF(job_id = 'ST_MAN', 'B', IF(job_id = 'IT_PROG', 'C', IF (job_id = 'SA_REP', 'D', IF(job_id = 'ST_CLERK', 'E', '0'))))) AS 'JOB_ID'
FROM employees;

SELECT
CASE
	WHEN job_id = 'AD_PRES' THEN 'A'
    WHEN job_id = 'ST_MAN' THEN 'B'
    WHEN job_id = 'IT_PROG' THEN 'C'
    WHEN job_id = 'SA_REP' THEN 'D'
    WHEN job_id = 'ST_CLERK' THEN 'E'
    ELSE '0'
END AS 'JOB_ID'
FROM employees;