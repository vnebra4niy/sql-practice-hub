-- Search for information about employees whose names begin with the letter B or L.

SELECT Title, FirstName, LastName
FROM Employees
WHERE LastName LIKE 'B%'
OR LastName LIKE 'L%'
ORDER BY LastName