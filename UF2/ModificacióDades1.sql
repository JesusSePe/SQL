START TRANSACTION;
SET autocommit = 0;
/*Ejercicio 1*/
INSERT INTO MY_EMPLOYEE (ID, LAST_NAME, FIRST_NAME, USERID, SALARY) VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);
INSERT INTO MY_EMPLOYEE (ID, LAST_NAME, FIRST_NAME, USERID, SALARY) VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);

/*Ejercicio 1.2*/
INSERT INTO MY_EMPLOYEE (ID,LAST_NAME,FIRST_NAME,SALARY) VALUES (3,'Biri','Ben',1100);
INSERT INTO MY_EMPLOYEE (ID,LAST_NAME,FIRST_NAME,SALARY) VALUES (4,'Newman','Chad',750);
UPDATE MY_EMPLOYEE SET USERID = (select concat(SUBSTRING(first_name, 1, 1),SUBSTRING(last_name, 1, 7))) WHERE ID = 3;
UPDATE MY_EMPLOYEE SET USERID = (select concat(SUBSTRING(first_name, 1, 1),SUBSTRING(last_name, 1, 7))) WHERE ID = 4;

/*Ejercicio 2*/
COMMIT;

/*Ejercicio 3*/
UPDATE MY_EMPLOYEE SET LAST_NAME = 'Drexler' WHERE ID = 3;

/*Ejercicio 4*/
UPDATE MY_EMPLOYEE SET SALARY = 1000 WHERE SALARY <= 900;

/*Ejercicio 5*/
DELETE FROM MY_EMPLOYEE WHERE FIRST_NAME = 'Betty' AND LAST_NAME = 'Dancs';

/*Ejercicio 6*/
select * from MY_EMPLOYEE;

/*Ejercicio 7*/
COMMIT;

/*Ejercicio 8*/
INSERT INTO MY_EMPLOYEE (ID, LAST_NAME, FIRST_NAME, USERID, SALARY) VALUES (5, 'Ropeburn', 'Audrey', 'aropebur', 1550);

/*Ejercicio 9*/
select * from MY_EMPLOYEE;

/*Ejercicio 10*/
savepoint MARCA14;

/*Ejercicio 11*/
DELETE FROM MY_EMPLOYEE;

/*Ejercicio 12*/
ROLLBACK TO MARCA14;

/*Ejercicio 13*/
select * from MY_EMPLOYEE;
commit;
