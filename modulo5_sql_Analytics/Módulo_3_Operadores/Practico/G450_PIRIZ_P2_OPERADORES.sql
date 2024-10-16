-- G450_Piriz_P2_Operadores
-- --------------------------------------------------------------------
/*
Ej. 1
i) Obtener el id y el nombre de todos los productos.
Referencia: Production.Product
*/
SELECT
	ProductID,
	Name
FROM
	Production.Product;
-- --------------------------------------------------------------------
/*
Ej. 1
ii) Obtener el id, el nombre y el precio de lista de todos los productos cuyo precio de
Lista es mayor o igual a 100.
Referencia: Production.Product
*/
SELECT
	ProductID,
	Name,
	ListPrice
FROM
	Production.Product
WHERE
	ListPrice>=100;
-- --------------------------------------------------------------------
/*
Ej. 1
iii) Obtener el id y el nombre de los productos cuyo precio de lista es igual a 0 (cero).
Referencia: Production.Product
*/
SELECT
	ProductID,
	Name
FROM
	Production.Product
WHERE
	ListPrice=0;
-- --------------------------------------------------------------------
/*
Ej. 1
iv) Obtener el n�mero de producto, el nombre y el precio de lista de todos los
productos cuyo precio de Lista sean 4.99, 9.50 o 13.99.
Referencia: Production.Product
*/
SELECT
	ProductNumber,
	Name,
	ListPrice
FROM
	Production.Product
WHERE
	ListPrice in (4.99,9.50,13.99);
-- --------------------------------------------------------------------
/*
Ej. 1
v) Obtener todos los datos de las empleadas (sexo femenino) y de estado civil
solteras.
Referencia: HumanResources.Employee
*/
SELECT
	*
FROM
	HumanResources.Employee
WHERE
	Gender='F' and MaritalStatus='S';	
-- --------------------------------------------------------------------
/*
Ej. 2
Escriba una consulta que devuelva los n�meros de los productos que comiencen con
�BB�.
Referencia: Production.Product

*/
SELECT
	ProductNumber
FROM
	Production.Product
WHERE
	ProductNumber like 'BB%';	
-- --------------------------------------------------------------------
/*
Ej. 2
a. Obtener adem�s el precio de lista de los productos anteriores, pero s�lo los que
tienen precio mayor a 100.
*/
SELECT
	ProductNumber,
	ListPrice
FROM
	Production.Product
WHERE
	ProductNumber like 'BB%'
	and ListPrice>100;	
-- --------------------------------------------------------------------
/*
Ej. 3
Se desea obtener la lista de LoginID y cargo de los empleados que son supervisores
(que en alguna parte de su JobTitle diga �Supervisor�)
Referencia: HumanResources.Employee
*/
SELECT
	LoginID,
	JobTitle
FROM
	HumanResources.Employee
WHERE
	JobTitle like '%Supervisor%';	
-- --------------------------------------------------------------------
/*
Ej. 3
a. Ahora obtenga los mismos datos de las personas que no sean supervisores.
*/
SELECT
	LoginID,
	JobTitle
FROM
	HumanResources.Employee
WHERE
	not JobTitle like '%Supervisor%';	
-- --------------------------------------------------------------------
/*
Ej. 4
Obtener el nombre y el apellido de las personas cuyo apellido comienza con una vocal.
Referencia: Person.Person
*/
SELECT
	FirstName,
	LastName
FROM
	Person.Person
WHERE
	LastName like '[aeiou]%';	
-- --------------------------------------------------------------------
/*
Ej. 4
a. Ahora obtenga los mismos datos de las personas cuyo apellido no comienza con
una vocal.
*/
SELECT
	FirstName,
	LastName
FROM
	Person.Person
WHERE
	not LastName like '[aeiou]%';	
-- --------------------------------------------------------------------
/*
Ej. 5
Crear una consulta que muestre los empleados (LoginID) y su cargo, cuyo login
comience con la letra �k� (Posici�n 17). Utilizar la tabla: HumanResources.Employee y
columna: LoginID
*/
SELECT
	LoginID,
	JobTitle
