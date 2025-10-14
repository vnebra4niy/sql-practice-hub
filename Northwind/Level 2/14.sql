-- Display orders for which the number of order items is greater than 5

SELECT OrderID, COUNT(OrderID) AS 'Total Amount of Products'
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(OrderID)>5