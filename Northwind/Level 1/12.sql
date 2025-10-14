-- We are looking for information about products sold in bottles.

SELECT *
FROM Products 
WHERE QuantityPerUnit LIKE '%bottle%'