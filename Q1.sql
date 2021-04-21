DROP PROCEDURE myProcedure;

--PROCEDURE
DELIMITER $$
CREATE PROCEDURE `myProcedure`(IN userID varchar(5))
BEGIN



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
		ProductID AS p,
		(SELECT sum(Quantity*(SELECT AVG(Unitprice) 
        FROM `order details` 
        WHERE (ProductID = p) 
        GROUP BY ProductID)*(1 - Discount) - Quantity*UnitPrice*(1 - Discount))) AS Amount
        
	FROM `order details`
	JOIN orders
	ON CustomerID = userID && orders.orderid = `order details`.orderid
	GROUP BY `order details`.OrderID ) AS ariel
ORDER BY cast(Amount AS signed));


END $$
DELIMITER ;
CALL myProcedure("VINET");