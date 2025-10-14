-- Which of the shippers was the most active in 1997?

SELECT ShipVia, COUNT(OrderID) AS 'Total Orders in 1997'
FROM Orders
WHERE ShippedDate LIKE '%1997%'
GROUP BY ShipVia
ORDER BY COUNT(OrderID) DESC