--Level 3
--1. Napisz polecenie zwracające nazwy produktów i firmy je dostarczające (tak aby produkty bez dostarczycieli i
--dostarczyciele. bez produktów nie pojawiali się w wyniku).

SELECT products.ProductName, Suppliers.CompanyName
FROM products
INNER JOIN Suppliers ON products.SupplierID=Suppliers.SupplierID;

--2. Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po 01 marca 1998

SELECT DISTINCT orders.CustomerID, Customers.ContactName 
FROM orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
WHERE orders.OrderDate>'1998-03-01';

--3. Napisz polecenie zwracające wszystkich klientów z datami zamówień.

SELECT Customers.CustomerID, orders.OrderDate FROM orders
INNER JOIN Customers ON orders.CustomerID=Customers.CustomerID
ORDER BY Customers.CustomerID ASC;

--4. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane
--adresowe dostawcy.

SELECT products.ProductName, Products.UnitPrice, Suppliers.Address FROM Products
INNER JOIN Suppliers ON products.SupplierID=Suppliers.SupplierID
WHERE products.UnitPrice BETWEEN 20 AND 30;

--5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę Tokyo Traders.

SELECT products.ProductName, products.UnitsInStock, products.UnitsOnOrder, Suppliers.CompanyName FROM products
INNER JOIN Suppliers ON products.SupplierID=suppliers.SupplierID
WHERE suppliers.CompanyName = 'Tokyo Traders';

--6. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie

SELECT products.ProductName, Suppliers.CompanyName, Suppliers.Phone from Suppliers
INNER JOIN products ON Suppliers.SupplierID=Products.SupplierID
WHERE Products.UnitsInStock=0;

--7. Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08.

SELECT DISTINCT products.ProductName FROM Orders
INNER JOIN [Order Details] ON orders.OrderID=[Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID=Products.ProductID
WHERE Orders.OrderDate='1996-07-08';

--8. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane
--adresowe dostawcy, interesują nas tylko produkty z kategorii Meat/Poultry.

SELECT Products.ProductName, Products.UnitPrice, Suppliers.Address, Categories.CategoryName FROM Products
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID
WHERE Products.UnitPrice BETWEEN 20 AND 30
AND Categories.CategoryName='Meat/Poultry'
ORDER BY products.UnitPrice ASC;

--9. Wybierz nazwy i ceny produktów z kategorii Confections dla każdego produktu podaj nazwę dostawcy.

SELECT products.ProductName, products.UnitPrice, Suppliers.CompanyName FROM products
INNER JOIN Suppliers ON products.SupplierID=Suppliers.SupplierID
INNER JOIN Categories ON products.CategoryID=categories.CategoryID
WHERE Categories.CategoryName='Confections'
ORDER BY products.UnitPrice ASC;

--10. Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma United Package.

SELECT Customers.CompanyName, Customers.Phone, Orders.OrderDate FROM Customers
INNER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
INNER JOIN Shippers ON Orders.ShipVia=Shippers.ShipperID
WHERE YEAR(Orders.OrderDate)=1997 
AND Shippers.CompanyName='United Package';

--11. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.

SELECT DISTINCT Customers.CompanyName, Customers.Phone FROM Customers
INNER JOIN Orders ON Orders.CustomerID=Customers.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
INNER JOIN Products ON products.ProductID=[Order Details].ProductID
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID
WHERE Categories.CategoryName='Confections';

--12. Napisz polecenie, które pokazuje pary pracowników zajmujących to samo stanowisko

SELECT A.EmployeeID, A.FirstName, B.EmployeeID, B.FirstName FROM Employees A
INNER JOIN Employees B ON A.Title=B.Title
WHERE A.EmployeeID<B.EmployeeID;

--13. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych

SELECT B.EmployeeID, B.FirstName, A.EmployeeID, A.FirstName FROM Employees A
INNER JOIN Employees B ON A.ReportsTo=B.EmployeeID;

--14. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych

SELECT EmployeeID, FirstName FROM Employees
WHERE EmployeeID NOT IN (
	SELECT DISTINCT ReportsTo
	FROM Employees
	WHERE ReportsTo IS NOT NULL
);