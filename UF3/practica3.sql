/*Realizar un bloque anónimo, que visualice todos los códigos de los productos al revés. Mostrar
dos columnas, una con el código bien y otra con el código al revés.
Ejemplo: HJ4RR5 | 5RR4JH*/
SET SERVEROUTPUT ON
DECLARE
    v_product VARCHAR2(30);
    len NUMBER;
    CURSOR c_codes IS SELECT codigo_producto FROM producto;
BEGIN
    OPEN c_codes;
    LOOP
        FETCH c_codes INTO v_product;
        len := Length(v_product);
        FOR i IN REVERSE 1.. len LOOP
            v_product := v_product || Substr(v_product, i, 1);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(Substr(v_product, 0, len)|| ' | ' || Substr(v_product, len+1, (len+1)*2));
        EXIT WHEN c_codes%NOTFOUND;
    END LOOP;
END;
