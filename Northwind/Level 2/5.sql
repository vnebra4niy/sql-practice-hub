-- Provide the maximum, minimum, and average price of the product for products sold in bottles.

SELECT MAX(UnitPrice) AS 'max', MIN(UnitPrice) AS 'min', AVG(UnitPrice) AS 'average'
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%' 