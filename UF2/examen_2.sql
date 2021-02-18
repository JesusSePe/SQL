/**Creamos una nueva base de datos para el segundo apartado.**/
CREATE DATABASE company;
USE company;

/**CREAMOS LAS DIFERENTES TABLAS**/
CREATE TABLE EMPLEADOS (
	DNI INT(8),
    NOMBRE VARCHAR(10),
    APELLIDO1 VARCHAR(15),
    APELLIDO2 VARCHAR(15),
    DIRECC1 VARCHAR(25),
    DIRECC2 VARCHAR(20),
    CIUDAD VARCHAR(20),
    MUNICIPIO VARCHAR(20),
    COD_POSTAL VARCHAR(5),
    SEXO CHAR(1),
    FECHA_NAC DATE
);

CREATE TABLE DEPARTAMENTOS (
	DPTO_COD INT(5),
    NOMBRE_DPTO VARCHAR(30),
    JEFE INT(8),
    PRESUPUESTO FLOAT(10,2),
    PRES_ACTUAL FLOAT(10,2)
);

CREATE TABLE ESTUDIOS (
	EMPLEADO_DNI INT(8),
    UNIVERSIDAD INT(5),
    AÑO INT,
    GRADO VARCHAR(3),
    ESPECIALIDAD VARCHAR(20)
);

CREATE TABLE HISTORIAL_LABORAL (
	EMPLEADO_DNI INT(8),
    TRAB_COD INT(5),
    FECHA_INICIO DATE,
    FECHA_FIN DATE,
    DPTO_COD INT(5),
    SUPERVISOR_DNI INT(8)
);

CREATE TABLE UNIVERSIDADES (
	UNIV_COD INT(5),
    NOMBRE_UNIV VARCHAR(25),
    CIUDAD VARCHAR(20),
    MUNICIPIO VARCHAR(2),
    COD_POSTAL VARCHAR(5)
);

CREATE TABLE HISTORIAL_SALARIAL (
	EMPLEADO_DNI INT(8),
    SALARIO FLOAT(10,2),
    FECHA_COMIENZO DATE,
    FECHA_FIN DATE
);

CREATE TABLE TRABAJOS (
	TRABAJO_COD INT(5),
    NOMBRE_TRAB VARCHAR(20),
    SALARIO_MIN FLOAT(10,2),
    SALARIO_MAX FLOAT(10,2)
);

/**Añadimos los atributos necesarios a las tablas**/
ALTER TABLE EMPLEADOS MODIFY NOMBRE VARCHAR(10) NOT NULL;
ALTER TABLE DEPARTAMENTOS MODIFY NOMBRE_DPTO VARCHAR(30) NOT NULL;
ALTER TABLE UNIVERSIDADES MODIFY NOMBRE_UNIV VARCHAR(25) NOT NULL;
ALTER TABLE TRABAJOS MODIFY NOMBRE_TRAB VARCHAR(20) NOT NULL;
ALTER TABLE EMPLEADOS MODIFY APELLIDO1 VARCHAR(15) NOT NULL;
ALTER TABLE DEPARTAMENTOS MODIFY PRESUPUESTO FLOAT(10,2) NOT NULL;
ALTER TABLE HISTORIAL_SALARIAL MODIFY SALARIO FLOAT(10,2) NOT NULL;
ALTER TABLE HISTORIAL_SALARIAL MODIFY FECHA_COMIENZO DATE NOT NULL;
ALTER TABLE HISTORIAL_SALARIAL MODIFY FECHA_FIN DATE NOT NULL;

/**Limitamos los valores de sexo en la tabla de empleados**/
ALTER TABLE EMPLEADOS ADD CONSTRAINT sex_check CHECK (SEXO IN ('H', 'M'));

/**Limitamos los nombres de departamento y trabajo.**/
ALTER TABLE DEPARTAMENTOS ADD UNIQUE nombre_dpto_unique (NOMBRE_DPTO);
ALTER TABLE TRABAJOS ADD UNIQUE nombre_trab_unique (NOMBRE_TRAB);

/**Fechas de fin no pueden ser antes de las fechas de inicio**/
ALTER TABLE HISTORIAL_LABORAL ADD CONSTRAINT fecha_fin_check CHECK (FECHA_FIN > FECHA_INICIO);
ALTER TABLE HISTORIAL_SALARIAL ADD CONSTRAINT fecha_fin_salario_check CHECK (FECHA_FIN > FECHA_COMIENZO);

/**Cada empleado tiene un sólo sueldo y un sólo empleo**/
ALTER TABLE HISTORIAL_SALARIAL ADD UNIQUE unique_employee (EMPLEADO_DNI);
ALTER TABLE HISTORIAL_LABORAL ADD UNIQUE unique_salary (EMPLEADO_DNI);

