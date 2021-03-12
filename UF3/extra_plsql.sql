/*Crea la taula aportacions amb les columnes nif i txt_import*/
CREATE TABLE aportacions (
    nif VARCHAR2(15),
    txt_import VARCHAR2(15)
);

/*Crea i executa un script amb els inserts necessaris èr carregar la taula aportacions amb les dades del full de càlcul aportacions.ods*/
insert into aportacions (nif, txt_import) values ('32741518Y', '88.97');
insert into aportacions (nif, txt_import) values ('45961200R', '0');
insert into aportacions (nif, txt_import) values ('60504319J', '69,79');
insert into aportacions (nif, txt_import) values ('86749552S', '91.02');
insert into aportacions (nif, txt_import) values ('44532705J', '165.84');
insert into aportacions (nif, txt_import) values ('61710332K', '162.69');
insert into aportacions (nif, txt_import) values ('79609198B', '102.8');
insert into aportacions (nif, txt_import) values ('P37805292', '98.34');
insert into aportacions (nif, txt_import) values ('8061823R', '164.79');
insert into aportacions (nif, txt_import) values ('23572170E', '54.45');
insert into aportacions (nif, txt_import) values ('55642799A', '108.28');
insert into aportacions (nif, txt_import) values ('29186271F', '111.15');
insert into aportacions (nif, txt_import) values ('14743546V', '83.19');
insert into aportacions (nif, txt_import) values ('78398573Z', '71.96');
insert into aportacions (nif, txt_import) values ('69046315Q', '100.53');
insert into aportacions (nif, txt_import) values ('17643905F', '101.77');
insert into aportacions (nif, txt_import) values ('77611141D', '-61.7');
insert into aportacions (nif, txt_import) values ('81331762J', '149.02');
insert into aportacions (nif, txt_import) values ('12947666T', '0');
insert into aportacions (nif, txt_import) values ('83836853J', '72.78');


/*Crea la funció de BD validar_import amb paràmetres:
    · txt_import: Text a validar com a import positiu
    · -> Retorna la conversió a número de txt_import. En cas de que txt_no sigui un import o no sigui positiu, retorna -1*/
    
CREATE OR REPLACE FUNCTION validar_import(text_import IN VARCHAR2) RETURN NUMBER AS
v_val NUMBER;
negative_number EXCEPTION;
BEGIN
    IF (VALIDATE_CONVERSION(text_import AS NUMBER) = 1) THEN
        v_val := TO_NUMBER(TEXT_IMPORT);
    ELSE 
        v_val := -1;
        RETURN v_val;
    END IF;
    IF v_val < 0 THEN
        v_val := -1;
        RETURN v_val;
    ELSE 
        RETURN v_val;
    END IF;
    /*
    v_val := TO_NUMBER(text_import);
    IF v_val < 0 THEN
        RAISE NEGATIVE_NUMBER;
    END IF;
    RETURN (v_val);
EXCEPTION
    WHEN VALUE_ERROR THEN
        v_val := -1;
        RETURN v_val;
    WHEN NEGATIVE_NUMBER THEN
        v_val := -1;
        RETURN v_val;
*/
END;
/
DECLARE
text_import VARCHAR2(30):=&Import;
BEGIN
    DBMS_OUTPUT.PUT_LINE(validar_import(text_import));
END;

/*Crea la funció de BD validar_nif amb paràmetres:
    · nif: Text a validar com a NIF
    · -> Retorna 1 si el nif es vàlid i -1 en cas contrari*/
CREATE OR REPLACE FUNCTION validar_nif(nif IN VARCHAR2) RETURN NUMBER AS
    v_val NUMBER;
    v_num NUMBER;
    v_letter VARCHAR2(1);
    TYPE lettersarray IS VARRAY(23) OF VARCHAR2(1);
    letters lettersarray;
