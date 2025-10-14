-- Sort orders by maximum product price

SELECT OrderID, MAX(UnitPrice) AS 'Max Unit Price'
FROM [Order Details]
GROUP BY OrderID
ORDER BY MAX(UnitPrice) ASC