FROM
	HumanResources.Employee
WHERE
	LoginId like '________________k%';	
-- --------------------------------------------------------------------
/*
Ej. 6. Obtener los datos de los empleados que son el 50% del total de empleados de la
empresa.
Referencia: HumanResources.Employee
*/
SELECT TOP 50 PERCENT
	*
FROM
	HumanResources.Employee;	
-- --------------------------------------------------------------------
/*
Ej. 7. El departamento de marketing necesita una lista de los 15 productos m�s caros
ordenados de forma descendente.
Referencia: Production.Product
La consulta debe incluir los campos �ProductNumber�, �ListPrice� y �Name�.
*/
SELECT TOP 15
	ProductNumber,
	ListPrice,
	Name
FROM
	Production.Product
ORDER BY
	ListPrice desc;
-- El producto mas caro es:
-- El producto en la posicion 15 es: 
/*
-- La consulta seria:
SELECT TOP 15
	ProductNumber,
	ListPrice,
	Name
FROM
	Production.Product
WHERE
	ListPrice<>0
ORDER BY
	ListPrice ;
*/
-- --------------------------------------------------------------------
/*
Ej. 8.
Obtener todos los apellidos de las personas de la base de datos.
Referencia: Person.Person
*/
SELECT
	LastName
FROM
	Person.Person;
*/
-- --------------------------------------------------------------------
/*
Ej. 8.
a. Obtener ahora todos los apellidos distintos de las personas de la base de datos.
Referencia: Person.Person
*/
SELECT DISTINCT
	LastName
FROM
	Person.Person;
*/
-- --------------------------------------------------------------------
/*
Ej. 9.
. Obtener todos los productos cuyo precio de lista est� entre 100 y 200, y su n�mero de
producto comience con �SA�, ordenados por precio de lista de manera ascendente.
Referencia: Production.Product
*/
SELECT DISTINCT
	*
FROM
	Production.Product
WHERE
	ListPrice between 100 and 200
	and ProductNumber like 'SA%'
ORDER BY
	ListPrice;

-- --------------------------------------------------------------------
/*
Ej. 10.
Utilizando los operadores IN o NOT IN:
a. Traer los datos de todos los empleados, salvo los que Tienen horas de vacaciones
76,84,85,86,87,89,90
*/
SELECT DISTINCT
	*
FROM
	HumanResources.Employee 
WHERE
	NOT VacationHours IN (76,84,85,86,87,89,90);

-- --------------------------------------------------------------------
/*
Ej. 10.
b. Traer los datos de los empleados que tienen 30 o 50 horas de vacaciones
*/
SELECT DISTINCT
	*
FROM
	HumanResources.Employee 
WHERE
	VacationHours IN (30,50);

-- --------------------------------------------------------------------
/*
Ej. 11.
Obtener el nombre del producto, su precio de lista y una nueva columna que calcule
el IVA (22%) del producto (colocarle el siguiente alias a la columna: IVA), de los
productos cuyo precio de lista sea distinto de 0 (cero).
Referencia: Production.Product

*/
SELECT DISTINCT
	Name,
	ListPrice,
	ListPrice * 0.22 AS 'IVA'	
FROM
	Production.Product
WHERE
	ListPrice<>0;

-- --------------------------------------------------------------------
/*
Ej. 11.
a. A la consulta anterior agregarle otra columna que calcule la diferencia entre el
precio de lista y el costo est�ndar (colocarle el siguiente alias a la columna:
�Diferencia entre precios�), adem�s ordenar los resultados por esta �ltima
columna de mayor a menor.

*/
SELECT DISTINCT
	Name,
	ListPrice,
	ListPrice * 0.22 AS 'IVA',
	ListPrice - StandardCost as 'Diferencia entre precios'
FROM
	Production.Product
WHERE
	ListPrice<>0
ORDER BY
	'Diferencia entre precios' DESC;

-- --------------------------------------------------------------------