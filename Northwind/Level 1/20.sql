-- Select product information (category, name, price), sort products by categories and within categories in descending order by price.

SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID ASC, UnitPrice DESC