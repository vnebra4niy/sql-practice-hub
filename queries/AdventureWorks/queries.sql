--1. Wyświetlić nazwy produktów, dla których są zdefiniowane poszczególne elementy:
--a. Kolor

SELECT Production.Product.Name FROM Production.Product
WHERE Production.Product.Color IS NOT NULL;

--b. Waga

SELECT Production.Product.Name FROM Production.Product
WHERE Production.Product.Weight IS NOT NULL;

--c. Rozmiar

SELECT Production.Product.Name FROM Production.Product
WHERE Production.Product.Size IS NOT NULL;

--2. Wyświetlić nazwę najleżjszego i najcięższego produktu zawierającego w nazwie „Road”.

SELECT Name, Weight
FROM Production.Product
WHERE Name LIKE '%Road%' AND Weight IS NOT NULL
AND (
    Weight = (SELECT MIN(Weight) FROM Production.Product WHERE Name LIKE '%Road%' AND Weight IS NOT NULL)
    OR
    Weight = (SELECT MAX(Weight) FROM Production.Product WHERE Name LIKE '%Road%' AND Weight IS NOT NULL)
);

--3. Wyświetlić produkty, których cena jest wyższa od średniej.

SELECT Name, Weight
FROM Production.Product
WHERE Weight > (SELECT AVG(Weight) FROM Production.Product)
ORDER BY Weight ASC;

--4. Wyświetlić średnią cenę produktu w zależności od kategorii (pole [Production].[ProductCategory]).
--Do wykonania poprawnego złączenia wykorzystać tabelę ProductSubcategory.

SELECT 
    pc.Name AS CategoryName,
    AVG(p.ListPrice) AS AveragePrice
FROM Production.Product p
INNER JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice IS NOT NULL
GROUP BY pc.Name
ORDER BY pc.Name;

--5. Wyświetlić imiona i nazwiska wszystkich klientów wraz z łączną sumą dokonanych przez nich
--zakupów (do określenia sumy użyć kolumny SalesOrderHeader.SubTotal). Lista ma być posortowana
--malejąco względem łącznej sumy zakupów.

SELECT 
    Person.FirstName,
    Person.LastName,
    SUM(SalesOrderHeader.SubTotal) AS TotalSpent
FROM Sales.SalesOrderHeader
INNER JOIN Sales.Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID
INNER JOIN Person.Person ON Customer.PersonID = Person.BusinessEntityID
WHERE Person.PersonType = 'SC'
GROUP BY Person.FirstName, Person.LastName
ORDER BY TotalSpent DESC;

--6. Wyświetlić imiona i nazwiska wszystkich sprzedawców wraz z łączną sumą dokonanych przez nich
--sprzedaży (do określenia sumy użyć kolumny SalesOrderHeader.SubTotal). Lista ma być posortowana
--malejąco względem łącznej sumy sprzedaży.

SELECT 
    Person.FirstName,
    Person.LastName,
    SUM(SalesOrderHeader.SubTotal) AS TotalSpent
FROM Sales.SalesOrderHeader
INNER JOIN Sales.SalesPerson ON SalesOrderHeader.SalesPersonID=SalesPerson.BusinessEntityID
INNER JOIN Person.Person ON SalesPerson.BusinessEntityID = Person.BusinessEntityID
GROUP BY Person.FirstName, Person.LastName
ORDER BY TotalSpent DESC;

--7. Wyświetlić kategorie, podkategorie, imiona i nazwiska sprzedawców oraz średnią zniżkę na
--produkty (względem pod kategorii) jakiej udzielił klientom sprzedawca. Wyświetlić tylko i wyłącznie
--te wiersze w których średnia zniżka jest większa od zera

SELECT Production.ProductCategory.Name AS 'Category Name', ProductSubcategory.Name AS 'Subcategory', Person.FirstName, Person.LastName, AVG(SalesOrderDetail.UnitPriceDiscount) AS 'Average Discount' FROM Production.ProductSubcategory
INNER JOIN Production.ProductCategory ON ProductCategory.ProductCategoryID=ProductSubcategory.ProductCategoryID
INNER JOIN Production.Product ON Product.ProductSubcategoryID=ProductSubcategory.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail ON SalesOrderDetail.ProductID=Product.ProductID
INNER JOIN Sales.SalesOrderHeader ON SalesOrderHeader.SalesOrderID=SalesOrderDetail.SalesOrderID
INNER JOIN Sales.SalesPerson ON SalesPerson.BusinessEntityID=SalesOrderHeader.SalesPersonID
INNER JOIN Person.Person ON Person.BusinessEntityID=SalesPerson.BusinessEntityID
GROUP BY Production.ProductCategory.Name, ProductSubcategory.Name, SalesPerson.BusinessEntityID, Person.FirstName, Person.LastName
HAVING AVG(SalesOrderDetail.UnitPriceDiscount) > 0
ORDER BY Production.ProductCategory.Name;