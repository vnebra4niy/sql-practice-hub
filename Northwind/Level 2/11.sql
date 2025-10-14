-- Provide the maximum and minimum price of the ordered product for each order.

SELECT OrderID, MAX(UnitPrice) AS 'Max Unit Price', MIN(UnitPrice) AS 'Min Unit Price'
FROM [Order Details]
GROUP BY OrderID
ORDER BY  MIN(UnitPrice) ASC, MAX(UnitPrice) ASC