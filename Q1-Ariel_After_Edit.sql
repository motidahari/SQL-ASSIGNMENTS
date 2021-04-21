DROP PROCEDURE myProcedure;

-- PROCEDURE
DELIMITER $$
CREATE PROCEDURE `myProcedure`(IN userID varchar(5))
BEGIN


-- QUERY
(SELECT
	OrderID,
	case
		WHEN Amount <= 0 THEN "Loss"
		else "Profit" 
		END AS "Profit/Loss" ,
	abs(Amount) AS Amount
FROM
	(SELECT
		`order details`.OrderID,
		ProductID AS prod_id,
		(SELECT SUM(Quantity*(SELECT AVG(UnitPrice) 
							  FROM `order details` od
							  WHERE (od.ProductID = prod_id) 
							  GROUP BY ProductID) * (1 - Discount) - Quantity*UnitPrice*(1 - Discount))) AS Amount
        
	FROM `order details`
	JOIN orders
	ON CustomerID = userID AND orders.OrderID = `order details`.OrderID
	GROUP BY `order details`.OrderID ) AS ariel
ORDER BY cast(Amount AS signed));


END $$
DELIMITER ;



-- SET PARAM TO FUNTION

set @param = "VINET";
CALL myProcedure(@param);