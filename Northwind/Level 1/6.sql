-- Select the names and addresses of all customers based in London.

SELECT ContactName, Address
FROM Customers
WHERE City LIKE 'London'