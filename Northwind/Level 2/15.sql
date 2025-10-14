-- Display customers for whom more than 8 orders were completed in 1998 (sort results
-- in descending order by total amount for delivery of orders for each customer

SELECT CustomerID, COUNT(OrderID) AS 'Total Orders'
FROM Orders
WHERE ShippedDate LIKE '%1998%'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 8
ORDER BY COUNT(OrderID) DESC