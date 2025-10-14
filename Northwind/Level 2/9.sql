-- Specify the maximum price of the product ordered for each order.

SELECT OrderID, MAX(UnitPrice) AS 'Max Unit Price'
FROM [Order Details]
GROUP BY OrderID