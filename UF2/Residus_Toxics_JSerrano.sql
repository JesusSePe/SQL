/*1*/
SELECT nif_empresa, data_enviament, cost
FROM Trasllat_EmpresaTransport
WHERE cost BETWEEN 3500 AND 3650;
/*2*/
SELECT nif_empresa, data_enviament, cost
FROM Trasllat_EmpresaTransport
WHERE data_enviament BETWEEN '2017-01-01'AND '2017-03-31';
/*3*/
SELECT DISTINCT(tractament)
FROM Trasllat;
/*4*/
SELECT DISTINCT(ciutat_emptransport)
FROM EmpresaTransportista;
/*5*/
SELECT nif_empresa, cod_residu, tractament
FROM Trasllat
WHERE envas LIKE 'B%';
/*6*/
/*No hi ha empleats a aquesta base de dades*/
/*7*/
SELECT tra.tipus_transport, emp.nom_emptransport
FROM Trasllat_EmpresaTransport tra
INNER JOIN EmpresaTransportista emp ON tra.nif_emptransport = emp.nif_emptransport
WHERE tra.cod_residu BETWEEN 6 AND 8;
/*8*/
SELECT nif_empresa, nom_empresa
FROM EmpresaProductora
WHERE nom_empresa LIKE '_a%' OR nom_empresa LIKE '%s%'
ORDER BY nom_empresa DESC;

/*9*/
SELECT nif_empresa, quantitat_trasllat
FROM Trasllat
WHERE tractament = 'Segregació i lliurament' AND data_enviament BETWEEN '2016-01-01'AND '2016-03-31';

/*10*/
SELECT cost*kms AS 'Cost Total'
FROM Trasllat_EmpresaTransport
WHERE tipus_transport = 'Train' AND cod_desti BETWEEN 12 AND 14;