BEGIN
    letters := lettersarray('T', 'R', 'W', 'A', 'G', 'M', 'Y', 'F', 'P', 'D', 'X', 'B', 'N', 'J', 'Z', 'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E');
    IF (LENGTH(nif) = 9) THEN
        v_val := 1;
    ELSE 
        v_val := -1;
        RETURN v_val;
    END IF;
    v_letter := LTRIM(nif, '0123456789');
    v_num := RTRIM(nif, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    FOR i in 0..22 LOOP
        IF (i = (MOD(v_num, 23))) AND (v_letter = letters(i+1)) THEN
            RETURN v_val;
        END IF;
    END LOOP;
    v_val := -1;
    RETURN v_val;
END;
/
DECLARE
v_nif VARCHAR2(9):=&NIF;
BEGIN
    DBMS_OUTPUT.PUT_LINE(validar_nif(v_nif));
END;    
/
/*Crea una consulta sobre la taula aportacions que, fent servir les dues funcions anteriors, trobi només les files amb algun error en les validacions i que retorni les columnes:
    · nif
    · txt_import
    · txt_error: un text amb els errors. Pot ser:
        ·NIF incorrecte
        ·Import incorrecte
        ·NIF i import incorrectes*/
DECLARE
    CURSOR c_apo IS SELECT nif, txt_import FROM aportacions;
    v_apo aportacions%ROWTYPE;
    v_msg VARCHAR2(20):= '';
    v_res NUMBER;
    v_check NUMBER := 0;
BEGIN
    OPEN c_apo;
    LOOP
        FETCH c_apo INTO v_apo;
        EXIT WHEN c_apo%NOTFOUND;
        /*Check aportacion*/
        v_res := validar_import(v_apo.txt_import);
        IF v_res = -1 THEN
            v_check := 1;
        END IF;
        v_res := validar_nif(v_apo.nif);
        IF (v_res = -1) AND (v_check != 1) THEN
            v_check := 2;
        ELSE IF (v_res = -1) AND (v_check = 1) THEN
            v_check := 3;
        END IF;
        END IF;
        IF v_check = 1 THEN v_msg := 'NIF incorrecte';
        ELSE IF v_check = 2 THEN v_msg := 'Import incorrecte';
        ELSE IF v_check = 3 THEN v_msg := 'NIF i import incorrectes';
        END IF;
        END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE('NIF: '|| v_apo.nif || ' Import: '|| v_apo.txt_import || '       ' ||v_msg);
        v_msg := '';
        v_check := 0;
    END LOOP;
END;
/

/*2. Inserir files amb valors aleatoris

2.1. Crea la taula empleats amb les columnes següents
    · id_emp. Emter de 6 posicions. Clau primària
    · nom. Text 15 caràcters.
    · cognoms. Text de 40 caràcters. Obligatòria.
    · data_contracte. Data. Truncada amb precisió de díes.
    · salari. Import amb dos decimals i valor máxim immediatament inferior a 1 milió.*/
    
CREATE TABLE empleats (
    id_emp INT,
    nom VARCHAR2(15),
    cognoms VARCHAR2(40) NOT NULL,
    data_contracte DATE,
    salary NUMBER(8,2),
    CONSTRAINT emp_pk PRIMARY KEY (id_emp)
);

/*2.2 Crea la funció de BD paraula_aleat amb paràmetres:
    ·long_min
    ·long_max
    · -> retorna una paraula aleatoria en el rang*/
CREATE OR REPLACE FUNCTION paraula_aleat(long_min IN NUMBER, long_max IN NUMBER) RETURN VARCHAR2 AS
    v_str VARCHAR2(100):='';
    v_num NUMBER;
    v_rand NUMBER;
    v_letters VARCHAR2(26):='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
BEGIN
    v_num := trunc(dbms_random.value(long_min, long_max+1));
    FOR i IN 1..v_num LOOP
        v_rand := trunc(dbms_random.value(1, 26));
        v_str := v_str || (SUBSTR(v_letters, v_rand+1, 1));
    END LOOP;
    RETURN v_str;
END;
/
DECLARE
    v_min NUMBER(1):=&min_len;
    v_max NUMBER(1):=&max_len;
BEGIN
    DBMS_OUTPUT.PUT_LINE(paraula_aleat(v_min, v_max));
END;
/

/*2.3 Troba una expressió per obtenir una data aleatória 
entre la data 15/1/1990 i la data del SGBD, totes dues
incloses.*/
SELECT TO_DATE(
    TRUNC(
        DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J')
        ,TO_CHAR(SYSDATE, 'J')
        )
    ),'J'
) FROM DUAL;

/*2.4 Troba una exessió per obtenir un salari aleatori entre 13300 i 87458*/
SELECT (
    TRUNC(
        DBMS_RANDOM.VALUE(13300, 87458)
    )
) FROM DUAL;

/*2.5. Crea la seqüència empleats_seq*/
CREATE SEQUENCE empleats_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999
    MINVALUE 1;
/
/*Crea un programa PL/SQL que demani a l'usuari la quantitat d'empleats a inserir i insereixi aquesta quantitat de files a la 
taula empleats.*/
DECLARE
    v_emp empleats%ROWTYPE;
    v_quant NUMBER :=&times;
BEGIN
    FOR i in 1..v_quant LOOP
    v_emp.id_emp := empleats_seq.nextval;
    v_emp.nom := paraula_aleat(3, 8);
    v_emp.cognoms := (paraula_aleat(2, 12) || ' ' || paraula_aleat(2, 12));
    v_emp.data_contracte := TO_DATE(
                                                TRUNC(
                                                    DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J')
                                                    ,TO_CHAR(SYSDATE, 'J')
                                                    )
                                                ),'J'
                                            );
    v_emp.salary := (
                                TRUNC(
                                    DBMS_RANDOM.VALUE(13300, 87458)
                                )
                            );
    INSERT INTO empleats (ID_EMP, NOM, COGNOMS, DATA_CONTRACTE, SALARY) VALUES (v_emp.id_emp, v_emp.nom, v_emp.cognoms, v_emp.data_contracte, v_emp.salary);
    END LOOP;
END;
