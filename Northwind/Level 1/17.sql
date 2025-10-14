-- We are looking for information about products priced less than 10 or more than 20.

SELECT *
FROM Products
WHERE UnitPrice > 20 
OR UnitPrice < 10