-- Specify the maximum price for products priced below $20.

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (
    SELECT MAX(UnitPrice)
    FROM Products
    WHERE UnitPrice < 20
)