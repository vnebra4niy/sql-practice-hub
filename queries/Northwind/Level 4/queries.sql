--Level 4
--1. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki
--dostarczała firma United Package.

SELECT DISTINCT Customers.CompanyName, Customers.Phone FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN Shippers ON Shippers.ShipperID=Orders.ShipVia
WHERE Shippers.CompanyName='United Package';

--2. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
--Confections

SELECT DISTINCT Customers.CompanyName, Customers.Phone FROM Customers
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
INNER JOIN Products ON Products.ProductID=Products.ProductID
INNER JOIN Categories ON Categories.CategoryID=Products.CategoryID
WHERE Categories.CategoryName='Confections';

--3. Wybierz nazwy i numery telefonów klientów, którzy nie kupili żadnego produktu z
--kategorii .Confections.

SELECT Customers.CompanyName, Customers.Phone FROM Customers
WHERE Customers.CustomerID NOT IN (
    SELECT DISTINCT Orders.CustomerID FROM Orders
    INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
    INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
    INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
    WHERE Categories.CategoryName = 'Confections'
);

--4. Wybierz nazwy i numery telefonów klientów, którzy kupili więcej niż 3 różne
--produkty z kategorii .Confections.

SELECT Customers.CompanyName, Customers.Phone, COUNT(DISTINCT Products.ProductID) AS LiczbaRoznychProduktow
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Confections'
GROUP BY Customers.CompanyName, Customers.Phone
HAVING COUNT(DISTINCT Products.ProductID) > 3;

--5. Dla każdego produktu podaj maksymalną liczbę zamówionych jednostek

SELECT Products.ProductName, MAX(Quantity) AS 'Max Quantity in Order' FROM [Order Details]
INNER JOIN Products ON Products.ProductID=[Order Details].ProductID
GROUP BY Products.ProductName;

--6. Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu

SELECT Products.ProductName, Products.UnitPrice FROM Products
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products);

--7. Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu
--danej kategorii

SELECT P1.ProductName, P1.UnitPrice FROM Products P1
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products P2
WHERE P1.CategoryID=P2.CategoryID);

--8. Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich produktów
--oraz różnicę między ceną produktu a średnią ceną wszystkich produktów

SELECT 
	ProductName, 
	UnitPrice, 
	(SELECT AVG(UnitPrice) FROM Products) AS AvgPriceAllProducts, 
	UnitPrice - (SELECT AVG(UnitPrice) FROM Products) AS Difference
FROM Products;

--9. Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią
--cenę wszystkich produktów danej kategorii oraz różnicę między ceną produktu a średnią
--ceną wszystkich produktów danej kategorii.Podaj te informacje dla zamówienia o numerze 1025.

SELECT DISTINCT
	Categories.CategoryName, 
	P1.ProductName, 
	P1.UnitPrice,
	(SELECT AVG(P2.UnitPrice) FROM Products P2
	WHERE P1.CategoryID=P2.CategoryID) AS 'Average of Category',
	P1.UnitPrice - (SELECT AVG(P2.UnitPrice) FROM Products P2
	WHERE P1.CategoryID=P2.CategoryID) AS 'Difference between avg and product'
FROM Products P1
INNER JOIN Categories ON Categories.CategoryID=P1.CategoryID
INNER JOIN [Order Details] ON [Order Details].ProductID=P1.ProductID
WHERE [Order Details].OrderID=1025;

--10. Podaj łączną wartość zamówień każdego zamówienia (uwzględnij cenę za
--przesyłkę).

SELECT Orders.OrderID, SUM(([Order Details].UnitPrice*[Order Details].Quantity)*(1-[Order Details].Discount))+Orders.Freight FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Orders.OrderID, Orders.Freight;

--11. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli
--tak to pokaż ich dane adresowe.

SELECT DISTINCT Customers.CustomerID, Customers.Address FROM Customers
WHERE Customers.CustomerID NOT IN (
	SELECT Customers.CustomerID FROM Customers
	INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
	WHERE YEAR(Orders.OrderDate)='1997'
);

--12. Podaj produkty kupowane przez więcej niż jednego klienta

SELECT Products.ProductName, COUNT(DISTINCT Orders.CustomerID) FROM Products
INNER JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
INNER JOIN Orders ON Orders.OrderID=[Order Details].OrderID
GROUP BY Products.ProductName
HAVING COUNT(DISTINCT Orders.CustomerID)>1;

--13. Podaj produkty kupowane przez więcej niż 20 klientów