/**Establecemos las claves primarias y relacionamos las tablas**/
ALTER TABLE EMPLEADOS ADD PRIMARY KEY empleados_pk(DNI);
ALTER TABLE DEPARTAMENTOS ADD PRIMARY KEY dpts_pk(DPTO_COD);
ALTER TABLE ESTUDIOS ADD PRIMARY KEY estudios_pk(EMPLEADO_DNI, AÑO, GRADO);
ALTER TABLE HISTORIAL_LABORAL ADD PRIMARY KEY trabajos_pl(EMPLEADO_DNI, TRAB_COD);
ALTER TABLE UNIVERSIDADES ADD PRIMARY KEY universidades(UNIV_COD);
ALTER TABLE HISTORIAL_SALARIAL ADD PRIMARY KEY salarios_pk(EMPLEADO_DNI, SALARIO);
ALTER TABLE TRABAJOS ADD PRIMARY KEY trabajos_pk(TRABAJO_COD);

ALTER TABLE ESTUDIOS ADD CONSTRAINT uni_fk FOREIGN KEY (UNIVERSIDAD) REFERENCES UNIVERSIDADES(UNIV_COD);
ALTER TABLE ESTUDIOS ADD CONSTRAINT estudios_dni_fk FOREIGN KEY (EMPLEADO_DNI) REFERENCES EMPLEADOS(DNI);
ALTER TABLE HISTORIAL_LABORAL ADD CONSTRAINT trabajos_dni_fk FOREIGN KEY (EMPLEADO_DNI) REFERENCES EMPLEADOS(DNI);
ALTER TABLE HISTORIAL_LABORAL ADD CONSTRAINT trabajos_cod_fk FOREIGN KEY (TRAB_COD) REFERENCES TRABAJOS(TRABAJO_COD);
ALTER TABLE HISTORIAL_LABORAL ADD CONSTRAINT trabajos_dpto_fk FOREIGN KEY (DPTO_COD) REFERENCES DEPARTAMENTOS(DPTO_COD);
ALTER TABLE HISTORIAL_LABORAL ADD CONSTRAINT trabajos_super_dni_fk FOREIGN KEY (SUPERVISOR_DNI) REFERENCES EMPLEADOS(DNI);
ALTER TABLE HISTORIAL_SALARIAL ADD CONSTRAINT salarios_dni_fk FOREIGN KEY (EMPLEADO_DNI) REFERENCES EMPLEADOS(DNI);
ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT jefe_dni_fk FOREIGN KEY (JEFE) REFERENCES EMPLEADOS(DNI);

/**Insertar 2 tuplas en cada tabla, respetando la integridad de la tabla y las restricciones.**/
INSERT INTO EMPLEADOS (DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECC1, CIUDAD, MUNICIPIO, COD_POSTAL, SEXO, FECHA_NAC) VALUES (12345678, 'Manolo', 'García', 'Soto', 'Calle Dunno 73', 'Mlemcity', 'Mlem', 55555, 'H', STR_TO_DATE('29-01-2000', '%d-%m-%Y'));
INSERT INTO EMPLEADOS (DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECC1, CIUDAD, MUNICIPIO, COD_POSTAL, SEXO, FECHA_NAC) VALUES (15975382, 'Pepa', 'Not', 'Pig', 'Calle Dabadii Dabadae 15', 'I am blue', 'Blue', 15973, 'M', STR_TO_DATE('19-03-1982', '%d-%m-%Y'));

INSERT INTO DEPARTAMENTOS (DPTO_COD, NOMBRE_DPTO, JEFE, PRESUPUESTO, PRES_ACTUAL) VALUES (01234, 'Informática', 12345678, 75983.63, 50.73);
INSERT INTO DEPARTAMENTOS (DPTO_COD, NOMBRE_DPTO, JEFE, PRESUPUESTO, PRES_ACTUAL) VALUES (98765, 'Marketing', 15975382, 15000.90, 20.5);

INSERT INTO UNIVERSIDADES (UNIV_COD, NOMBRE_UNIV, CIUDAD, MUNICIPIO, COD_POSTAL) VALUES (77777, 'Matachussets UN.', 'Matachussets', 'Sí', 75824);
INSERT INTO UNIVERSIDADES (UNIV_COD, NOMBRE_UNIV, CIUDAD, MUNICIPIO, COD_POSTAL) VALUES (99999, 'Duckadona University', 'Valencia', 'No', 85462);

INSERT INTO HISTORIAL_SALARIAL (EMPLEADO_DNI, SALARIO, FECHA_COMIENZO, FECHA_FIN) VALUES (12345678, 2500, STR_TO_DATE('15-9-2020', '%d-%m-%Y'), now());
INSERT INTO HISTORIAL_SALARIAL (EMPLEADO_DNI, SALARIO, FECHA_COMIENZO, FECHA_FIN) VALUES (15975382, 2500, STR_TO_DATE('11-11-2011', '%d-%m-%Y'), now());

INSERT INTO TRABAJOS (TRABAJO_COD, NOMBRE_TRAB, SALARIO_MIN, SALARIO_MAX) VALUES (65412, 'Administrador patoso', 1.0, 50999.95);
INSERT INTO TRABAJOS (TRABAJO_COD, NOMBRE_TRAB, SALARIO_MIN, SALARIO_MAX) VALUES (76218, 'Marketingmaker', 0.5, 51000);

