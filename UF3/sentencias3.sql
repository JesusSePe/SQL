/*Crea un bloc anònim amb variables no PL/SQL que mostri el nom del departament al que pertany l'empleada Pat Fay*/
SET SERVEROUTPUT ON

DECLARE
    v_departament VARCHAR2(20);
BEGIN
    SELECT DEPARTMENT_NAME
    INTO v_departament
    FROM DEPARTMENTS
    WHERE department_id IN (SELECT department_id
                            FROM EMPLOYEES
                            WHERE first_name='Pat' AND last_name='Fay');
    DBMS_OUTPUT.PUT_LINE(v_departament);                        
END;

/*Crea un bloc anònim amb variables no PL/SQL que demani a l'usuari el seu id, i que retorni a quina regió pertany.*/
SET SERVEROUTPUT ON

DECLARE
    v_region VARCHAR2(20);
    v_id NUMBER(3);
BEGIN
v_id:=&v_id;
    SELECT UNIQUE(re.region_id)
    INTO v_region
    FROM countries co
    INNER JOIN regions re ON co.region_id = re.region_id
    INNER JOIN locations loc ON co.country_id = loc.country_id
    WHERE loc.country_id =  (SELECT country_id 
                            FROM departments dep
                            INNER JOIN employees emp ON dep.department_id = emp.department_id
                            INNER JOIN locations loc ON dep.location_id = loc.location_id
                            WHERE emp.employee_id = v_id);
    DBMS_OUTPUT.PUT_LINE(v_region);                        
END;

/*Crea un bloc anònim amb una variable de tipus alfanumèric. El resultat és que ha de mostrar per pantalla:
HOLA MUNDO
FIN DEL PROGRAMA*/
SET SERVEROUTPUT ON

DECLARE
v_alfa VARCHAR2(999);
BEGIN
v_alfa:=&Some_text;
DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
DBMS_OUTPUT.PUT_LINE('FIN DEL PROGRAMA');
END;


/*Crea un bloc anònim amb dos variables de tipus NUMBER. Aquestes variables s'ha de tenir un
valor inicial de 10.2 i 20.1 respectivament. El bloc ha de sumar aquestes dues variables i 
mostrar per pantalla 'LA SUMA TOTAL ÉS: 30.3'*/
SET SERVEROUTPUT ON
DECLARE
v_num1 NUMBER(3,1):=10.2;
v_num2 NUMBER(3,1):=20.1;
BEGIN
DBMS_OUTPUT.PUT_LINE('LA SUMA TOTAL ÉS: '||TO_CHAR(v_num1+v_num2));
END;

/*Crea un bloc anònim que ha de llistar tots els noms (FIRST_NAME) dels empleats de la taula
(EMPLOYEES) en majúscules, on has de declarar una variable de tipus first_name*/
SET SERVEROUTPUT ON
DECLARE
CURSOR c_name IS SELECT UPPER(first_name) FROM employees;
v_name VARCHAR(20);
BEGIN
OPEN c_name;
LOOP 
    FETCH c_name INTO v_name;
    DBMS_OUTPUT.PUT_LINE(v_name);
    EXIT WHEN c_name%NOTFOUND;
END LOOP;
END;

/*Crea un bloc anònim que contingui una variable constant anomenada Percentatge amb un valor
de 10. Aquest valor és un 10%. Aquest bloc ha de contenir una variable de tipus rowtype, de
la taula employees. Dins aquest bloc, augmentares el sou a l'empleat que introdueixi un usuari
i mostrarà per pantalla el següent:
<<S'ha realitzat un augment de sou a:
L'usuari amb id: id_usuari
L'usuari amb Nom: first_name i cognom last_name que pertany al departament departmnet_name.
El salari inicial era: salary i ara el nou salari és salary*1.10>>*/

SET SERVEROUTPUT ON
DECLARE
v_id NUMBER(3);
v_name VARCHAR(20);
v_last_name VARCHAR(25);
v_department VARCHAR(30);
v_salary NUMBER(8,2);
BEGIN
v_id:=&v_id;
SELECT first_name, last_name, department_name, salary
INTO v_name, v_last_name, v_department, v_salary
FROM employees emp
INNER JOIN departments dep ON emp.department_id = dep.department_id
WHERE employee_id=v_id;

