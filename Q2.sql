DROP TRIGGER afterDelOrder;
DELIMITER $$
CREATE TRIGGER afterDelOrder
BEFORE DELETE
ON orders
FOR EACH ROW
BEGIN
	DELETE FROM `order detalis` o Where orderID = OLD.orderID;
	UPDATE products SET UnitsInStock = o.OLD.Quantity + UnitsInStock WHERE productID = o.OLD.productID;

END $$
DELIMITER ;




DROP TRIGGER afterDelOrder;
DELIMITER $$
CREATE TRIGGER afterDelOrder
BEFORE DELETE
ON orders
FOR EACH ROW
BEGIN
	DELETE FROM `order detalis` od Where orderID = OLD.orderID;
	UPDATE products SET UnitsInStock = UnitsInStock + 
		(SELECT Quantity FROM `order details` o WHERE o.productID = od.productID AND OrderID = OLD.OrderID)  
		WHERE productID = od.productID;
END $$
DELIMITER ;



DROP TRIGGER afterDelOrder;
DELIMITER $$
CREATE TRIGGER afterDelOrder
BEFORE DELETE
ON orders
FOR EACH ROW
BEGIN
	DELETE FROM `order detalis` Where orderID = OLD.orderID;
	UPDATE products SET UnitsInStock = UnitsInStock + 
		(SELECT Quantity FROM `order details` o WHERE o.productID = od.productID AND OrderID = OLD.OrderID)  
		WHERE productID = (SELECT productID FROM `order detalis` WHERE orderID = OLD.orderID);
END $$
DELIMITER ;