INSERT INTO HISTORIAL_LABORAL (EMPLEADO_DNI, TRAB_COD, FECHA_INICIO, FECHA_FIN, DPTO_COD, SUPERVISOR_DNI) VALUES (12345678, 65412, STR_TO_DATE('15-9-2020', '%d-%m-%Y'), NULL, 01234, 12345678);
INSERT INTO HISTORIAL_LABORAL (EMPLEADO_DNI, TRAB_COD, FECHA_INICIO, FECHA_FIN, DPTO_COD, SUPERVISOR_DNI) VALUES (15975382, 76218, STR_TO_DATE('11-11-2011', '%d-%m-%Y'), NULL, 98765, 15975382);

INSERT INTO ESTUDIOS (EMPLEADO_DNI, UNIVERSIDAD, AÑO, GRADO, ESPECIALIDAD) VALUES (12345678, 77777, 2020, 'Ing', 'Ingeniería absurda');
INSERT INTO ESTUDIOS (EMPLEADO_DNI, UNIVERSIDAD, AÑO, GRADO, ESPECIALIDAD) VALUES (15975382, 99999, 2005, 'Mkt', 'Marketing para patos');


/**INSERTAR MÁS TUPLAS**/
ALTER TABLE EMPLEADOS DROP CONSTRAINT sex_check;

INSERT INTO EMPLEADOS (NOMBRE, APELLIDO1, APELLIDO2, DNI, SEXO) VALUES ('Sergio', 'Palma', 'Entrena', 111222, 'P');
INSERT INTO EMPLEADOS (NOMBRE, APELLIDO1, APELLIDO2, DNI) VALUES ('Lucía', 'Ortega', 'Plus', 222333);

/**Ahora no podemos añadir la restricción ya que Sergio Palma ni Lucia Ortega cumplen con el check.**/
/**Para poder re-activar la constraint, hay que eliminar ambos registros.**/
DELETE FROM EMPLEADOS WHERE DNI IN ('111222', '222333');

/**Y volvemos a añadir la constraint.**/
ALTER TABLE EMPLEADOS ADD CONSTRAINT sex_check CHECK (SEXO IN ('H', 'M'));

/**Borrar una universidad**/
DELETE FROM UNIVERSIDADES WHERE UNIV_COD = 77777;
/**No se puede eliminar, ya que hay datos que dependen de esta universidad.**/
/**Para hacer esto, hay que modificar la tabla de estudios para que se eliminen en eliminar una universidad.**/
ALTER TABLE ESTUDIOS DROP CONSTRAINT uni_fk;
ALTER TABLE ESTUDIOS ADD CONSTRAINT uni_fk FOREIGN KEY (UNIVERSIDAD) REFERENCES UNIVERSIDADES(UNIV_COD) ON DELETE CASCADE;

/**Las personas de sexo masculino no pueden tener una fecha de nacimiento NULL**/
ALTER TABLE EMPLEADOS ADD CONSTRAINT h_nac_not_null CHECK (SEXO = 'H' AND FECHA_NAC != NULL);
/**No se puede introducir ya que hay tuplas que no cumplen el check.**/

/**Insertar un campo valoración a los empleados con un valor por defecto de 5. **/
ALTER TABLE EMPLEADOS ADD COLUMN VALORACION INT DEFAULT 5;
ALTER TABLE EMPLEADOS ADD CONSTRAINT valoracion_check CHECK (VALORACION BETWEEN 1 AND 10);
/**Los empleados ya existentes reciven una valoración de 5, y los nuevos también en caso de no definirse.**/

/**El nombre puede ser nulo.**/
ALTER TABLE EMPLEADOS MODIFY NOMBRE VARCHAR(10);

/**Realizar cambios de formato en DIRECC1 y FECHA_NAC**/
ALTER TABLE EMPLEADOS MODIFY DIRECC1 VARCHAR(40);
ALTER TABLE EMPLEADOS MODIFY FECHA_NAC TEXT;

/**Eliminar un empleado.Qué pasa con sus tuplas en historial salarial e historial laboral?**/
DELETE FROM EMPLEADOS WHERE DNI = 12345678;
/**No se puede eliminar ya que no hay un on delete cascade.**/

/**Crear una nueva tabla con el nombre completo en una columna, y el nombre de la universidad dónde estudiaron**/

CREATE TABLE INFORMACION_UNIVERSITARIA(
	NOMBRE_EMP TEXT,
    UNIVERSIDAD VARCHAR(20)
);
INSERT INTO INFORMACION_UNIVERSITARIA (NOMBRE_EMP, UNIVERSIDAD) VALUES ((SELECT CONCAT(NOMBRE, ' ', APELLIDO1, ' ', APELLIDO2) FROM EMPLEADOS EMP WHERE EMP.DNI = (SELECT DNI FROM EMPLEADOS WHERE DNI = EMP.DNI)), (SELECT UNIVERSIDAD FROM ESTUDIOS));



