/*Crea un bloque anónimo al cual el usuario le pasará un código de pedido, y nos muestre una 
cabecera con los datos más relevantes del cliente (Nombre, dirección, ciudad, país, teléfono),
del pedido (código y fecha), y todos los detalles de los artículos facturados en ese pedido,
indicando al final el precio final, el IVA y el precio más IVA.*/
SET SERVEROUTPUT ON
DECLARE
    v_cod NUMBER(38, 0);
    v_pedido pedido%rowtype;
    v_cliente cliente%rowtype;
    CURSOR c_items IS SELECT codigo_producto, cantidad, precio_unidad FROM detalle_pedido WHERE codigo_pedido = v_cod;
    v_cod_producto VARCHAR2(15);
    v_cantidad VARCHAR2(15);
    v_precio_unidad NUMBER(15, 2);
    v_total NUMBER(15,2) := 0;
BEGIN
    v_cod:=&pedido;
    SELECT * INTO v_pedido FROM pedido WHERE codigo_pedido = v_cod;
    SELECT * INTO v_cliente FROM cliente WHERE codigo_cliente = v_pedido.codigo_cliente;
    DBMS_OUTPUT.PUT_LINE('Cliente: '|| v_cliente.nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('Domicilio: '||v_cliente.linea_direccion1);
    DBMS_OUTPUT.PUT_LINE('Ciudad: '||v_cliente.ciudad);
    DBMS_OUTPUT.PUT_LINE('País: '||v_cliente.pais);
    DBMS_OUTPUT.PUT_LINE('Teléfono: '||v_cliente.telefono);
    DBMS_OUTPUT.PUT_LINE('Pedido: '|| v_pedido.codigo_pedido);
    DBMS_OUTPUT.PUT_LINE('Fecha de pedido: '|| v_pedido.fecha_pedido);
    OPEN c_items;
    DBMS_OUTPUT.PUT_LINE('Producto          Cantidad        Precio          Total');
    LOOP
        FETCH c_items INTO v_cod_producto, v_cantidad, v_precio_unidad;
        DBMS_OUTPUT.PUT_LINE(v_cod_producto||    '              '
                            ||v_cantidad||       '              '     
                            ||v_precio_unidad||  '              '
                            ||v_cantidad*v_precio_unidad);
        v_total := v_total + (v_cantidad*v_precio_unidad);
        EXIT WHEN c_items%NOTFOUND;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Subtotal: '|| v_total);
    DBMS_OUTPUT.PUT_LINE('IVA: '|| v_total*0.21);
    DBMS_OUTPUT.PUT_LINE('A pagar'|| v_total*1.21);
    DBMS_OUTPUT.PUT_LINE('A pagar: '|| v_total*1.21);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('ERROR. No se han encontrado datos.');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ERROR de conversión. Introduzca números sin comillas.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR sin definir.');
END;

