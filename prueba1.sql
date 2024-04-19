--1.Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, o.ciudad, p.codigo_cliente FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

--2.Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT o.ciudad, o.region, o.linea_direccion1, o.linea_direccion2, c.ciudad AS 'cliente_ciudad' FROM oficina o 
INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada'; 

--3.Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, o.ciudad FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

--4.Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT e.nombre AS 'empleado', j.nombre AS 'jefe' FROM empleado e
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

--5.Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.nombre_cliente, p.fecha_esperada, p.fecha_entrega FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_esperada < p.fecha_entrega;

--6.Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT p.gama, c.nombre_cliente FROM producto p
INNER JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
INNER JOIN pedido pp ON dp.codigo_pedido = pp.codigo_pedido
INNER JOIN cliente c ON pp.codigo_cliente = c.codigo_cliente
GROUP BY c.codigo_cliente, p.gama;

--7.Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.
SELECT c.nombre_cliente, p.codigo_cliente FROM cliente c 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

--8.Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT c.nombre_cliente, p.codigo_cliente FROM cliente c 
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

--9.Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT c.nombre_cliente, p.codigo_cliente, pg.codigo_cliente FROM cliente c 
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pg.codigo_cliente IS NULL;

--10.Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT e.nombre, o.codigo_oficina FROM empleado e 
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

--11.Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT e.nombre, c.codigo_empleado_rep_ventas FROM empleado e 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;

--12.Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT e.nombre, o.codigo_oficina, c.codigo_empleado_rep_ventas FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL;

--13.Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.nombre, dp.codigo_producto FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL GROUP BY p.nombre;

--14.Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT o.codigo_oficina, pd.gama  FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
INNER JOIN producto pd ON dp.codigo_producto = pd.codigo_producto
WHERE pd.gama = 'Frutales' GROUP BY o.codigo_oficina;

--15.Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT c.nombre_cliente, p.codigo_cliente, pg.codigo_cliente FROM cliente c 
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
WHERE pg.codigo_cliente IS NULL;

--16.Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT e.nombre , j.nombre, c.codigo_empleado_rep_ventas FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;

--17.¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) AS 'Cantidad_empleados' FROM empleado; 

--18.¿Cuántos clientes tiene cada país?
SELECT pais, COUNT(*) AS 'cant_clientes' FROM cliente GROUP BY pais;

--19.¿Cuál fue el pago medio en 2009?
SELECT AVG(total) AS 'pago medio' FROM pago WHERE fecha_pago BETWEEN '2009/01/01' AND '2009/12/31';

--20.¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado, COUNT(*) AS 'cant_pedidos' FROM pedido GROUP BY estado ORDER BY codigo_pedido DESC;
