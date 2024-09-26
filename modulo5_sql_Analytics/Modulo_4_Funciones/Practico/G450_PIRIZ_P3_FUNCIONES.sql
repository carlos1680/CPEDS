-- G450_PIRIZ_P3_FUNCIONES
/*
1. El departamento de RRHH quiere saber cuántas personas existen en su base de datos 
(colocarle el siguiente alias a la columna: ‘Cantidad de Personas’).
Referencia: Person.Person
*/
SELECT
	count(*) as 'Cantidad de Personas'
FROM
	Person.Person;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
a. Obtener ahora la cantidad de personas por tipo (campo PersonType).
*/
SELECT
	PersonType,
	count(*) as 'Cantidad de Personas'
FROM
	Person.Person
GROUP BY
	PersonType;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
2. Obtener la suma del total en las líneas de órdenes de venta agrupado por orden 
(agrupar por SalesOrederID).
Referencia: Sales.SalesOrderDetail
*/
SELECT
	SalesOrderID,
	sum(LineTotal) as 'SubTotal'
FROM
	Sales.SalesOrderDetail
GROUP BY
	SalesOrderID;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
3. Obtener para cada COLOR, la cantidad de productos que existen del mismo color 
y ordenarlos de mayor cantidad a menor cantidad.
Referencia: Production.Product
*/
SELECT
	Color,
	count(Color) as 'Cantidad de Productos'
FROM
	Production.Product
GROUP BY
	Color
order by 'Cantidad de Productos' DESC;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
a. Obtener para cada COLOR, 
cuanto suman los precios de los productos que existen del mismo color 
y ordenarlos por el resultado de la suma de mayor a menor.
*/
SELECT
	Color,
	SUM(ListPrice) as 'Suma Precios de Lista'
FROM
	Production.Product
GROUP BY
	Color
order by 'Suma Precios de Lista' DESC;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
4. Se quiere saber la cantidad de empleados que existen por puestos, 
ordenados por cantidad de mayor a menor.
Referencia: HumanResources.Employee
*/
SELECT
	JobTitle,
	COUNT(LoginID) as 'Cantidad de Empleados'
FROM
	HumanResources.Employee
GROUP BY
	JobTitle
order by 'Cantidad de Empleados' DESC;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
5. Obtener la suma del total en las líneas de órdenes de venta agrupado por orden 
(agrupar por SalesOrederID), 
donde el total por orden sea mayor a 100.000 (cien)
Referencia: Sales.SalesOrderDetail
*/
SELECT
	SalesOrderID,
	SUM(LineTotal) as 'Suma de lineas'
FROM
	Sales.SalesOrderDetail
GROUP BY
	SalesOrderID
HAVING
	SUM(LineTotal)>100
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
6. Obtener para cada COLOR, 
la cantidad de productos que existen del mismo 
pero trayendo solamente los colores que tienen más de 40 productos.
Referencia: Production.Product
*/
SELECT
	Color,
	COUNT(Color) as 'Cantidad de productos'
FROM
	Production.Product
GROUP BY
	Color
HAVING
	COUNT(Color)>40
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
7. Se quiere saber la cantidad de empleados que existen por puestos, 
ordenados de mayor a menor 
y que hayan ingresado a la empresa en 1999.
Referencia: HumanResources.Employee
*/
SELECT
	JobTitle,
	count(LoginID) as 'Cantidad de Empleados'
FROM
	HumanResources.Employee E
WHERE
	YEAR(HireDate)=1999
GROUP BY
	JobTitle
ORDER BY
	'Cantidad de Empleados' DESC
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
a. Se quiere obtener ahora la cantidad de empleados que existen por puestos, 
ordenados de mayor a menor 
y que hayan ingresado a la empresa a partir del año 2000, 
exceptuando el año 2002. 
Obtener únicamente los puestos con cantidades mayores a 1.
*/
SELECT
	JobTitle,
	count(LoginID) as 'Cantidad de Empleados'
