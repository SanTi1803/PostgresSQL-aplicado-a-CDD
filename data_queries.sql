--  Top 10 de películas con mayor facturación.
SELECT p.pelicula_id AS id, p.titulo, COUNT(*) AS numero_rentas,
ROW_NUMBER () OVER (
		order by COUNT(*) DESC
   	) AS lugar
FROM rentas
INNER JOIN inventarios ON rentas.inventario_id = inventarios.inventario_id
INNER JOIN peliculas as p ON inventarios.pelicula_id = p.pelicula_id
GROUP BY p.pelicula_id
ORDER BY numero_rentas DESC
LIMIT 10;


--  Empleado que mas venta realiza
SELECT 
	empleados.empleado_id AS identificador,
	empleados.nombre AS nombre,
	empleados.apellido AS apellido,
	COUNT(rentas.renta_id) OVER(PARTITION BY rentas.empleado_id) AS rentas_empleados 
FROM empleados 
INNER JOIN rentas ON empleados.empleado_id = rentas.empleado_id
GROUP BY
	empleados.empleado_id,
	empleados.nombre,
	rentas.empleado_id,
	rentas.renta_id
ORDER BY rentas_empleados DESC
LIMIT 1;


-- Ciudades con mas rentas 
SELECT c.ciudad_id, c.ciudad, COUNT(*) AS renta_por_ciudad
FROM ciudades AS c
INNER JOIN direcciones AS d 
ON c.ciudad_id = d.ciudad_id
INNER JOIN tiendas AS t
ON t.direccion_id = d.direccion_id
INNER JOIN inventarios AS i
ON i.tienda_id = t.tienda_id
INNER JOIN rentas AS r
ON i.inventario_id = r.inventario_id
group by c.ciudad_id
ORDER BY renta_por_ciudad DESC;


-- Año y mes con mayores ventas
SELECT date_part('year', r.fecha_renta) as anio, date_part('month', r.fecha_renta)
AS mes, COUNT(*) AS numero_renta
FROM rentas AS r
GROUP BY anio, mes
ORDER BY anio, mes;



-- 10 Ciudades con menos usuarios.
SELECT 
	c.ciudad_id AS identificador_ciudad,
	c.ciudad AS nombre_ciudad,
	COUNT(*) AS CUC
FROM ciudades AS c
INNER JOIN direcciones USING(ciudad_id)
INNER JOIN clientes USING(direccion_id )
GROUP BY identificador_ciudad
ORDER by CUC, identificador_ciudad;




-- Ticket promedio por cliente en $.
SELECT  DISTINCT(c.cliente_id), CONCAT(c.nombre,' ', c.apellido) AS nombre_apellido,
AVG(p.cantidad) OVER(PARTITION BY p.cliente_id) * tipos_cambio.cambio_usd AS pago_cliente 
FROM clientes AS c
INNER JOIN pagos AS p USING(cliente_id), tipos_cambio
WHERE tipos_cambio.codigo = 'MXN'
GROUP BY c.cliente_id,
		 p.cliente_id,
		 p.cantidad,
		 cambio_usd
ORDER BY pago_cliente;
