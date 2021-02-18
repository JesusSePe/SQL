/*Ejercicio 1*/
SET SERVEROUTPUT ON
DECLARE
NOMBRE VARCHAR2(20);
BEGIN
NOMBRE:=&NOMBRE;
DBMS_OUTPUT.PUT_LINE ('Hola '||NOMBRE);
END;

/*Ejercicio 2*/
SET SERVEROUTPUT ON
DECLARE
VAR1 INT;
VAR2 INT;
BEGIN
VAR1:=&VAR1;
VAR2:=&VAR2;
DBMS_OUTPUT.PUT_LINE ('Suma: '||TO_CHAR(VAR1+VAR2)||' Resta: '||TO_CHAR(VAR1-VAR2)||' Multiplicación: '||VAR1*VAR2||' División: '||VAR1/VAR2);
END;

/*Ejercicio 3*/
SET SERVEROUTPUT ON
DECLARE
VAR1 INT;
BEGIN
VAR1:=&VAR1;
DBMS_OUTPUT.PUT_LINE ('Potencia 10: '||VAR1**10);
END;

/*Ejercicio 4*/
DECLARE
      fecha Date;
BEGIN
     SELECT TO_CHAR(SYSDATE) INTO fecha FROM DUAL ;
     DBMS_OUTPUT.PUT_LINE('Hoy es ' || fecha);
END;
