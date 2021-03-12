/*Introducimos las restricciones*/
/*1*/
ALTER TABLE PELICULA MODIFY FECHA DATE NOT NULL;
ALTER TABLE PERSONAJE MODIFY APODO VARCHAR(110) NOT NULL UNIQUE;

/*2*/
ALTER TABLE PELICULA MODIFY DURACION TIME DEFAULT "1:45:00";

/*3*/
ALTER TABLE PERSONAJE MODIFY PUESTO VARCHAR(50);
ALTER TABLE PERSONAJE ADD CONSTRAINT puesto_check CHECK (PUESTO IN ('combatiente', 'navegante', 'cocinero', 'médico', 'ingeniero'));

/*4*/
ALTER TABLE PERSONAJE ADD CONSTRAINT rango_check CHECK (RANGO IN ('capitan', 'comandante','tripulante'));
ALTER TABLE LUGAR ADD CONSTRAINT tipo_lugar_check CHECK (TIPO IN ('Isla', 'Ciudad', 'Barco', 'Base Militar'));

/*5*/
ALTER TABLE LUGAR ADD COLUMN REGION VARCHAR(110) CHECK (REGION IN ('North Blue' , 'South Blue' , 'East Blue' , 'West Blue'));
