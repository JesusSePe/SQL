/**Base de datos creada**/
CREATE DATABASE academy;
/**Cambio a la base de datos creada**/
USE academy;
/**Para ir más rápidos, creamos las tablas con todas las limitaciones y referencias a la vez.
Por tanto, la primera tabla será profesores, ya que no depende de ninguna otra.**/
CREATE TABLE PROFESORES (
	NOMBRE VARCHAR(20) NOT NULL,
    APELLIDO1 VARCHAR(25) NOT NULL,
    APELLIDO2 VARCHAR(25) NOT NULL,
    DNI INT NOT NULL,
    DIRECCION VARCHAR(200),
    TITULO VARCHAR(100),
    GANA MEDIUMINT NOT NULL,
    PRIMARY KEY (DNI),
    CONSTRAINT name_unique UNIQUE (NOMBRE, APELLIDO1, APELLIDO2)
);
/**La segunda tabla será la de cursos, ya que depende de profesor, y alumnos depende de esta.**/
CREATE TABLE CURSOS (
	NOMBRE_CURSO VARCHAR(30) UNIQUE NOT NULL,
    COD_CURSO MEDIUMINT NOT NULL AUTO_INCREMENT,
    DNI_PROFESOR INT,
    MAXIMO_ALUMNOS MEDIUMINT,
    FECHA_INICIO DATE,
    FECHA_FIN DATE,
    NUM_HORAS INT NOT NULL,
    PRIMARY KEY (COD_CURSO),
    FOREIGN KEY(DNI_PROFESOR) references PROFESORES(DNI),
    CONSTRAINT fin_check CHECK (FECHA_FIN > FECHA_INICIO)
);
/**La ultima tabla a crear es la de alumnos, ya que es la que depende de cursos.**/
CREATE TABLE ALUMNOS (
	NOMBRE VARCHAR(20) NOT NULL,
	APELLIDO1 VARCHAR(25) NOT NULL,
	APELLIDO2 VARCHAR (25) NOT NULL,
	DNI INT NOT NULL,
	DIRECCION VARCHAR(200),
	SEXO VARCHAR(1),
    FECHA_NACIMIENTO DATE,
	CURSO MEDIUMINT NOT NULL,
    PRIMARY KEY (DNI),
    FOREIGN KEY(CURSO) references CURSOS(COD_CURSO),
    CONSTRAINT sexo_check CHECK (SEXO IN ('H', 'M'))
);

/**Insertamos la información requerida en las tablas.**/
INSERT INTO PROFESORES(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, TITULO, GANA) VALUES ('Juan', 'Orch', 'López', 32432455, 'Puerta Negra, 4', 'Ing. Informática', 7500);
INSERT INTO PROFESORES(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, TITULO, GANA) VALUES ('María', 'Olivia', 'Rubio', 43215643, 'Juan Alfonso 32', 'Lda. Fil. Inglesa', 5400);

INSERT INTO CURSOS(NOMBRE_CURSO, DNI_PROFESOR, MAXIMO_ALUMNOS, FECHA_INICIO, FECHA_FIN, NUM_HORAS) VALUES ('Inglés Básico', 43215643, 15, STR_TO_DATE('01-11-2000', '%d-%m-%Y'), STR_TO_DATE('22-12-2000', '%d-%m-%Y'), 120);
INSERT INTO CURSOS(NOMBRE_CURSO, DNI_PROFESOR, FECHA_INICIO, NUM_HORAS) VALUES ('Administración Linux', 32432455, STR_TO_DATE('01-09-2000', '%d-%m-%Y'), 80);

INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, SEXO, FECHA_NACIMIENTO, CURSO) VALUES ('Lucas', 'Manilva', 'López', 123523, 'Alhamar 3', 'H', STR_TO_DATE('01-11-1979', '%d-%m-%Y'), 1);
INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, SEXO, FECHA_NACIMIENTO, CURSO) VALUES ('Antonia', 'López', 'Alcantala', 2567567, 'Maniquí 21', 'M', NULL, 2);
INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, SEXO, FECHA_NACIMIENTO, CURSO) VALUES ('Manuel', 'Alcantara', 'Pedrós', 3123689, 'Julian 2', NULL, NULL, 2);
INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, SEXO, FECHA_NACIMIENTO, CURSO) VALUES ('José', 'Pérez', 'Caballar', 4896765, 'Jarcha 5', 'H', STR_TO_DATE('03-02-1977', '%d-%m-%Y'), 1);

/**Insertamos en alumnos la tupla extra**/
INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, SEXO, FECHA_NACIMIENTO, CURSO) VALUES ('Sergio', 'Navas', 'Retal', 123523, NULL, 'P', NULL, NULL);
/**Esta sentencia nos da error, ya que hemos limitado el sexo a 'H' o 'M', y no acepta ningún otro valor. A demás, el curso no puede ser nulo.**/
/**El error que nos devuelve MySQL es: Error Code: 1265. Data truncated for column 'SEXO' at row 1**/

