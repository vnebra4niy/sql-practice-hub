-- Specify the number of products priced less than $10 or more than $20.

SELECT COUNT(ProductID) AS ProductCount
FROM Products
WHERE UnitPrice < 10 OR UnitPrice > 20