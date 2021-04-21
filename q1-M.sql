DROP TEMPORARY TABLE main_table;

CREATE TEMPORARY TABLE main_table AS (SELECT 
		od.OrderID,
		od.UnitPrice,
		od.ProductID,
		od.Quantity,
		(od.UnitPrice * od.Quantity) as Total
	FROM orders o
    JOIN `order details` od
		ON o.OrderID = od.OrderID
		AND CustomerID = 'VINET');
		
SELECT 
	*,
    SUM(ordersD.totalPrice)/SUM(ordersD.Quantity) as AVG
FROM 
	(SELECT 
		ProductID,
		UnitPrice AS UnitPrice,
		Quantity AS Quantity,
		UnitPrice*Quantity AS totalPrice
	FROM `order details` od
	where ProductID = 11) AS ordersD
JOIN main_table
ON main_table.ProductID = ordersD.ProductID ;


