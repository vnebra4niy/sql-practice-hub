-- Search for information about the positions of employees whose names begin with letters from B to L.

SELECT Title, FirstName, LastName
FROM Employees
WHERE LastName BETWEEN 'B' AND 'L'
ORDER BY LastName