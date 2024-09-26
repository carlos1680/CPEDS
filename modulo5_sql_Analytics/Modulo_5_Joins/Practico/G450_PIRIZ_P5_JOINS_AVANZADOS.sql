-- G450_PIRIZ_P5_JOINS_AVANZADOS
/*
1. Escriba un consulta que despliegue los 
nombres de los clientes y los nombres de los productos comprados, ordenado por cliente.
Referencias: Customer, Person, SalesOrderHeader, SalesOrderDetail, Product
*/
SELECT
	DISTINCT
	P.BusinessEntityID,
	P.FirstName,
	P.LastName,
	PR.Name
FROM 
	Sales.Customer AS C
	INNER JOIN Person.Person P ON C.PersonID = P.BusinessEntityID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID = SOH.CustomerID
	INNER JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Production.Product AS PR ON SOD.ProductID = PR.ProductID
ORDER BY
	P.BusinessEntityID;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
2. Listar los productos que nunca han sido ordenados.
Referencias: Product, SalesOrderDetail
*/
SELECT
	P.ProductID,
	P.Name
FROM
	Production.Product AS P
	LEFT JOIN Sales.SalesOrderDetail AS SOD ON  P.ProductID = SOD.ProductID
WHERE
	SOD.ProductID IS NULL;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
3. Escriba una consulta que despliegue 
la cantidad vendida de cada producto por día de venta, 
ordenado por ID de producto y cantidad vendida de mayor a menor.
Referencias: SalesOrderHeader, SalesOrderDetail, Product
*/
SELECT
	SUM(SOD.OrderQty) AS 'CANTIDAD',
	P.ProductID,
	SOH.OrderDate
FROM 
	Production.Product AS P
	INNER JOIN Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
	INNER JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY
	P.ProductID,
	SOH.OrderDate
ORDER BY
	P.ProductID, SUM(SOD.OrderQty) DESC;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
4. Obtener el ID, el nombre y la cantidad de los 10 productos 
más vendidos en Marzo de 2003, 
ordenados por cantidad vendida de forma decreciente.
Referencias: Product, SalesOrderDetail, SalesOrderHeader
*/
SELECT TOP 10
	P.ProductID,
	P.NAME,
	SUM(SOD.OrderQty) AS 'CANTIDAD'
FROM 
	Production.Product AS P
	INNER JOIN Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
	INNER JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE
	YEAR(SOH.OrderDate)=2003 
	AND  MONTH(SOH.OrderDate)=3
GROUP BY
	P.ProductID,
	P.NAME
ORDER BY
	SUM(SOD.OrderQty) DESC;
-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------
/*
5. Se desea obtener un reporte 
con la identificación de la orden y 
la cantidad de productos que fueron vendidos (por venta) 
y que en el nombre de su modelo esté la palabra “mountain”.
Referencias: Product, SalesOrderDetail, SalesOrderHeader, ProductModel
*/
SELECT 
	SOH.SalesOrderID,
	SUM(SOD.OrderQty) AS CANTIDAD
FROM
	Production.Product AS P
	INNER JOIN Production.ProductModel AS PM ON P.ProductModelID = PM.ProductModelID
	INNER JOIN Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
	INNER JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE
	PM.Name LIKE '%mountain%'
GROUP BY
	SOH.SalesOrderID
order by 2 desc ;