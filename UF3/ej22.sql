/*Utilizar cursor open... fetch ... close
Realizar un programa que visualice los dos empleados que ganan menos de cada oficio.*/
SET SERVEROUTPUT ON
DECLARE
CURSOR c_emp IS SELECT job_id, last_name, salary FROM employees ORDER BY job_id, salary;
v_emp employees%ROWTYPE;
v_job VARCHAR2(10);
v_count INT := 0;
v_ok INT := 0;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_emp;
        EXIT WHEN c_emp%NOTFOUND;
        v_count:= v_count+1;
        IF v_count > 3 THEN
            IF v_count = 1 THEN
                v_ok := 1;
                v_job := v_emp.job_id;
            IF v_count = 2 AND v_job = v_emp.job THEN
                v_ok := 1;
            ELSE:
                v_ok := 0;
            END IF;
            IF v_ok = 1 THEN 
                DBMS_OUTPUT.PUT_LINE(v_emp.job_id || '       ' || v_emp.last_name || '       ' || v_emp.salary);
                v_ok := 0;
            END IF;
        ELSE:
            v_count :=0;
        END IF;
    END LOOP;
END;
