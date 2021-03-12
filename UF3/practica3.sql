/*Realizar un bloque anónimo, que visualice todos los códigos de los productos al revés. Mostrar
dos columnas, una con el código bien y otra con el código al revés.
Ejemplo: HJ4RR5 | 5RR4JH*/
SET SERVEROUTPUT ON
DECLARE
    v_product VARCHAR2(30);
    len NUMBER;
    CURSOR c_codes IS SELECT codigo_producto FROM producto;
BEGIN
    OPEN c_codes;
    LOOP
        FETCH c_codes INTO v_product;
        len := Length(v_product);
        FOR i IN REVERSE 1.. len LOOP
            v_product := v_product || Substr(v_product, i, 1);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(Substr(v_product, 0, len)|| ' | ' || Substr(v_product, len+1, (len+1)*2));
        EXIT WHEN c_codes%NOTFOUND;
    END LOOP;
END;

/*Desarrolla un bloque anónimo que devuelva la diferencia de días entre la fecha de pedido y l
fecha de entrega para un pedido en concreto que se pedirá al usuario.*/
SET SERVEROUTPUT ON 
DECLARE
    v_pedido NUMBER(38);
    v_fpedido DATE;
    v_fentrega DATE;
BEGIN
    v_pedido :=&num_pedido;
    SELECT fecha_pedido, fecha_entrega INTO v_fpedido, v_fentrega FROM pedido WHERE codigo_pedido = v_pedido;
    DBMS_OUTPUT.PUT_LINE('Hay una diferencia de '|| (TO_DATE(v_fentrega)-TO_DATE(v_fpedido)) ||' días entre las fechas de pedido y entrega.');
END;

/*Desarrollar un bloque anónimo que visualice todos los clientes y todos sus pedidos con más
de 5 productos.*/
SET SERVEROUTPUT ON
DECLARE
    v_cliente NUMBER(38);
    v_pedido NUMBER(38);
    CURSOR c_pedido IS SELECT codigo_cliente, codigo_pedido
                        FROM pedido
                        WHERE codigo_pedido IN 
                            (SELECT codigo_pedido
                             FROM detalle_pedido
                             GROUP BY codigo_pedido
                             HAVING count(codigo_producto) > 5)
                        ORDER BY codigo_cliente, codigo_pedido;
                        
BEGIN
    OPEN c_pedido;
    LOOP
        FETCH c_pedido INTO v_cliente, v_pedido;
        DBMS_OUTPUT.PUT_LINE('El cliente con código '|| v_cliente || ' ha realizado el pedido '|| v_pedido || ' que contiene más de 5 productos.');
        EXIT WHEN c_pedido%NOTFOUND;
    END LOOP;
END;

/*Escribir un bloque anónimo que visualice el apellido y el limite_credito de los cinco clientes
que más dinero se han gastado en total.*/

/*Por algún extraño motivo me sale el último registro duplicado, pero si hago la query del cursor sólo me salen 5 resultados y son diferentes...*/
SET SERVEROUTPUT ON
DECLARE
    CURSOR c_clientes IS    SELECT codigo_cliente
                            FROM pago
                            GROUP BY codigo_cliente
                            ORDER BY sum(total) desc
                            /*Oracle SQL no soporta LIMIT 5, por eso esta línea.*/
                            OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
    v_cliente NUMBER(38);
    v_apellido VARCHAR2(50);
    v_limite NUMBER(15,2);
BEGIN
    OPEN c_clientes;
    LOOP
        FETCH c_clientes INTO v_cliente;
            SELECT nombre_cliente, limite_credito
            INTO v_apellido, v_limite
            FROM cliente
            WHERE codigo_cliente = v_cliente;
            DBMS_OUTPUT.PUT_LINE(v_apellido||' tiene un límite de crédito de '||v_limite);
        EXIT WHEN c_clientes%NOTFOUND;
    END LOOP;
END;

/*Crea un bloque anónimo que al pasarle un código de un cliente nos liste lo siguiente:
- Código, nombre, Ciudad, País.
- Pagos que ha realizado. Ordenados cronologicamente.
- Cantidad total pagada.*/
SET SERVEROUTPUT ON
DECLARE
    v_idcliente NUMBER(38):=&id_cliente;
    v_cliente cliente%ROWTYPE;
    v_pagos pago%ROWTYPE;
    CURSOR c_pagos IS SELECT * FROM pago WHERE codigo_cliente = v_idcliente ORDER BY fecha_pago;
    v_total NUMBER(15,2);
BEGIN
    SELECT * INTO v_cliente FROM cliente WHERE codigo_cliente = v_idcliente;
    DBMS_OUTPUT.PUT_LINE('CODIGO CLIENTE: '|| v_idcliente);
    DBMS_OUTPUT.PUT_LINE('NOMBRE CLIENTE: '|| v_cliente.nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('CIUDAD CLIENTE: '|| v_cliente.ciudad);
    DBMS_OUTPUT.PUT_LINE('PAIS   CLIENTE: '|| v_cliente.pais);
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('ID-TRANSACCION    FECHA      FORMA    CANTIDAD');
    OPEN c_pagos;
    LOOP
        FETCH c_pagos INTO v_pagos;
        EXIT WHEN c_pagos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_pagos.id_transaccion||'     '||to_char(to_date(v_pagos.fecha_pago, 'DD-MM-YYYY'), 'DD/MM/YY')||'   '||v_pagos.forma_pago||'   '||v_pagos.total);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('==================================================');
    SELECT sum(total) INTO v_total FROM pago WHERE codigo_cliente = v_idcliente;
    DBMS_OUTPUT.PUT_LINE('TOTAL PAGOS EFECTUADOS: '|| v_total);
END;