UPDATE employees
SET salary = salary*1.10
WHERE employee_id = v_id;
DBMS_OUTPUT.PUT_LINE('Se ha realitzat un augment de sou a:');
DBMS_OUTPUT.PUT_LINE('El usuari amb id: '||v_id);
DBMS_OUTPUT.PUT_LINE('Elusuari amb Nom: '||v_name||' i cognom '||v_last_name||' que pertany al departament '||v_department);
DBMS_OUTPUT.PUT_LINE('El salari inicial era: '||v_salary||' i ara el nou salari és '||v_salary*1.10);
END;

/*##################*/
/*##PLSQL ECONTROL##*/
/*##################*/
/*Programar un script que ens pregunti pel nom, cognom i edat d'una persona.
Posteriorment, s'ha d'imprimir les dades corresponents a la persona. No s'ha de
d'oblidar de netejar les variables quan s'acabi el bloc PL/SQL, fent us de la comanda
UNDEFINE <nom_variable>*/
SET SERVEROUTPUT ON
DECLARE
    v_name VARCHAR2(20):=&name;
    v_last_name VARCHAR2(30):=&last_name;
    v_age INT:=&age;
BEGIN
    DBMS_OUTPUT.PUT_LINE('La persona con nombre '||v_name||' y apellido '||v_last_name||' tiene '||v_age||' años.');
END;
/*Por más que he intentado usar los comandos define y undefine, no he sido capaz de hacerlo sin errores.*/

/*Calcular el 18% d'un preu que introdueix per teclat. Mostrar el resutlat amb una variables de
HOST o no PL/SQL. Printar el resultat REDONDEJAT dent ús d'aquesta variable no PL/SQL i no declarar
cap variable de programa.*/
SET SERVEROUTPUT ON
DECLARE
    v_input INT :=&input;
BEGIN
    DBMS_OUTPUT.PUT_LINE('El 18% es: '||ROUND(v_input*18/100, 0));
END;


/*Calcular el 18% d'un preu que introdueix per teclat. Imprimir el resultat REDONDEJAT dins del
programa*/
SET SERVEROUTPUT ON
BEGIN
    v_input :=&input;
    DBMS_OUTPUT.PUT_LINE('El 18% es: '||ROUND(v_input*18/100, 0));
END;

/*Preguntar a l'usuari el salari i la comisió que guanya*/
SET SERVEROUTPUT ON
DECLARE
    v_com NUMBER(3,2);
    v_sal INT;
BEGIN
    v_sal:=&salary;
    CASE 
        WHEN v_sal < 100 THEN
            v_com:=0.1;
        WHEN v_sal >= 100 AND v_sal < 500 THEN
            v_com:=0.15;
        ELSE
            v_com:=0.2;
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Un salari de '||v_sal||'€ té una comissió de '||v_sal*v_com||'€');
END;

/*Preguntar a l'usuari la seva edat i donar el missatge corresponent.*/
SET SERVEROUTPUT ON
DECLARE
    v_age INT;
    v_message VARCHAR2(75);
BEGIN
    v_age:=&edad;
    CASE 
        WHEN v_age < 0 THEN
            v_message:='Error. La edat no pot ser negativa';
        WHEN v_age < 18 THEN
            v_message:='Ets menor de edat!';
        WHEN v_age = 18 THEN
            v_message:='Casi ets major de edat!';
        WHEN v_age > 18 AND v_age <= 40 THEN
            v_message:='Ja ets major de edat!';
        WHEN v_age > 40 THEN
            v_message:='Ets viejoven!';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_message);
END;

/*Programar un script que demani un número i el programa ha de realitzar les següents
operacions amb aquest número. Les operacions han de ser independets.*/
SET SERVEROUTPUT ON
DECLARE
    v_num INT;
    v_suma INT;
    v_resta INT;
    v_multiplicar INT;
