-- Select the names and prices of products from the ‘seafood’ category.

SELECT ProductName, UnitPrice
FROM Products AS p
JOIN 
Categories ON p.CategoryID = Categories.CategoryID
WHERE CategoryName LIKE 'seafood'