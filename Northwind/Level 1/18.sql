-- Write a select statement to select the order number, order date, and customer number for all unfulfilled orders for which the recipient country is Argentina

SELECT OrderID, OrderDate, c.CustomerID
FROM Orders AS o
JOIN Customers AS c 
ON c.CustomerID=o.CustomerID
WHERE c.Country = 'Argentina'
AND o.ShippedDate > GETDATE() OR o.ShippedDate IS NULL