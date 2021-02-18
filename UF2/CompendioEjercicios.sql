/*1.1.3*/
/*1*/
select nombre
from producto;

/*2*/
select nombre, precio
from producto;

/*3*/
select *
from producto;

/*4*/
select nombre, precio AS 'precio EUR', precio*1.19 AS 'precio USD'
from producto;

/*5*/
select nombre AS 'nombre de producto', precio AS 'euros', precio*1.19 AS 'dolares'
from producto;

/*6*/
select UPPER(nombre), precio
from producto;

/*7*/
select lower(nombre), precio
from producto;

/*8*/
select nombre, UPPER(SUBSTRING(nombre, 1, 2))
from fabricante;

/*9*/
select nombre, ROUND(precio, 2)
from producto;

/*10*/
select nombre, ROUND(precio, 0)
from producto;

/*11*/
SELECT fabricante.codigo
FROM fabricante
INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

/*12*/
SELECT fabricante.codigo
FROM fabricante
INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo;

/*13*/
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

/*14*/
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

/*15*/
SELECT f.nombre, producto.precio
FROM fabricante AS f
INNER JOIN producto ON f.codigo=producto.codigo_fabricante
ORDER BY nombre ASC, precio DESC;

/*16*/
SELECT nombre
FROM fabricante
LIMIT 5;

/*17*/
SELECT nombre
FROM fabricante
LIMIT 3, 2;

/*18*/
SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 1;

/*19*/
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

/*20*/
SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

/*21*/
SELECT nombre
FROM producto
WHERE precio <= 120;

/*22*/
SELECT nombre
FROM producto
WHERE precio >= 400;

/*23*/
SELECT nombre
FROM producto
WHERE precio NOT IN (SELECT precio FROM producto WHERE precio >= 400);

/*24*/
SELECT nombre, precio
FROM producto
WHERE precio >= 80 AND precio <= 300;

/*25*/
SELECT nombre, precio
FROM producto
WHERE precio BETWEEN 60 AND 200;

/*26*/
SELECT nombre, precio
FROM producto
WHERE precio > 200 AND codigo_fabricante = 6;

/*27*/
SELECT nombre, precio
FROM producto
WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

/*28*/
SELECT nombre, precio
FROM producto
WHERE codigo_fabricante IN (1,3,5);

/*29*/
SELECT nombre, precio*100 AS 'céntimos'
FROM producto;

/*30*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE 'S%';

/*31*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%e';

/*32*/
SELECT nombre
FROM fabricante
WHERE nombre LIKE '%w%';

/*33*/
SELECT nombre
FROM fabricante
WHERE LENGTH(nombre) = 4;

/*34*/
SELECT nombre
FROM producto
WHERE nombre LIKE '%Portátil%';

/*35*/
SELECT nombre
FROM producto
WHERE nombre LIKE '%Monitor%' and precio < 215;

/*36*/
SELECT nombre, precio
FROM producto
WHERE precio >= 180
ORDER BY precio DESC, nombre ASC;

/*******/
/*1.1.4*/
/*******/

/*1*/
SELECT prod.nombre, prod.precio, fab.nombre AS 'Fabricante'
FROM producto prod, fabricante fab
WHERE prod.codigo_fabricante = fab.codigo;

/*2*/
SELECT prod.nombre, prod.precio, fab.nombre AS 'Fabricante'
FROM producto prod, fabricante fab
WHERE prod.codigo_fabricante = fab.codigo
ORDER BY 3 ASC;

/*3*/
SELECT prod.codigo, prod.nombre, fab.codigo, fab.nombre AS 'Fabricante'
FROM producto prod, fabricante fab
WHERE prod.codigo_fabricante = fab.codigo;

/*4*/
SELECT producto.nombre, precio, fabricante.nombre
FROM fabricante
INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante
ORDER BY precio ASC
LIMIT 1;

/*5*/
SELECT pro.nombre, pro.precio, fab.nombre
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
ORDER BY precio DESC
LIMIT 1;

/*6*/
SELECT *
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Lenovo';

/*7*/
SELECT *
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Crucial' AND precio > 200;

/*8*/
SELECT *
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre = 'Asus' OR fab.nombre = 'Hewlett-Packard' OR fab.nombre = 'Seagate';

/*9*/
SELECT *
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

/*10*/
SELECT *
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE '%e';

/*11*/
SELECT producto.nombre, precio
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

/*12*/
SELECT fabricante.nombre, precio, producto.nombre
FROM fabricante
INNER JOIN producto on fabricante.codigo = producto.codigo_fabricante
WHERE precio >=180
ORDER BY precio DESC, producto.nombre ASC;

/*13*/
SELECT fab.codigo, fab.nombre
FROM producto pro
INNER JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
GROUP BY fab.codigo;

/*******/
/*1.1.5*/
/*******/

/*1*/
SELECT fab.codigo, fab.nombre, pro.nombre
FROM fabricante fab
LEFT JOIN producto pro ON fab.codigo = pro.codigo_fabricante;

/*2*/
SELECT fab.nombre
FROM fabricante fab
LEFT JOIN producto pro ON fab.codigo = pro.codigo_fabricante
WHERE pro.codigo_fabricante IS NULL;

/*3*/
/*No pueden existir ya que se requiere del campo codigo_fabricante*/

/*******/
/*1.1.6*/
/*******/

/*1*/
SELECT count(codigo)
FROM producto;

/*2*/
SELECT count(codigo)
FROM fabricante;

/*3*/
SELECT count(DISTINCT(codigo_fabricante))
FROM producto;

/*4*/
SELECT AVG(precio)
FROM producto;

/*5*/
SELECT MIN(precio)
FROM producto;

/*6*/
SELECT MAX(precio)
FROM producto;

/*7*/
SELECT nombre, precio
FROM producto
ORDER BY precio
LIMIT 1;

/*8*/
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

/*9*/
SELECT SUM(precio)
FROM producto;

/*10*/
SELECT count(codigo)
FROM producto
WHERE codigo_fabricante = 1;

/*11*/
SELECT AVG(precio)
FROM producto
WHERE codigo_fabricante = 1;

/*12*/
SELECT MIN(precio)
FROM producto
WHERE codigo_fabricante = 1;

/*13*/
SELECT MAX(precio)
FROM producto
WHERE codigo_fabricante = 1;

/*14*/
SELECT SUM(precio)
FROM producto
WHERE codigo_fabricante = 1;

/*15*/
SELECT MAX(precio), MIN(precio), AVG(precio), COUNT(*)
FROM producto
INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial';

/*16*/
SELECT fab.nombre, count(pro.codigo)
FROM producto pro
RIGHT JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
GROUP BY fab.nombre
ORDER BY 2 DESC;

/*17*/
SELECT fab.nombre, MAX(pro.precio), MIN(pro.precio), AVG(pro.precio)
FROM producto pro
RIGHT JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
GROUP BY fab.nombre
ORDER BY 2 DESC;

/*18*/
SELECT fab.nombre, MAX(pro.precio) 'Maximum', MIN(pro.precio) 'Minimum', AVG(pro.precio) 'Average', COUNT(pro.codigo)
FROM producto pro
RIGHT JOIN fabricante fab ON pro.codigo_fabricante = fab.codigo
WHERE 'Average' > 200
GROUP BY fab.nombre;



