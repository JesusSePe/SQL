SET SERVEROUTPUT ON
DECLARE
    CURSOR c_emp IS SELECT * FROM employees ORDER BY department_id;
    v_info c_emp%ROWTYPE;
    v_emp NUMBER := 0;
    v_salary NUMBER := 0;
    v_dep NUMBER (4, 0):= 0;
    v_dep_sal NUMBER := 0;
    v_dep_emp NUMBER := 0;
BEGIN 
    /*Print Employees*/
    DBMS_OUTPUT.PUT_LINE('***************');
    OPEN c_emp;
    FETCH c_emp INTO v_info;
    WHILE c_emp%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(v_info.last_name || '          ' || v_info.salary);
        v_salary := v_salary + v_info.salary;
        v_emp := v_emp + 1;
        FETCH c_emp INTO v_info;
    END LOOP;
    CLOSE c_emp;
    /*Print departments info*/
    DBMS_OUTPUT.PUT_LINE('***************');
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_info;
        IF v_dep = 0 THEN v_dep := v_info.department_id;
        END IF;
        IF v_dep <> v_info.department_id THEN
            DBMS_OUTPUT.PUT_LINE('El departamento '||v_dep||' tiene '||v_dep_emp||' empleados con un sueldo de '||v_dep_sal);
            v_dep := v_info.department_id;
            v_dep_sal := 0;
            v_dep_emp := 0;
        END IF;
        IF v_dep = v_info.department_id THEN
            v_dep_emp := v_dep_emp + 1;
            v_dep_sal := v_dep_sal + v_info.salary;
        END IF;
        EXIT WHEN c_emp%NOTFOUND;
    END LOOP;
    CLOSE c_emp;
    DBMS_OUTPUT.PUT_LINE('*****************************');
    DBMS_OUTPUT.PUT_LINE('Hay un total de '|| v_emp ||' empleados, con un sueldo total de '||v_salary);
END;

