DROP TRIGGER afterDelOrder;
DELIMITER $$
CREATE TRIGGER afterDelOrder
BEFORE DELETE
ON orders
FOR EACH ROW
BEGIN

UPDATE products SET products.UnitsInStock = products.UnitsInStock + 
		(SELECT o.Quantity FROM `order details` o WHERE (o.orderID = OLD.orderID AND products.productID = o.productID));
DELETE FROM `order details` Where orderID = OLD.orderID;
	
END $$
DELIMITER ;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM orders
where OrderID=10257;
SET FOREIGN_KEY_CHECKS = 1;

