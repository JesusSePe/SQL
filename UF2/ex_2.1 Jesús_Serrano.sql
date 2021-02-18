/*1*/

SELECT *
FROM jobs
WHERE min_salary > 10000;

/*2*/
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1993-01-01' AND '1998-12-30';

/*3*/
SELECT first_name, hire_date, job_id
FROM employees
WHERE job_id = 'IT_PROG' or job_id = 'SA_MAN';

/*4*/
SELECT *
FROM employees
WHERE hire_date > '1999-01-01';

/*5*/
SELECT employee_id, first_name, last_name
FROM employees
WHERE employee_id IN (150, 160);

/*6*/
SELECT last_name, salary, commission_pct, hire_date
FROM employees
WHERE salary <10000;

/*7*/
SELECT job_title, (max_salary - min_salary) AS DIFFERENCE
FROM jobs
WHERE max_salary BETWEEN '10000' AND '20000';

/*8*/
SELECT *
FROM jobs
ORDER BY job_title DESC;

/*9*/
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'S%' or last_name LIKE 'S%';

/*10*/
SELECT *
FROM employees
WHERE commission_pct IS NULL AND department_id = 30 AND salary BETWEEN 5000 AND 10000 ;
