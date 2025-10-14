-- Write a command that returns information about orders from the order details table. The query should group and
-- display the ID of each product and then calculate the total quantity ordered. The total quantity is summed
-- using the SUM aggregate function and displayed as a single value for each product.

SELECT ProductID, SUM(Quantity) AS 'Total Quantity'
FROM [Order Details]
GROUP BY ProductID