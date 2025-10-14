-- Select product names and stock information for products supplied by Tokyo Traders

SELECT ProductName, UnitsInStock
FROM Products AS p
JOIN 
Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE s.CompanyName LIKE 'Tokyo Traders'