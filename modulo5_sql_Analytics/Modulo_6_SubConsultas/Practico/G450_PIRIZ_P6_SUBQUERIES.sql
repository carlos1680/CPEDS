-- G450_PIRIZ_P6_SUBQUERIES
-- --------------------------------------------------------------------------------------------
/*
1. Escriba una consulta que muestre los productos que tienen el mismo color que el 
producto de nombre ‘Chain’. 
Excluir al producto ‘Chain’ del listado.
*/
SELECT	
	P.Name,
	P.Color
FROM
	Production.Product AS P
WHERE
	P.Color IN
	(
		SELECT 
			PP.COLOR
		FROM
			Production.Product as PP
		WHERE 
			PP.Name = 'Chain'
	)
	and NOT P.ProductID in 
	(
		SELECT 
			PPP.ProductID
		FROM
			Production.Product AS PPP
		WHERE
			PPP.Name ='Chain'

	);
-- --------------------------------------------------------------------------------------------
/*
2. Escriba una consulta que muestre los productos cuyo precio estén por encima del 
precio promedio general, ordenar el resultado por precio del producto en forma 
ascendente
*/
SELECT 
	P.Name,P.ListPrice
FROM
	Production.Product AS P
WHERE
	P.ListPrice>
	(
		SELECT 
			AVG(PP.ListPrice)
		FROM
			Production.Product AS PP
	)
ORDER BY
	2;
-- --------------------------------------------------------------------------------------------
/*
3. Utilizando Subconsultas, Escriba una consulta que muestre los productos que 
pertenecen a la misma categoría a la que pertenece el producto “Road-150 Red, 62”.
*/
SELECT
	PP.*
FROM
	Production.Product AS PP	
WHERE
	PP.ProductSubcategoryID IN 
	(
		SELECT 
			PS_2.ProductSubcategoryID
		FROM
			Production.ProductSubcategory AS PS_2
		WHERE
			PS_2.ProductCategoryID IN
			(
				select			
					PS.ProductCategoryID
				FROM 
					Production.ProductSubcategory AS PS
				WHERE
					PS.ProductSubcategoryID IN
					(
						SELECT
							P.ProductSubcategoryID
						FROM
							Production.Product AS P
						WHERE
							P.Name = 'Road-150 Red, 62'
					)
			)
	);
-- --------------------------------------------------------------------------------------------
/*
4. Mostrar todos los productos que hayan tenido ventas en el año 2003. 
Utilizar las tablas: 
Production.Product 
Production.TransactionHistory Columna: TransactionDate
*/
SELECT
	P.Name
FROM
	Production.Product AS P
WHERE
	P.ProductID IN
	(
		SELECT
			TH.ProductID
		FROM
			Production.TransactionHistory TH
		WHERE
			YEAR(TH.TransactionDate)=2003
		GROUP BY
			TH.ProductID
	);
-- --------------------------------------------------------------------------------------------
/*
5. Mostrar el nombre y apellido de los clientes (Personas) 
que hayan comprado 
al menos una unidad del/los producto/s con menor precio (distinto de 0). 
Utilizar las tablas: 
Production.Product -> ListPrice 
Sales.SalesOrderDetail 
Sales.SalesOrderHeader 
Sales.Customer 
Person.Person
*/
SELECT	
	P.FirstName,
	P.LastName
FROM
	Person.Person AS P
WHERE
	P.BusinessEntityID IN
	(
		SELECT DISTINCT
			C.PersonID
		FROM
			SALES.Customer AS C
		WHERE 
			C.CustomerID IN
			(
				SELECT DISTINCT
					SOH.CustomerID
				FROM
					Sales.SalesOrderHeader AS SOH
				WHERE
					SOH.SalesOrderID IN 
					(
						SELECT DISTINCT
							SOD.SalesOrderID
						FROM
							Sales.SalesOrderDetail SOD
						WHERE
							SOD.OrderQty>0
							AND SOD.ProductID IN
							(
								SELECT DISTINCT
									PP.ProductID
								FROM
									Production.Product AS PP
								WHERE
									PP.ListPrice = 
									(
										SELECT
											MIN(PPP.ListPrice)
										FROM 
											Production.Product AS PPP
										WHERE
											PPP.ListPrice<>0
									)
							)							
					)					
			)
	);
-- --------------------------------------------------------------------------------------------
/*
6. Listar CustomerID, SalesOrderID, y OrderDate de todas las ordenes de aquellos 
clientes que por le menos han realizado 5 órdenes. 
Realizar la misma consulta con Subquery.
*/
SELECT
	SOH1.CustomerID,
	SOH1.SalesOrderID,
	SOH1.OrderDate
FROM
	Sales.SalesOrderHeader SOH1
WHERE
	SOH1.CustomerID IN
	(
		SELECT
			SOH.CustomerID
		FROM
			Sales.SalesOrderHeader SOH
		GROUP BY
			SOH.CustomerID
		HAVING
			COUNT(SOH.SalesOrderID)>4
	);
-- --------------------------------------------------------------------------------------------
/*
7. Listar FirstName, LastName, HireDate, JobTitle y la cantidad de empleados con el 
mismo título.
*/

SELECT	
	P.FirstName,
	P.LastName,
	E.JobTitle,
	E.HireDate,
	(SELECT COUNT(EE.BusinessEntityID) FROM HumanResources.Employee EE WHERE EE.JobTitle=E.JobTitle) AS 'CANTIDAD_EMPLEADOS_CON_MISMO_TITULO'
FROM
	PERSON.Person AS P
	JOIN HumanResources.Employee AS E ON P.BusinessEntityID = E.BusinessEntityID
ORDER BY
	5 DESC,4 DESC,1,2;