SELECT Products.ProductName, COUNT(DISTINCT Orders.CustomerID) FROM Products
INNER JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
INNER JOIN Orders ON Orders.OrderID=[Order Details].OrderID
GROUP BY Products.ProductName
HAVING COUNT(DISTINCT Orders.CustomerID)>20;

--14. Czy są jacyś klienci, którzy nie złożyli żadnego zamówienia w 1996 roku.

SELECT Customers.CustomerID, Customers.Address FROM Customers
WHERE Customers.CustomerID NOT IN (
	SELECT CustomerID FROM Orders
	WHERE YEAR(OrderDate)='1996'
);

--15. Dla każdego pracownika podaj jego imię i nazwisko oraz: całkowita liczbę
--zamówień, które obsłużyli z rozbiciem na lata, kwartały i miesiące

SELECT Employees.FirstName, Employees.LastName, YEAR(Orders.OrderDate) AS 'Year', DATEPART(quarter, Orders.OrderDate) AS 'Quarter', MONTH(Orders.OrderDate) AS 'Month', COUNT(Orders.OrderID) as 'Total Orders' FROM Employees
INNER JOIN Orders ON Employees.EmployeeID=Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName, YEAR(Orders.OrderDate), DATEPART(quarter, Orders.OrderDate), MONTH(Orders.OrderDate);

--16. Który z pracowników w 1997 r. obsłużył zamówienia o najwyższej wartości
--(wliczając rabat oraz opłatę za przesyłkę). Podaj jego imię i nazwisko.

SELECT TOP 1 Employees.FirstName, Employees.LastName FROM Orders
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE YEAR(Orders.OrderDate) = 1997
GROUP BY Orders.OrderID, Employees.FirstName, Employees.LastName, Orders.Freight
ORDER BY SUM([Order Details].UnitPrice * [Order Details].Quantity * (1 - [Order Details].Discount)) + Orders.Freight DESC;

--17. Czy są jacyś klienci, którzy w 1996 roku nie kupili produktu z kategorii
--'Confections'?

SELECT CustomerID, ContactName FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT O.CustomerID FROM Orders O
    INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    INNER JOIN Products P ON OD.ProductID = P.ProductID
    INNER JOIN Categories Cat ON P.CategoryID = Cat.CategoryID
    WHERE YEAR(O.OrderDate) = 1996
      AND Cat.CategoryName = 'Confections'
);

--18. Wyświetl pracowników, którzy nie mają podwładnych i liczbę obsłużonych przez
--każdego z nich zamówień w 1997.

SELECT Employees.EmployeeID, Employees.FirstName, COUNT(Orders.EmployeeID) AS 'Total Orders' FROM Employees
LEFT JOIN Orders ON Orders.EmployeeID=Employees.EmployeeID
WHERE Employees.EmployeeID NOT IN (
	SELECT DISTINCT ReportsTo
	FROM Employees
	WHERE ReportsTo IS NOT NULL
)
	AND YEAR(Orders.OrderDate)='1997'
GROUP BY Employees.EmployeeID, Employees.FirstName;

--19. Który klient zamówił produkty o największej łącznej wartości w 1996 roku - z
--rozbiciem na miesiące

SELECT 
    CustomerID,
    MONTH(OrderDate) AS MonthNum,
    SUM(OrderTotal) AS MonthlyTotal
FROM (
    SELECT 
        O.CustomerID,
        O.OrderDate,
        (SELECT SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) 
         FROM [Order Details] OD 
         WHERE OD.OrderID = O.OrderID) + O.Freight AS OrderTotal
    FROM Orders O
    WHERE YEAR(O.OrderDate) = 1996
) AS OrderValues
GROUP BY CustomerID, MONTH(OrderDate)
ORDER BY MonthNum ASC, MonthlyTotal DESC;

--20. Podaj dla każdego produktu z kategorii ‘Confections’ liczbę produktów
--zamówionych w marcu 1997.

SELECT Products.ProductName, SUM([Order Details].Quantity) FROM Products
INNER JOIN [Order Details] ON [Order Details].ProductID=Products.ProductID
INNER JOIN Orders ON Orders.OrderID=[Order Details].OrderID
INNER JOIN Categories ON Categories.CategoryID=Products.CategoryID
WHERE YEAR(Orders.OrderDate)=1997
	AND MONTH(Orders.OrderDate)=3
	AND Categories.CategoryName='Confections'
GROUP BY Products.ProductName;