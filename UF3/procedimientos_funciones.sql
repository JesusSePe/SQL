/*PROCEDIMIENTOS*/
/*Ejercicio 1
Diseña un procedimiento llamado listarNumeros que pasemos como parametro un entero, y el
procedimiento escriba los números desde el 0 al número que has pasado como parámetro.*/
CREATE OR REPLACE PROCEDURE listarNumeros (A IN OUT NUMBER) AS
AUX NUMBER;
BEGIN
    AUX := A;
    FOR i IN 0.. AUX LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

DECLARE
N1 NUMBER :=&numero;
BEGIN
    listarNumeros(N1);
END;
/
/*Ejercicio 2
Diseña un procedimiento llamado DividirNumero que pasemos como parametros d entrada: el dividendo
y el divisor, y como parametros de salida: cociente y resto. Usa este procedimiento en un
programa en el que se divida 18 entre 4, y que muestre por pantalla el dividendo, el dividor, 
el cociente y el resto.*/
CREATE OR REPLACE PROCEDURE DividirNumero (dividendo IN NUMBER, divisor IN NUMBER, cociente OUT
NUMBER, resto OUT NUMBER) AS AUX NUMBER;
BEGIN
    cociente := TRUNC(dividendo/divisor);
    resto := MOD(dividendo, divisor);
    
END;
/

DECLARE
num1 NUMBER :=&numero;
num2 NUMBER :=&numero2;
num3 NUMBER;
num4 NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Dividendo: '||num1);
    DBMS_OUTPUT.PUT_LINE('Divisor: '||num2);
    DividirNumero(num1, num2, num3, num4);
    DBMS_OUTPUT.PUT_
LINE('Cociente: '||num3);
    DBMS_OUTPUT.PUT_LINE('Resto: '||num4);
END;
/

/*FUNCIONES*/
/*Ejercicio 1
Diseña una función que se pasen como parámetros dos números enteros y nos devuelva el mayor de
los dos.*/
CREATE OR REPLACE FUNCTION mayor( A NUMBER, B NUMBER) RETURN NUMBER IS
    NUM1 NUMBER := A;
    NUM2 NUMBER := B;
BEGIN
    IF NUM1 > NUM2 THEN
        RETURN NUM1;
    ELSIF NUM2 > NUM1 THEN
        RETURN NUM2;
    ELSE RETURN NUM1;
    END IF; 
END;
/
DECLARE
num1 NUMBER :=&numero;
num2 NUMBER :=&numero2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('El numero más grande es el '|| mayor(num1, num2));
END;
/

/*Ejercicio 2
Diseña una función a la que se le pasen como parámetros dos números enteros y nos devuelva
verdadero si el primero es multiplo del segundo, o falso en caso contrario. La función MOD (a;b) 
te ayudará ya que devuelve el resto de dividir a entre b.*/
CREATE OR REPLACE FUNCTION multiplo( A NUMBER, B NUMBER) RETURN VARCHAR2 IS
    NUM1 NUMBER := A;
    NUM2 NUMBER := B;
BEGIN
    IF MOD(NUM1, NUM2) = 0 THEN
        RETURN 'VERDADERO';
    ELSE RETURN 'FALSO';
    END IF; 
END;
/
DECLARE
num1 NUMBER :=&numero;
num2 NUMBER :=&numero2;
BEGIN
    DBMS_OUTPUT.PUT_LINE(multiplo(num1, num2));
END;

/*MÁS EJERCICIOS*/
/*Ejercicio 1
Programar un script que nos muestre los números entre un rango. El rango mínimo es 1 y el máximo
se lo tiene que preguntar al usuario. Programar el script utilizando la estructura FOR o la
estructura WHILE.
Este ejercicio se tiene que programar con un procedimiento, de tal manera que muestre los
números entre un rango en este procedimiento. Ayuda: Se tiene que programar dentro del script
un procedimiento que dado el rango mínimo a 1 y el máximo que se le pasa como parámetro al
procedimiento, imprima por pantalla los números que hay entre el rango mínimo y el máximo.
El procedimiento recibirá el nombre de RANGO. Además, al mismo script (EA121_exercici1.sql) se
tiene que programar un bloque principal, que tiene que contener los siguientes aspectos.
Al mismo script se tiene que realizar lo siguiente: preguntar al usuario por el rango máximo.
comprobar que el rango máximo no es negativo. Si es negativo dar el mensaje correspondiente y
acabar el programa. llamar al procedimiento RANGO, pasando como parámetro el rango máximo
introducido por teclado.
*/
CREATE OR REPLACE PROCEDURE RANGO( A IN NUMBER, B IN NUMBER, Z OUT NUMBER) IS
BEGIN
    IF A > B THEN
        DBMS_OUTPUT.PUT_LINE('ERROR. El máximo no puede ser menor que el mínimo.');
    ELSIF B < 0  THEN
        DBMS_OUTPUT.PUT_LINE('ERROR. El máximo no puede ser negativo');
    ELSE 
        Z := A;
        WHILE Z <= B
        LOOP
            DBMS_OUTPUT.PUT_LINE(Z);
            Z := Z + 1;
        END LOOP;
    END IF; 
