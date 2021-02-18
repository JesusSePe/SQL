/*##########
Ejercicios 2
##########*/
/*Ejercicio 1*/
START TRANSACTION;
SET autocommit = 0;

/*Ejercicio 2*/
INSERT INTO departments VALUES (300, 'Finance', 110, 1800);
select * from departments where department_id = 300;
COMMIT;

/*Ejercicio 3*/
INSERT INTO departments VALUES (400, 'Finances2', 389, 1800);
/*Aquesta operació dona error ja que no hi ha cap empleat amb la ID 389*/

/*Ejercicio 4*/
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, manager_id, department_id) VALUES (401, 'Jose', 'Company', 'prova@prova.com', NOW(), 'SA_MAN', 1600, 100, 80);

/*Ejercicio 5*/
DELETE FROM employees WHERE employee_id = 401;
select * from employees where employee_id = 401;

/*Ejercicio 6*/
Create table test (
id numeric(6) primary key,
name varchar(20),
hire_date date,
salary numeric(8,2));

/*Ejercicio 7*/
INSERT INTO test SELECT employee_id, concat(first_name, last_name), hire_date, salary FROM employees WHERE department_id = 50;

/*Ejercicio 8*/
INSERT INTO test VALUES (390, 'Julio', '1999-09-10', 2500);

/*Ejercicio 9*/
INSERT INTO test SELECT employee_id, concat(first_name, last_name), hire_date, salary FROM employees WHERE department_id = 90;

/*Ejercicio 10*/
DELETE FROM test;
COMMIT;

/*Ejercicio 11*/
INSERT INTO test SELECT employee_id, concat(first_name, last_name), hire_date, salary FROM (select min(salary) AS 'minSalary', department_id from employees group by department_id) as min LEFT JOIN employees as emp ON min.minSalary = emp.salary AND min.department_id = emp.department_id WHERE salary is not null;

/*Ejercicio 12*/
UPDATE test SET salary = 5000 WHERE id = 200;

/*Ejercicio 13*/
UPDATE test SET salary = (select salary * 1.3);

/*Ejercicio 14*/
UPDATE test SET hire_date = (select DATE_ADD(hire_date, INTERVAL 12 MONTH));

/*Ejercicio 15*/
UPDATE employees SET department_id = 100 WHERE employee_id = 105;

/*Ejercicio 16*/
UPDATE test SET name = (select name where id=100) AND salary = (select salary where id=100) WHERE id=107;

/*Ejercicio 17*/
UPDATE employees SET department_id = (select department_id where employee_id=109) AND salary = (select max(salary) where department_id = (select department_id where employee_id=109)) WHERE employee_id=107;
UPDATE employees SET department_id = (select department_id where employee_id=107) AND salary = (select max(salary) where department_id = (select department_id where employee_id=107)) WHERE employee_id=109;

/*Ejercicio 18*/
insert into employees (employee_id, last_name, email, job_id)values (800, 'Lopez','lopez@hotmail.com', 'SA_PAT');
/*Da un error diciendo que el campo hire_date no tiene un valor, pero no se ha especificado en la sentencia. Esto se puede deber a que el campo sea obligatorio (not null)*/

/*Ejercicio 19*/
insert into employees (employee_id, last_name, email, hire_date,job_id)values (800,'Lopez', 'lopez@hotmail.com',sysdate, 'SA_PAT');
/*Da un error diciendo que el valor sysdate no coincide con el tipo de campo de hire_date (date). Eso se debe a que sysdate es una función, y le faltan los parentesis, debiera ser sysdate()*/

/*Ejercicio 20*/
Update employeesset commission_pct=300where employee_id=100;
/*Da un error de sintaxis, ya que employees y set están juntos, lo mismo pasa con 300 y where. A demás, el valor de commission_pct debe ser máximo 1.*/

/*Ejercicio 21*/
Create table jobs2 as select * from jobs;
desc jobs2;

/*Ejercicio 22*/
/*Actualizar el salario mínimo de la tabla de jobs2 para que sea igual al salario máximo multiplicado por 0,75 para todos aquellos trabajos cuyo nombre comience por A.*/
UPDATE jobs2 SET min_salary = (select max_salary * 0.75) WHERE job_title like 'A%';

/*Ejercicio 23*/
DELETE FROM jobs2 WHERE job_title = 'Sales Manager';

/*Ejercicio 24*/
DELETE FROM jobs2 WHERE min_salary * 1.7 < max_salary;

/*Ejercicio 25*/
Create table countries2 as select * from countries;
DELETE FROM countries2 WHERE region_id = (select region_id where country_name = 'Australia');

/*Ejercicio 26*/
/*Borrar de la tabla region el continente 3, region_id=3 y decirme si funciona o no funciona, y por que no*/
DELETE FROM regions WHERE region_id = 3;
/*No se puede borrar, ya que hay elementos que hacen referencia a estos datos.*/

/*Ejercicio 27*/
/*Clonando los datos que quiero en una tabla temporal, hacer truncate a la original, e insertar de nuevo los datos desde la tabla temporal.*/

/*Ejercicio 28*/
COMMIT;
