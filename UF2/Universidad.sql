/***Consultas sobre una tabla***/
/***1***/
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY 1, 2, 3;

/*2*/
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno' and telefono is null;

/*3*/
SELECT apellido1, apellido2, nombre, fecha_nacimiento
FROM persona
WHERE tipo = 'alumno' and fecha_nacimiento like '%1999%';

/***4***/
SELECT apellido1, apellido2, nombre, telefono, nif
FROM persona
WHERE tipo = 'profesor' and nif like '%K';

/***5***/
SELECT nombre, curso, cuatrimestre, id_grado
FROM asignatura
WHERE curso = 3 and cuatrimestre = 1 and id_grado = 7;

/***Consultas multitabla (Composición interna INNER JOIN)***/
/***1***/
SELECT persona.apellido1, persona.apellido2, persona.nombre, persona.sexo
FROM persona
INNER JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
INNER JOIN grado ON asignatura.id_grado = grado.id
WHERE persona.tipo = 'alumno' and sexo = 'M' and grado.id = 4 and curso_escolar.id = 2;

/***2***/
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM alumno_se_matricula_asignatura
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE asignatura.id_grado = 4 AND anyo_fin = '2015'
GROUP BY nombre, anyo_inicio;

/***3***/
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS 'Departamento'
FROM profesor
INNER JOIN persona ON profesor.id_profesor = persona.id
INNER JOIN departamento ON profesor.id_departamento = departamento.id
WHERE persona.tipo = 'profesor'
ORDER BY 1,2,3;

/***4***/
SELECT persona.nif, asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM persona
INNER JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
INNER JOIN grado ON asignatura.id_grado = grado.id
WHERE persona.nif = "26902806M";

/***5***/
SELECT distinct dep.nombre
FROM departamento dep
INNER JOIN profesor prof ON prof.id_departamento = dep.id
INNER JOIN asignatura asi ON asi.id_profesor = prof.id_profesor
INNER JOIN grado g on g.id = asi.id_grado
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

/***6***/
SELECT persona.apellido1, persona.apellido2, persona.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM alumno_se_matricula_asignatura
INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE curso_escolar.anyo_inicio = '2018'
GROUP BY apellido1, apellido2, nombre;

/***Consultas multitabla (Composición externa)***/
/***1***/
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM profesor
RIGHT JOIN persona ON profesor.id_profesor = persona.id
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY 1,2,3,4;

/***2***/
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM profesor
RIGHT JOIN persona ON profesor.id_profesor = persona.id
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.nombre IS NULL
ORDER BY 1,2,3,4;

/***3***/
SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM profesor
RIGHT JOIN persona ON profesor.id_profesor = persona.id
RIGHT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE persona.apellido1 IS NULL
ORDER BY 1,2,3,4;

/***4***/
SELECT asignatura.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM profesor
RIGHT JOIN persona ON profesor.id_profesor = persona.id
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.nombre IS NULL
ORDER BY 1,2,3,4;

/***5***/
SELECT asi.nombre, per.apellido1, per.apellido2, per.nombre
FROM profesor pro
RIGHT JOIN persona per ON pro.id_profesor = per.id
RIGHT JOIN asignatura asi ON pro.id_profesor = asi.id_profesor
WHERE per.nombre IS NULL;

/***6***/
SELECT dep.nombre AS 'Departamento', asi.nombre AS 'Asignatura'
FROM profesor pro
RIGHT JOIN departamento dep ON pro.id_departamento = dep.id
RIGHT JOIN asignatura asi ON pro.id_profesor = asi.id_profesor
WHERE id_departamento IS NULL;

/***CONSULTAS RESUMEN***/
/***1***/
SELECT *
FROM persona
WHERE sexo = 'M' AND id IN (SELECT id FROM persona WHERE tipo='alumno');

/***2***/
SELECT *
FROM persona
WHERE fecha_nacimiento LIKE '%1999%' AND id IN (SELECT id FROM persona WHERE tipo='alumno');

/***3***/
SELECT sub.*
FROM (	SELECT dep.nombre AS 'departament' , COUNT(pro.id_profesor) AS 'profes'
		FROM profesor pro
		INNER JOIN departamento dep ON pro.id_departamento = dep.id
		GROUP BY id_departamento) AS sub
ORDER BY 2;

/***4***/
SELECT sub.*
FROM (	SELECT dep.nombre AS 'departament' , COUNT(pro.id_profesor) AS 'profes'
		FROM profesor pro
		RIGHT JOIN departamento dep ON pro.id_departamento = dep.id
		GROUP BY id_departamento) AS sub
ORDER BY 2;

/***5***/
SELECT sub.*
FROM (	SELECT gra.nombre AS 'Grado' , COUNT(asi.id_grado) AS 'Asignaturas'
		FROM grado gra
        LEFT JOIN asignatura asi ON gra.id = asi.id_grado
		GROUP BY id_grado) AS sub
ORDER BY 2 DESC;

/***6***/
SELECT sub.*
FROM (	SELECT gra.nombre AS 'Grado' , COUNT(asi.id_grado) AS 'Asignaturas'
		FROM grado gra
        LEFT JOIN asignatura asi ON gra.id = asi.id_grado
		GROUP BY id_grado) AS sub
WHERE Asignaturas > 40;

/***7***/
SELECT *
FROM (	SELECT gra.nombre AS 'Grado' , asi.tipo AS 'Tipo', SUM(asi.creditos) AS 'Creditos'
		FROM grado gra
        LEFT JOIN asignatura asi ON gra.id = asi.id_grado
		GROUP BY id_grado) AS sub
ORDER BY 2 DESC;

/***8***/
SELECT cur.anyo_inicio, COUNT(id_alumno)
FROM curso_escolar cur
INNER JOIN alumno_se_matricula_asignatura alu ON cur.id = alu.id_curso_escolar
GROUP BY cur.id;

/***9***/
SELECT pro.id_profesor, per.nombre, per.apellido1, per.apellido2, COUNT(asi.id_profesor)
FROM asignatura asi
RIGHT JOIN profesor pro ON asi.id_profesor = pro.id_profesor
INNER JOIN persona per ON pro.id_profesor = per.id
GROUP BY asi.id_profesor
ORDER BY 5 DESC;

/***Subconsultas****/
/***1***/
SELECT *
FROM persona
WHERE id = ( 	SELECT id
				FROM persona
				WHERE tipo = 'alumno'
                ORDER BY fecha_nacimiento DESC
                LIMIT 1);

/***2***/
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'profesor' AND id NOT IN (	
		SELECT pro.id_profesor
		FROM profesor pro);

/***3***/
SELECT nombre
FROM departamento
WHERE id NOT IN (	
		SELECT pro.id_departamento
		FROM profesor pro);
        
/***4***/
SELECT per.nombre, pro.id_departamento
FROM persona per
INNER JOIN profesor pro ON per.id = pro.id_profesor
WHERE tipo = 'profesor' AND id IN 
	(SELECT pro.id_profesor
     FROM profesor pro
     RIGHT JOIN asignatura asi ON pro.id_profesor = asi.id_profesor
     WHERE asi.id_profesor IS NULL);

/***5***/
SELECT nombre, id_profesor
FROM asignatura
WHERE id IN 
	(SELECT id
     FROM asignatura
     WHERE id_profesor IS NULL);

/***6***/
SELECT nombre
FROM departamento
WHERE id NOT IN 
	(SELECT pro.id_departamento
     FROM profesor pro
     INNER JOIN asignatura asi ON pro.id_profesor = asi.id_profesor);