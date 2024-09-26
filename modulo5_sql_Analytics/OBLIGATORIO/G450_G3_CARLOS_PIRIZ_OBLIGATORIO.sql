-- G450_G3_CARLOS_PIRIZ_OBLIGATORIO
-- Carlos Andrés	Píriz Scognamiglio	G3 
-- Francisco	Sosa	G3 
-- Indira	Sophie	G3 
-- -----------------------------------------------------------------------------------------------------
/*
Ejercicio 1: 10 pts.
Comente al menos 4 aspectos a mejor de la estructura de la siguiente tabla:
Estructura - Tabla Producto
Campo					Comentario				Tipo Dato
Producto_Descripción	Primary Key				varchar(20)
Producto_Cod									int
Color											varchar(20)
Fecha_factura									date
Fecha_creacion									varchar(20)
Cliente_Cod				Foreign key a Cliente	date
*/

/*
A nuestro parecer 4 aspectos a mejorar de la estructura, podrian ser:
	1 - Que el campo Producto_Cod sea autoincremental y se establezca como clave primaria, mas alla de que el campo Producto_Descripción fuera de valores unicos( e indexado).
	2 - Que el campo Color, sea numerico, y sea foreign key a una tabla Color (relacionada por ese id de color numerico)
	3 - Que el campo Fecha_creacion sea de tipo date o datetime
	4 - Que no este el campo Cliente_Cod, ya que entendemos que ese campo no corresponde para la tabla Producto
*/
-- -----------------------------------------------------------------------------------------------------
/*
Ejercicio 2: 10 pts.
1.1 Dada la siguiente consulta:
	SELECT 
		p.ProductNumber,
		Name,
		SUM(sod.LineTotal) AS Total
	FROM 
		Production.Product AS p
		RIGHT JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
	WHERE 
		ProductNumber LIKE 'BK-[ˆR]%-[0-9][0-9]'
	GROUP BY 
		ProductNumber, Name
a) Explique conceptualmente qué retorna la misma (información)
b) Explique con qué intención se utilizó la cláusula RIGHT JOIN
c) Explique por qué se utilizó la cláusula GROUP BY

a) En este caso retornaria, para todos los productos que comience con BK-, no tenga R en la cuarta posicion y no termine con dos digitos en el campo ProductNumber, el numero del producto, el nombre del producto y el total 
	correspondiente que se obtiene de la suma de las columnas LineTotal de la tabla SalesOrderDetail. Cabe aclarar que puede ser nulo ese Total.
b) Entendemos que pueden haber productos que coincidan con la condicion del WHERE, pero no tengan ordenes por ellos, pero de igual manera se quiere traer los datos del producto.
c) La clausula GROUP BY se utilizo para no traer todas las lineas de detalles de las ordenes de los productos seleccionados, sino que se quizon considerar el total de LineTotal para ese producto(de manera resumida).
*/
-- -----------------------------------------------------------------------------------------------------
/*
1.2 Dada la siguiente consulta:
	SELECT 
		soh.OrderDate AS Fecha,
		p.Name AS Producto,
		COUNT(soh.SalesOrderID) AS CantOrders
	FROM 
		Production.Product AS p
		INNER JOIN Sales.SalesOrderDetail AS sod ON P.ProductID = sod.ProductID
		INNER JOIN Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
	GROUP BY 
		soh.OrderDate, p.Name
	HAVING 
		COUNT(soh.SalesOrderID) > 1
	ORDER BY 
		COUNT(soh.SalesOrderID) DESC
a) Explique conceptualmente qué retorna la misma (información)
b) Explique con qué intención se utilizaron las cláusulas INNER JOIN
c) Explique para qué se utilizó la cláusula HAVING y por qué esto no fue realizado en la cláusula WHERE

a) Entendemos que se quiso traer la cantidad de ordenes que se hicieron por producto y fecha de orden (esta sumiendo que en una orden cada producto ocupa una linea y no puede haber en una misma orden, dos lineas con el mismo producto repetido).
	Ademas solo considera los resultados que para el mismo producto y fecha tengas mas de una orden
	Y finalmente los ordena por la cantidad de ordenes de forma descendente
b) Se utilizaron para asegurar que sean productos que tengan ordenes para las fechas que devuelva. Porque podrian haber productos que no tuvieran ordenes relacionadas. Y ademas se considean las ordenes que si tengan lineas de detalles.
c) Having se utilizo para filtrar que solo devolviera los registros de productos que tengan mas de una orden para esa fecha. Y no se hizo en el where porque por sintaxis, el having debe ir luego del group by, ya que trabaja sobre los resultados agrupados.
*/
-- -----------------------------------------------------------------------------------------------------
/*
Ejercicio 3: 10 pts.
Dadas las siguientes consultas resuelva:
- Si son correctas o no, justifique en caso de no serla y proceda a corregirlas
- Explique conceptualmente qué retornan (qué información)
a)
	Entendemos que la sentencia es incorrecta ya que:
		los esquemas SalesLT no existen, deberian ser Sales.
		el campo CompanyName no existe en la tabla Customer, podria ser el campo CustomerID
	De esta manera una posible solucion, que devuelva el CustomerID, su ordenes asociadas y el total de la deuda para cada orden, podria ser:
	SELECT 
		c.CustomerID,
		soh.SalesOrderID,
		SOH.TotalDue
	FROM
		Sales.Customer AS c
		JOIN Sales.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
*/
SELECT
	