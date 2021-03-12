/*Introducimos los datos del script ONE_PIECE.sql*/

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`BARCO` (`NOMBRE`, `CAPACIDAD_MAX`) VALUES ('Thousand Sunny', '11');
INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`BARCO` (`NOMBRE`, `CAPACIDAD_MAX`) VALUES ('Polar Tang', '6');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`BANDA` (`NOMBRE`) VALUES ('Piratas de Sombrero de Paja');
INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`BANDA` (`NOMBRE`) VALUES ('Piratas de Heart');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`CAPITULO` (`NUMERO_CAPITULO`, `TITULO`) VALUES ('1001', 'Luffy Sombrero de Paja');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PELICULA` (`TITULO`, `FECHA`) VALUES ('One Piece: Stampede', '2019-09-09');


INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`, `RANGO`,PUESTO) 
VALUES ('Monkey D. Luffy', 'Sombrero de Paja', '2500000000', 'capitan', 'combatiente');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`, `RANGO`,PUESTO) 
VALUES ('Roronoa Zoro', 'Cazador de Piratas', '330000000', 'comandante', 'combatiente');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`, `RANGO`,PUESTO) 
VALUES ('Tony Chopper', 'El amante del algodon de azucar', '10000', 'tripulante', 'medico');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`, `RANGO`,PUESTO) 
VALUES ('Trafalgar Law', 'El Cirujano de la Muerte', '500000000', 'capitan', 'combatiente');

INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`, `RANGO`,PUESTO) 
VALUES ('Bepo', 'Doctor de la Muerte', '50000', 'comandante', 'navegante');


INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`) 
VALUES ('Vinsmoke Sanji', 'Pierna negra', '500000000');


INSERT INTO `ONE_PIECE_SERRANO_JESUS`.`PERSONAJE` (`NOMBRE`, `APODO`, `RECOMPENSA`) 
VALUES ('Portgas D. Ace', 'Puño de Fuego', '550000000');


/*###################################################################################*/
/*Realizamos las queries con los datos recién introducidos/*
/*1. 
Haz que el barco de los Piratas Sombrero de Paja sea el Thousand
Sunny y el de los Piratas de Heart el Polar Tang*/

UPDATE BANDA
SET ID_BARCO = (SELECT ID_BARCO
				FROM BARCO
                WHERE NOMBRE = 'Thousand Sunny')
WHERE NOMBRE = 'Piratas Sombrero de Paja';

UPDATE BANDA
SET ID_BARCO = (SELECT ID_BARCO
				FROM BARCO
				WHERE NOMBRE = 'Polar Tang')
WHERE NOMBRE = 'Piratas de Heart';

/*2.
Añade a la base de datos la Banda de 'Los piratas de Shiroge' y forja
una alianza entre los Piratas de Sombrero de Paja y Los piratas de
Shiroge.*/

INSERT INTO BANDA (NOMBRE) VALUES ('Los piratas de Shiroge');
INSERT INTO ALIANZA_PIRATA (ID_BANDA1, ID_BANDA2) VALUES (	(SELECT ID_BANDA 
															FROM BANDA 
                                                            WHERE NOMBRE = 'Piratas de Sombrero de Paja'),
                                                            (SELECT ID_BANDA
                                                            FROM BANDA
                                                            WHERE NOMBRE = 'Los piratas de Shiroge'));

/*3.
Añade a Monkey D. Luffy, Roronoa Zoro y Vinsmoke Sanji a la banda
Piratas de Sombrero de Paja*/
UPDATE PERSONAJE
SET ID_BANDA = (SELECT ID_BANDA
				FROM BANDA
				WHERE NOMBRE = 'Piratas de Sombrero de Paja')
WHERE NOMBRE IN ('Monkey D. Luffy', 'Roronoa Zoro', 'Vinsmoke Sanji');

/*4.
Haz que Bepo sea el medico de los Piratas de Heart, todo en la misma
query*/

UPDATE PERSONAJE
SET PUESTO = 'médico',
	ID_BANDA = (SELECT ID_BANDA
				FROM BANDA
                WHERE NOMBRE = 'Piratas de Heart')
WHERE NOMBRE = 'Bepo';

/*5.
Elimina a todos los personajes que no estén en ninguna banda y que no
tengan puesto, todo en la misma query.
*/
DELETE FROM PERSONAJE 
WHERE PUESTO IS NULL AND ID_BANDA IS NULL;

/*6.
Haz que Luffy sea el capitan de los demás sombreros de paja
*/
UPDATE BANDA
SET CAPITAN =(SELECT ID_PERSONAJE
	       FROM PERSONAJE
               WHERE NOMBRE = 'Monkey D. Luffy')
WHERE ID_BANDA = (SELECT ID_BANDA FROM PERSONAJE WHERE NOMBRE = 'Monkey D. Luffy');

UPDATE PERSONAJE
SET CAPITAN =(	SELECT ID_PERSONAJE
				WHERE NOMBRE = 'Monkey D. Luffy')
WHERE ID_BANDA = (SELECT ID_BANDA FROM BANDA WHERE NOMBRE = 'Piratas de Sombrero de Paja');

/*7.
Añade un capitulo 1001 llamado Batalla de monstruos en Onigashima, en
el cual aparezca Roronoa Zoro y visiten un lugar llamado Wano de tipo
Isla con la descripcion: Wano Es el escenario principal del arco del
Pais de Wano.
*/

INSERT INTO CAPITULO (NUMERO_CAPITULO, TITULO) VALUES (1001, 'Batalla de monstruos en Onigashima');
INSERT INTO LUGAR (NOMBRE, TIPO, DESCRIPCION) VALUES ('Wano', 'Isla', 'Wano Es el escenario principal del arco del Pais de Wano.');
INSERT INTO VISITA (ID_CAPITULO, ID_LUGAR) VALUES (	(SELECT ID_CAPITULO FROM CAPITULO WHERE TITULO = 'Batalla de monstruos en Onigashima'),
													(SELECT ID_LUGAR FROM LUGAR WHERE NOMBRE = 'Wano'));
INSERT INTO PERSONAJES_CAPITULOS (ID_PERSONAJE, ID_CAPITULO) VALUES (	(SELECT ID_PERSONAJE FROM PERSONAJE WHERE NOMBRE LIKE '%Zoro%'),
																		(SELECT ID_CAPITULO FROM CAPITULO WHERE TITULO = 'Batalla de monstruos en Onigashima'));

