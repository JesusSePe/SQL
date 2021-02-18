-- 1 Mostrar la Carta inicial más repetida por cada jugador (mostrar nombre jugador y carta). 
SELECT distinct(carta_inicial) AS 'Carta', COUNT(carta_inicial) AS 'Usos', id_participante AS 'Participant'
FROM turnos tur
INNER JOIN participante par ON tur.idparticipante = par.id_participante
WHERE idturnos IN (
					SELECT idturnos, distinct(id_participante) AS 'Participant', carta_inicial AS 'Carta', COUNT(carta_inicial) AS 'Usos'
					FROM turnos tu
					INNER JOIN participante pa ON tu.idparticipante = pa.id_participante
					GROUP BY carta_inicial, id_participante
					ORDER BY id_participante, Usos DESC;
					)


GROUP BY carta_inicial, id_participante
ORDER BY id_participante, Usos DESC;


SELECT 
  carta_inicial AS 'Carta',
  id_participante AS 'Participant'
FROM (
  SELECT DISTINCT 
    idparticipante 
  FROM 
    turnos) turnos
INNER JOIN (SELECT distinct(carta_inicial) AS 'Carta', COUNT(carta_inicial) AS 'Usos', idparticipante
			FROM turnos tur
			INNER JOIN participante par ON tur.idparticipante = par.id_participante
			GROUP BY carta_inicial, idparticipante
			ORDER BY idparticipante, Usos DESC) datos ON turnos.idparticipante = datos.idparticipante;

SELECT distinct(id_participante) AS 'Participant', carta_inicial AS 'Carta', COUNT(carta_inicial) AS 'Usos'
FROM turnos tur
INNER JOIN participante par ON tur.idparticipante = par.id_participante
GROUP BY carta_inicial, id_participante
ORDER BY id_participante, Usos DESC;

SELECT carta_inicial, Usos, idparticipante
FROM turnos tur
INNER JOIN participante par ON tur.idparticipante = par.id_participante
WHERE 



















SELECT distinct(carta_inicial) AS 'Carta', COUNT(carta_inicial) AS 'Usos', id_participante AS 'Participant'
FROM turnos tur1
INNER JOIN participante par ON tur1.idparticipante = par.id_participante
GROUP BY carta_inicial, id_participante
HAVING COUNT(carta_inicial) =
	(SELECT MAX(Usos) FROM 
		(
			SELECT distinct(carta_inicial) AS 'Carta', COUNT(carta_inicial) AS 'Usos', id_participante AS 'Participant'
			FROM turnos tur
			INNER JOIN participante par ON tur.idparticipante = par.id_participante
			GROUP BY Carta, Participant
			ORDER BY id_participante, 2 DESC
		)
	t)
ORDER BY id_participante, 2 DESC;


-- 2 Jugador que realiza la apuesta más alta por partida. (Mostrar nombre jugador)

SELECT tur.idparticipante, tur.apuesta
FROM turnos tur
WHERE tur.apuesta IN (SELECT apuesta FROM turnos WHERE idparticipante = tur.idparticipante ORDER BY apuesta DESC LIMIT 1);

-- 3 Jugador que realiza apuesta más baja por partida. (Mostrar nombre jugador)
-- 4 Ratio  de turnos ganados por jugador en cada partida (%),mostrar columna Nombre jugador, Nombre partida, nueva columna "porcentaje %"
SELECT (SELECT username FROM jugador ju INNER JOIN participante par ON ju.idjugador = par.id_jugador INNER JOIN usuario usu ON ju.idusuario = usu.idusuario WHERE par.id_participante = tur.idparticipante), (SELECT nombre_sala FROM partida pa INNER JOIN turnos tu ON pa.idpartida = tu.idpartida WHERE pa.idpartida = tur.idpartida)
FROM turnos tur;





-- 5 Porcentaje de partidas ganadas Bots en general. Nueva columna "porcentaje %"
-- 6 Mostrar los datos de los jugadores y el tiempo que han durado sus partidas ganadas cuya puntuación obtenida es mayor que la media puntos de las partidas ganadas totales.
-- 7 Cuántas rondas se ganan en cada partida según el palo. Ejemplo: Partida 1 - 5 rondas - Bastos como carta inicial.
-- 8 Cuantas rondas gana la banca en cada partida.
-- 9 Cuántos usuarios han sido la banca en
-- 10 Partida con la puntuación más alta final de todos los jugadores, mostrar nombre jugador, nombre partida,así como añadir una columna nueva en la que diga si ha ganado la partida o no.
-- 11 Calcular la apuesta media por partida.
-- 12 Mostrar los datos de los usuarios que no son bot, así como cual ha sido su última apuesta en cada partida que ha jugado.
-- 13 Calcular el valor total de las cartas y el numero total de cartas que se han dado inicialmente en las manos en la partida. Por ejemplo, en la partida se han dado 50 cartas y el valor total de las cartas es 47,5.
-- 14 Diferencia de puntos de los participantes de las partidas entre la ronda 1 y 5. Ejemplo: Rafa tenia 20 puntos, en la ronda 5 tiene 15, tiene -5 puntos de diferencia.