END;
/
DECLARE
num1 NUMBER :=&numero;
num2 NUMBER :=&numero2;
num3 NUMBER :=0;
BEGIN
    RANGO(num1, num2, num3);
END;
/
/*Ejercicio 2
Programar un script (EA121_exercici2.sql) que contenga una función que duplique la cantidad
recibida como parámetro. La función recibirá el nombre de DUPLICAR_CANTIDAD. Al mismo script se
tiene que programa un bloque principal que pida por teclado la cantidad y que llame a la función
que se acaba de programar, pasando el parámetro correspondiente.*/
CREATE OR REPLACE FUNCTION DUPLICAR_CANTIDAD( A NUMBER) RETURN NUMBER IS
    NUM1 NUMBER := A;
BEGIN
    RETURN A*2;
END;
/
DECLARE
num1 NUMBER :=&numero;
BEGIN
    DBMS_OUTPUT.PUT_LINE(DUPLICAR_CANTIDAD(num1));
END;

/*Ejercicio 3
Programar un script (exercici3.sql) que contenga un procedimiento que dé de alta un nuevo oficio
(puesto de trabajo). Los datos del nuevo oficio se tienen que introducir por teclado. Antes de 
insertar se tiene que comprobar que el valor mínimo y máximo del oficio no sea negativo y además,
que el salario mínimo sea más pequeño que el máximo.
*/
CREATE OR REPLACE PROCEDURE insertar( v_JOB_ID IN VARCHAR2, v_JOB_TITLE IN VARCHAR2, v_MIN_SAL IN NUMBER, v_MAX_SAL IN NUMBER) IS
BEGIN
    IF v_MIN_SAL > v_MAX_SAL THEN
        DBMS_OUTPUT.PUT_LINE('ERROR. El mínimo no puede ser mayor que el máximo.');
    ELSIF v_MIN_SAL < 0  THEN
        DBMS_OUTPUT.PUT_LINE('ERROR. El salario minimo no puede ser negativo');
    ELSE 
        INSERT INTO JOBS
        (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
        VALUES
        (v_JOB_ID, v_job_title, v_min_sal, v_max_sal);
    END IF; 
END;
/
DECLARE
job_id VARCHAR2(10) :=&job_id;
job_title VARCHAR2(35) :=&job_title;
min_sal NUMBER(6, 0) :=&min_sal;
max_sal NUMBER(6, 0) :=&max_sal;
BEGIN
    insertar(job_id, job_title, min_sal, max_sal);
END;
/

/*Ejercicio 4
Programar un script (exercici4.sql) un procedimiento que dé de baja un oficio. El código del
oficio se tiene que introducir por teclado.*/
CREATE OR REPLACE PROCEDURE eliminar( v_JOB_ID IN VARCHAR2) IS
BEGIN
    DELETE FROM JOBS
    WHERE JOB_ID = v_job_id;
END;
/
DECLARE
job_id VARCHAR2(10) :=&job_id;
BEGIN
    eliminar(job_id);
END;
/

/*Ejercicio 5
Programar un script (exercici5.sql) que contenga una función que devuelva cuántos empleados hay
de un departamento, que se pasará por parámetro a la función. La función llamada CONTAR, se
llamará desde un bloque anónimo o principal y el parámetro que se le pasa a la función se le
preguntará al usuario y por tanto, se tiene que introducir por teclado.*/
CREATE OR REPLACE FUNCTION contarEmp( v_dep IN VARCHAR2) RETURN NUMBER AS
emp NUMBER;
BEGIN
    SELECT COUNT(*) INTO emp
    FROM EMPLOYEES e
    INNER JOIN DEPARTMENTS dep ON e.department_id = dep.department_id
    WHERE dep.DEPARTMENT_NAME = v_dep;
    RETURN emp;
END;
/
DECLARE
v_dep VARCHAR2(10) :=&department;
BEGIN
    DBMS_OUTPUT.PUT_LINE(contarEmp(v_dep));
END;
/
