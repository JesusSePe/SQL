/*Actividad 6.3*/
SET SERVEROUTPUT ON
DECLARE
VAR1 INT;
VAR2 INT;
BEGIN
VAR1:=&VAR1;
VAR2:=&VAR2;
IF VAR1>VAR2 THEN
    DBMS_OUTPUT.PUT_LINE('El número más grande es: '||VAR1);
ELSE
    DBMS_OUTPUT.PUT_LINE('El número más grande es: '||VAR2);
END IF;
END;

/*Actividad 6.4*/
SET SERVEROUTPUT ON
DECLARE
E_LOCAL INT;
E_VISIT INT;
Quini VARCHAR2(1);
BEGIN
E_LOCAL:=&E_LOCAL;
E_VISIT:=&E_VISIT;
IF E_LOCAL>E_VISIT THEN
    Quini:='1';
ELSIF E_LOCAL<E_VISIT THEN
    Quini:='2';
ELSE
    Quini:='X';
END IF;
DBMS_OUTPUT.PUT_LINE ('Goles de casa: '||E_LOCAL||' Goles de fuera: '||E_VISIT||' Signo de Quiniela'||Quini);
END;

/*Actividad 6.5 v1*/
SET SERVEROUTPUT ON
DECLARE
NUM1 INT;
NUM2 INT;
OPER INT;
BEGIN
NUM1:=&NUM1;
NUM2:=&NUM2;
OPER:=&OPER;
IF OPER = 1 THEN
    DBMS_OUTPUT.PUT_LINE (NUM1||' + '||NUM2||' = '||NUM1+NUM2);
ELSIF OPER = 2 THEN
    DBMS_OUTPUT.PUT_LINE (NUM1||' - '||NUM2||' = '||NUM1-NUM2);
ELSIF OPER = 3 THEN
    DBMS_OUTPUT.PUT_LINE (NUM1||' x '||NUM2||' = '||NUM1*NUM2);
ELSE
    DBMS_OUTPUT.PUT_LINE ('Error operación no permitida');
END IF;
END;


/*Actividad 6.5 v2*/
SET SERVEROUTPUT ON
DECLARE
NUM1 INT;
NUM2 INT;
OPER INT;
BEGIN
NUM1:=&NUM1;
NUM2:=&NUM2;
OPER:=&OPER;
CASE OPER
WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE (NUM1||' + '||NUM2||' = '||NUM1+NUM2);
WHEN 2 THEN
    DBMS_OUTPUT.PUT_LINE (NUM1||' - '||NUM2||' = '||NUM1-NUM2);
WHEN 3 THEN
    DBMS_OUTPUT.PUT_LINE (NUM1||' x '||NUM2||' = '||NUM1*NUM2);
ELSE
    DBMS_OUTPUT.PUT_LINE ('Error operación no permitida');
END CASE;
END;

/*Actividad 6.6 v1*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
BEGIN
    WHILE (NUMERO<100)
    LOOP
        IF (MOD(NUMERO, 2)) = 0 THEN
            DBMS_OUTPUT.PUT_LINE (NUMERO);
        END IF;
        NUMERO := NUMERO+1;
    END LOOP;     
END;

/*Actividad 6.6 v2*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
BEGIN
    FOR NUMERO IN 1..99
    LOOP
        IF (MOD(NUMERO, 2)) = 0 THEN
            DBMS_OUTPUT.PUT_LINE (NUMERO);
        END IF;
    END LOOP;     
END;

/*Actividad 6.6 v3*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
BEGIN
    LOOP
        IF (MOD(NUMERO, 2)) = 0 THEN
            DBMS_OUTPUT.PUT_LINE (NUMERO);
        END IF;
    EXIT WHEN NUMERO=98;
    NUMERO:=NUMERO+1;
    END LOOP;     
END;

/*Actividad 6.7 v1*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
    NUMERO2 INT := 1;
BEGIN
    WHILE (NUMERO<100)
    LOOP
        IF (MOD(NUMERO, 2)) = 0 THEN
            WHILE (NUMERO2<100)
            LOOP
                IF (MOD(NUMERO2, 2)) = 0 THEN
                    DBMS_OUTPUT.PUT_LINE (NUMERO||' + '||NUMERO2||' = '||TO_CHAR(NUMERO+NUMERO2));
                END IF;
                NUMERO2 := NUMERO2+1;
            END LOOP;
            NUMERO2 := 1;
        END IF;
        NUMERO := NUMERO+1;
    END LOOP;     
END;

/*Actividad 6.7 v2*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
    NUMERO2 INT := 1;
BEGIN
    FOR NUMERO IN 1..99
    LOOP
        IF (MOD(NUMERO, 2)) = 0 THEN
            FOR NUMERO2 IN 1..99
            LOOP
                IF (MOD(NUMERO2, 2)) = 0 THEN
                    DBMS_OUTPUT.PUT_LINE (NUMERO||' + '||NUMERO2||' = '||TO_CHAR(NUMERO+NUMERO2));
                END IF;
            END LOOP;
            NUMERO2 := 1;
        END IF;
    END LOOP;     
END;

/*Actividad 6.7 v3*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
    NUMERO2 INT := 1;
BEGIN
    LOOP
        IF (MOD(NUMERO, 2)) = 0 THEN
            LOOP
                IF (MOD(NUMERO2, 2)) = 0 THEN
                    DBMS_OUTPUT.PUT_LINE (NUMERO||' + '||NUMERO2||' = '||TO_CHAR(NUMERO+NUMERO2));
                END IF;
            EXIT WHEN NUMERO2=98;
            NUMERO2:=NUMERO2+1;
            END LOOP;
            NUMERO2 := 1;
        END IF;
    EXIT WHEN NUMERO=98;
    NUMERO:=NUMERO+1;
    END LOOP;     
END;

/*Actividad 6.8 v1*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
    NUMERO2 INT := 1;
BEGIN
    WHILE (NUMERO<11)
    LOOP
    WHILE (NUMERO2<11)
        LOOP
            DBMS_OUTPUT.PUT_LINE (NUMERO||' * '||NUMERO2||' = '||TO_CHAR(NUMERO*NUMERO2));
            NUMERO2 := NUMERO2+1;
        END LOOP;
        NUMERO2 := 1;
    NUMERO := NUMERO+1;
    END LOOP;     
END;

/*Actividad 6.8 v2*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
    NUMERO2 INT := 1;
BEGIN
    FOR NUMERO IN 1..10
    LOOP
        FOR NUMERO2 IN 1..10
        LOOP
            DBMS_OUTPUT.PUT_LINE (NUMERO||' * '||NUMERO2||' = '||TO_CHAR(NUMERO*NUMERO2));
        END LOOP;
        NUMERO2 := 1;
    END LOOP;     
END;

/*Actividad 6.8 v3*/
SET SERVEROUTPUT ON
DECLARE
    NUMERO INT := 1;
    NUMERO2 INT := 1;
BEGIN
    LOOP
        LOOP
            DBMS_OUTPUT.PUT_LINE (NUMERO||' * '||NUMERO2||' = '||TO_CHAR(NUMERO*NUMERO2));
            EXIT WHEN NUMERO2=10;
            NUMERO2:=NUMERO2+1;
        END LOOP;
        NUMERO2 := 1;
        EXIT WHEN NUMERO=10;
        NUMERO:=NUMERO+1;
    END LOOP;     
END;
