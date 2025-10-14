-- Select the names and addresses of all customers based in France or Spain.

SELECT ContactName, Address
FROM Customers
WHERE Country LIKE 'France'
OR Country like 'Spain'