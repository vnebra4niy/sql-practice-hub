-- Calculate the average unit price for all products in the products table.

SELECT AVG(UnitPrice) AS 'Average price'
FROM Products;

-- Sum all values in the quantity column in the order details table.

SELECT SUM(Quantity) AS 'Total products'
FROM [Order Details];

-- Specify the number of products priced less than $10 or more than $20.

SELECT COUNT(ProductID) AS ProductCount
FROM Products
WHERE UnitPrice < 10 OR UnitPrice > 20;

-- Specify the maximum price for products priced below $20.

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (
    SELECT MAX(UnitPrice)
    FROM Products
    WHERE UnitPrice < 20
);

-- Provide the maximum, minimum, and average price of the product for products sold in bottles.

SELECT MAX(UnitPrice) AS 'max', MIN(UnitPrice) AS 'min', AVG(UnitPrice) AS 'average'
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

-- List information about all products with a price above average.

SELECT *
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice)
    FROM Products
);

-- Specify the total amount of order number 10250.

SELECT SUM(UnitPrice*Quantity*(1-Discount)) AS 'total amount'
FROM [Order Details]
WHERE OrderID = 10250;

-- Write a command that returns information about orders from the order details table. The query should group and
-- display the ID of each product and then calculate the total quantity ordered. The total quantity is summed
-- using the SUM aggregate function and displayed as a single value for each product.

SELECT ProductID, SUM(Quantity) AS 'Total Quantity'
FROM [Order Details]
GROUP BY ProductID;

-- Specify the maximum price of the product ordered for each order.

SELECT OrderID, MAX(UnitPrice) AS 'Max Unit Price'
FROM [Order Details]
GROUP BY OrderID;

-- Sort orders by maximum product price

SELECT OrderID, MAX(UnitPrice) AS 'Max Unit Price'
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice) ASC;

-- Provide the maximum and minimum price of the ordered product for each order.

SELECT OrderID, MAX(UnitPrice) AS 'Max Unit Price', MIN(UnitPrice) AS 'Min Unit Price'
FROM [Order Details]
GROUP BY OrderID
ORDER BY  MIN(UnitPrice) ASC, MAX(UnitPrice) ASC;

-- State the number of orders delivered by individual carriers.

SELECT ShipVia, COUNT(OrderID) AS 'Number of orders delivered by each carrier'
FROM Orders
GROUP BY ShipVia;

-- Which of the shippers was the most active in 1997?

SELECT ShipVia, COUNT(OrderID) AS 'Total Orders in 1997'
FROM Orders
WHERE ShippedDate LIKE '%1997%'
GROUP BY ShipVia
ORDER BY COUNT(OrderID) DESC;

-- Display orders for which the number of order items is greater than 5

SELECT OrderID, COUNT(OrderID) AS 'Total Amount of Products'
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(OrderID)>5;

-- Display customers for whom more than 8 orders were completed in 1998 (sort results
-- in descending order by total amount for delivery of orders for each customer

SELECT CustomerID, COUNT(OrderID) AS 'Total Orders'
FROM Orders
WHERE ShippedDate LIKE '%1998%'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 8
ORDER BY COUNT(OrderID) DESC;