BEGIN
    v_num:=&number;
    v_suma:=v_num+4;
    v_resta:=v_num-3;
    v_multiplicar:=v_num*8;
    DBMS_OUTPUT.PUT_LINE('Suma: '||v_suma);
    DBMS_OUTPUT.PUT_LINE('Resta: '||v_resta);
    DBMS_OUTPUT.PUT_LINE('Multiplicació: '||v_multiplicar);
END;

/*Programar un script en PL/SQL que demani a l'usuari el valor de dos números. 
Aquest dos números se li assigna dos variables PL/SQL (en el moment de la declaració). Els
dos números han de ser positius, en cas contrari s'ha de donar a l'usuari el missatge
corresponent.
S'ha de realitzar una operació amb aquests números: dividir entre ells i sumar-li el segon.
El resultat s'ha d'assignar a una variable NO PL/SQL i després imprimir-la (fora del bloc PL/SQL)
per a comprovar que la operació ha estat correcta.*/

SET SERVEROUTPUT ON
DECLARE
    v_num1 INT;
    v_num2 INT;
    v_mess VARCHAR2(50);
BEGIN
    v_num1:=&number1;
    v_num2:=&number2;
    CASE
        WHEN v_num1 < 0 THEN
            v_mess:='Num1 es negatiu';
        WHEN v_num2 < 0 THEN
            v_mess:='Num2 es negatiu';

/*Mateix exercici que el 7, però ara també s'ha de controlar que el número primer sigui més
gran que el segón. En cas contrari ha de donar el següent missatge: Error! el primer número
ha de ser més gran que el segón.*/

SET SERVEROUTPUT ON
DECLARE
    v_num1 INT;
    v_num2 INT;
    v_mess VARCHAR2(50);
BEGIN
    v_num1:=&number1;
    v_num2:=&number2;
    CASE
        WHEN v_num1 < 0 THEN
            v_mess:='Num1 es negatiu';
        WHEN v_num2 < 0 THEN
            v_mess:='Num2 es negatiu';
        WHEN v_num1 < v_num2 THEN
            v_mess:='Error! El primer número ha de ser més gran que el segón.';
        ELSE
            v_mess:=((v_num1/v_num2)+v_num2);
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_mess);
END;

/*Programar un script que ens mostri els números entre un rang amb un salt. Tant el  rang mínim
es 1 i el màxim se li ha de preguntar a l'usuari.*/

SET SERVEROUTPUT ON
DECLARE
    v_min INT;
    v_max INT;
BEGIN
    v_min:=&min;
    v_max:=&max;
    FOR v_num IN v_min..v_max
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_num);
    END LOOP;
END;

SET SERVEROUTPUT ON
DECLARE
    v_min INT;
    v_max INT;
BEGIN
    v_min:=&min;
    v_max:=&max;
    WHILE v_min <= v_max
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_min);
        v_min := v_min+1;
    END LOOP;
END;


/*Programar un script que ens mostri els números entre un rang amb un salt. Tant el rang mínim,
com el màxim i el salt se li ha de preguntar a l'usuari. A més, s'ha de tenir en compte que el
rang mínim sempre ha de ser més petit que el rang màxim i que el salt no ha de ser negatiu. En 
cas contrari s'ha de donar el missatge corresponent i acabar el programa.*/

SET SERVEROUTPUT ON
DECLARE
    v_min INT;
    v_max INT;
    v_step INT;
    ex_bad_max EXCEPTION;
    ex_bad_step EXCEPTION;
BEGIN
    v_min:=&min;
    v_max:=&max;
    v_step:=&step;
    CASE
        WHEN v_max < v_min THEN
            RAISE ex_bad_max;
        WHEN v_step < 1 THEN
            RAISE ex_bad_step;
        ELSE
            WHILE v_min <= v_max
            LOOP
                DBMS_OUTPUT.PUT_LINE(v_min);
                v_min := v_min+v_step;
            END LOOP;
    END CASE;
    
EXCEPTION
    WHEN ex_bad_max THEN
        DBMS_OUTPUT.PUT_LINE('El máximo no puede ser inferior al mínimo');
    WHEN ex_bad_step THEN
        DBMS_OUTPUT.PUT_LINE('El paso no puede ser menor de 1');
END;
        ELSE
            v_mess:=((v_num1/v_num2)+v_num2);
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_mess);
END;

