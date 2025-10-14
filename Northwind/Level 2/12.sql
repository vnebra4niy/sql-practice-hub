-- State the number of orders delivered by individual carriers.

SELECT ShipVia, COUNT(OrderID) AS 'Number of orders delivered by each carrier'
FROM Orders
GROUP BY ShipVia