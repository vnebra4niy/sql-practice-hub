-- Sort the names and countries of all customers, sort the results by country, and within each country, sort the company names alphabetically.

SELECT *
FROM Customers
ORDER BY Country ASC, CompanyName ASC