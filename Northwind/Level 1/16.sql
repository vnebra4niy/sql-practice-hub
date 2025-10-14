-- Find customers who have the word .Store somewhere in their name.

SELECT *
FROM Customers
WHERE CompanyName LIKE '%store%'