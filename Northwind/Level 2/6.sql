-- List information about all products with a price above average.

SELECT *
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice)
    FROM Products
)