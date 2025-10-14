-- Select the names and countries of all customers based in Japan or Italy, sort the results by country, and sort the company names alphabetically within each country.

SELECT ContactName, CompanyName, Country
FROM Customers
WHERE Country LIKE 'Japan' OR Country LIKE 'Italy'
ORDER BY Country, CompanyName ASC