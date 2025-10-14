-- Specify the total amount of order number 10250.

SELECT SUM(UnitPrice*Quantity*(1-Discount)) AS 'total amount'
FROM [Order Details]
WHERE OrderID = 10250