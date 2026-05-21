-- Select the names and addresses of all customers

SELECT ContactName, Address
FROM Customers;

-- Select the employee names and phone numbers

SELECT FirstName, LastName, HomePhone
FROM Employees;

-- Select product names and prices

SELECT ProductName, UnitPrice
FROM Products;

-- Show all product categories (names and descriptions)

SELECT CategoryName, Description 
FROM Categories;

-- Show names and addresses of suppliers' websites

SELECT ContactName, Address, HomePage
FROM Suppliers
WHERE HomePage IS NOT NULL;

-- Select the names and addresses of all customers based in London.

SELECT ContactName, Address
FROM Customers
WHERE City LIKE 'London';

-- Select the names and addresses of all customers based in France or Spain.

SELECT ContactName, Address
FROM Customers
WHERE Country LIKE 'France'
OR Country like 'Spain';

-- Select product names and prices with a unit price between 20.00 and 30.00.

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice between 20.00 and 30.00;

-- Select the names and prices of products from the ‘seafood’ category.

SELECT ProductName, UnitPrice
FROM Products AS p
JOIN 
Categories ON p.CategoryID = Categories.CategoryID
WHERE CategoryName LIKE 'seafood';

-- Select product names and stock information for products supplied by Tokyo Traders

SELECT ProductName, UnitsInStock
FROM Products AS p
JOIN 
Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE s.CompanyName LIKE 'Tokyo Traders';

-- Select the names of products that are out of stock

SELECT ProductName
FROM Products 
WHERE UnitsInStock = 0;

-- We are looking for information about products sold in bottles.

SELECT *
FROM Products 
WHERE QuantityPerUnit LIKE '%bottle%';

-- Search for information about the positions of employees whose names begin with letters from B to L.

SELECT Title, FirstName, LastName
FROM Employees
WHERE LastName BETWEEN 'B' AND 'L'
ORDER BY LastName;

-- Search for information about employees whose names begin with the letter B or L.

SELECT Title, FirstName, LastName
FROM Employees
WHERE LastName LIKE 'B%'
OR LastName LIKE 'L%'
ORDER BY LastName;

-- Find category names that contain a comma in their description.

SELECT CategoryName, Description
FROM Categories
WHERE Description LIKE '%,%';

-- We are looking for information about products priced less than 10 or more than 20.

SELECT *
FROM Products
WHERE UnitPrice > 20 
OR UnitPrice < 10;

-- Write a select statement to select the order number, order date, and customer number for all unfulfilled orders for which the recipient country is Argentina

SELECT OrderID, OrderDate, c.CustomerID
FROM Orders AS o
JOIN Customers AS c 
ON c.CustomerID=o.CustomerID
WHERE c.Country = 'Argentina'
AND o.ShippedDate > GETDATE() OR o.ShippedDate IS NULL;

-- Sort the names and countries of all customers, sort the results by country, and within each country, sort the company names alphabetically.

SELECT *
FROM Customers
ORDER BY Country ASC, CompanyName ASC;

-- Select product information (category, name, price), sort products by categories and within categories in descending order by price.

SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID ASC, UnitPrice DESC;

-- Select the names and countries of all customers based in Japan or Italy, sort the results by country, and sort the company names alphabetically within each country.

SELECT ContactName, CompanyName, Country
FROM Customers
WHERE Country LIKE 'Japan' OR Country LIKE 'Italy'
ORDER BY Country, CompanyName ASC;