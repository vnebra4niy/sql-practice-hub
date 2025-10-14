-- Sum all values in the quantity column in the order details table.

SELECT SUM(Quantity) AS 'Total products'
FROM [Order Details]