FROM
	HumanResources.Employee E
WHERE
	YEAR(HireDate)>1999
	AND YEAR(HireDate)<>2002
GROUP BY
	JobTitle
HAVING
	count(LoginID)>1
ORDER BY
	'Cantidad de Empleados' DESC
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
8. Crear una consulta que muestre el número y nombre en una sola columna, 
separados por un guion 
para todos los productos de color ‘Black’. 
Poner alias Producto en la primera columna 
y usar la función correspondiente para concatenar texto.
Referencia: Production.Product
*/
SELECT
	CONCAT(ProductNumber,' - ',Name) AS 'Producto'
FROM
	Production.Product
WHERE
	Color='Black'
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
9. Escribir una consulta que muestre el pago histórico de los empleados 
y un incremento del 20% en 3 formatos diferentes, 
con las siguientes cabeceras 
“Sin formato”, 
“Redondeado a 1 dígito decimal”, 
“truncado a 1 dígito”. 
Usar función ROUND.
Referencia: HumanResources.EmployeePayHistory
*/
SELECT 
	BusinessEntityID,
	Rate,
	Rate * 1.20 AS 'Sin formato',
	ROUND((Rate * 1.20),1) AS 'Redondeado a 1 dígito decimal',
	ROUND((Rate * 1.20),1,1) AS 'Truncado a 1 dígito decimal'	
FROM
	HumanResources.EmployeePayHistory
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
10. Para cada Id de producto, 
se pide calcular su promedio de precio unitario en todas las ordenes que tengan más de 10 unidades,
esto debe mostrarse agrupado por ID de producto.
Referencia: Sales.SalesOrderDetail
*/
SELECT 
	ProductID,
	AVG(UnitPrice) AS 'PromedioPrecioUnitario'
FROM
	Sales.SalesOrderDetail
WHERE
	OrderQty>10
GROUP BY
	ProductID
ORDER BY
	ProductID
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
11. Cree un reporte el cual muestre todos los productos 
que tienen un precio unitario mayor o igual a 25 
y que el promedio de cantidades ordenadas de ese producto es mayor que 3. 
Ordénelo por ID de producto.
Referencia: Sales.SalesOrderDetail
*/
SELECT 
	ProductID,
	AVG(OrderQty) AS 'PromedioCantidadOrdenada'
FROM
	Sales.SalesOrderDetail s
WHERE
	UnitPrice>=25
GROUP BY
	ProductID
HAVING
	AVG(OrderQty)>3
ORDER BY
	ProductID
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
12. Obtener una lista con los nombres y apellidos de las personas 
que se llaman ‘Robert’, 
debiendo cambiar su nombre de ‘Robert’ a ‘Roberto’.
Referencia: Person.Person
*/
SELECT 
	REPLACE(FirstName,'Robert','Roberto') AS 'Nombre Modificado',
	LastName
FROM
	Person.Person
WHERE
	FirstName = 'Robert'
ORDER BY
	LastName
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
13. Crear una consulta que muestre en una sola columna el Apellido en mayúscula, 
seguido por una coma y seguido por el nombre tal cual figura en la base de datos 
de todas las personas. 
Agregarle el alias ‘Nombre completo’ a la columna.
Ejemplo: PEREZ, Juan
Referencia: Person.Person
*/
SELECT 	
	CONCAT(UPPER(LastName),', ',FirstName) AS 'Nombre completo'
FROM
	Person.Person
ORDER BY
	'Nombre completo'
;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
14. Obtener la diferencia en años entre la fecha de la última orden registrada en la base de datos 
y la fecha de hoy.
Referencias:
• Sales.SalesOrderHeader
• Utilizar MAX con OrderDate
• GETDATE()
• DATEDIFF
*/
SELECT 	
	DATEDIFF(year,MAX(OrderDate),GETDATE()) AS 'Diferencia de años desde ultima orden'
FROM
	Sales.SalesOrderHeader
;
-- ----------------------------------------------------------------------------------------------