/**Añadimos el campo edad a los profesores**/
ALTER TABLE PROFESORES ADD COLUMN EDAD INT;

/**Añadimos la restricción de edad a los profesores**/
ALTER TABLE PROFESORES ADD CONSTRAINT edad_check CHECK (EDAD BETWEEN 18 AND 65);

/**Ningún curso puede tener menos de 10 alumnos cómo máximo**/
ALTER TABLE CURSOS ADD CONSTRAINT max_alums_check CHECK (MAXIMO_ALUMNOS >= 10);

/**Todos los cursos deben tener más de 100 horas**/
ALTER TABLE CURSOS ADD CONSTRAINT hours_check CHECK (NUM_HORAS > 100);
/**Esta sentencia nos da error, ya que estamos intentando limitar el campo num_horas en cursos a 100, pero uno de los cursos ya introducidos tiene un número menor de horas, por lo que tal restricción fallaría ahí.**/
/**Si queremos ejecutar correctamente esta limitación podemos actualizar el curso a 100 horas, o borrar el curso, alumnos y profesores que estén relacionados.**/
/**El error que devuelve MySQL es: Error Code: 3819. Check constraint 'hours_check' is violated.**/

/**Eliminamos la restricción en los valores para sexo.**/
ALTER TABLE ALUMNOS DROP CHECK sexo_check;


/**Se dice que cada alumno ha de estar matriculado en un solo curso. ¿Esto
quiere decir que el atributo CURSO de la tabla ALUMNOS ha de ser UNIQUE?**/
/**No. Si se hace eso, sólo se podría introducir un alumno por curso. Lo que hay que hacer es sólo permitir un registro por alumno, y que no se puedan repetir.**/


/**Eliminar la restricción de tipo NOT NULL del atributo GANA.**/
ALTER TABLE PROFESORES MODIFY GANA MEDIUMINT;

/**Añadir limitación not null al campo fecha_inicio**/
ALTER TABLE CURSOS MODIFY FECHA_INICIO DATE NOT NULL;

/**Cambiar la pk de la tabla profesores**/
ALTER TABLE CURSOS DROP FOREIGN KEY CURSOS_ibfk_1;
ALTER TABLE PROFESORES DROP PRIMARY KEY;
ALTER TABLE PROFESORES ADD CONSTRAINT profesores_pk PRIMARY KEY (NOMBRE, APELLIDO1, APELLIDO2);
ALTER TABLE PROFESORES MODIFY DNI INT UNIQUE NOT NULL;
ALTER TABLE CURSOS ADD FOREIGN KEY dni_profesor_fk (DNI_PROFESOR) REFERENCES PROFESORES(DNI);

/**Añadir datos a profesores**/
INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, TITULO, GANA) VALUES ('Juan', 'Arch', 'López', 32432455, 'Puerta Negra 4', 'Ing. Informática', NULL);

/**Añadir datos a alumnos**/
INSERT INTO ALUMNOS(NOMBRE, APELLIDO1, APELLIDO2, DNI, DIRECCION, SEXO, FECHA_NACIMIENTO, CURSO) VALUES ('María', 'Jaén', 'Sevilla', 789678, 'Martos 5', 'M', STR_TO_DATE('10-03-1977', '%d-%m-%Y'), 3);
/**No se puede añadir el alumno, ya que no hay ningún curso con el código 3.**/

/**Corregir los datos de Antonia López**/
UPDATE ALUMNOS SET FECHA_NACIMIENTO=STR_TO_DATE('23-12-1976', '%d-%m-%Y') WHERE NOMBRE='Antonia' AND APELLIDO1='López';

UPDATE ALUMNOS SET CURSO=5 WHERE NOMBRE='Antonia' AND APELLIDO1='López';
/**No se puede añadir a Antonia al curso 5, ya que no existe dicho curso.**/

/**Eliminar Laura Jiménez**/
DELETE FROM PROFESORES WHERE NOMBRE='Laura' AND APELLIDO1='Jiménez';

/**Crear una tabla temporal llamada NOMBRE DE ALUMNOS que contenga el nombre completo de los alumnos en un campo 'NOMBRE_COMPLETO'**/
CREATE TEMPORARY TABLE NOMBRE_DE_ALUMNOS SELECT CONCAT(NOMBRE, ' ', APELLIDO1, ' ', APELLIDO2) AS 'NOMBRE_COMPLETO' FROM ALUMNOS;

/**Drop tables and database. **/
DROP TABLE NOMBRE_DE_ALUMNOS;
DROP TABLE ALUMNOS;
DROP TABLE CURSOS;
DROP TABLE PROFESORES;
DROP DATABASE academy;

