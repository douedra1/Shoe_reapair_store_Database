
/*
Shoes sale and repair DATABASE
Designed and Created by Djakaridja Ouedraogo
*/





-- Create and USE the DATABASE

DROP DATABASE IF EXISTS ShoesRepairSaleShop_DB;
CREATE DATABASE IF NOT EXISTS ShoesRepairSaleShop_DB;
USE ShoesRepairSaleShop_DB;



-- Create table Customer
CREATE TABLE IF NOT EXISTS Customer
( 
    name       VARCHAR(50) NOT NULL,
    phone       CHAR (10),
    Email       VARCHAR(50),
    address    VARCHAR(50),

    CONSTRAINT Customer PRIMARY KEY(Email)
);
 
INSERT INTO Customer VALUES('Wilson Edward', '9654785231', 'edward@yahoo.fr', '4586 Any Street, Philadelphia PA 12543');
INSERT INTO Customer VALUES('Ibrahim Tuard','1203256987','ibtuard@gmail.com','2657 Alltime way, Philadelphia PA 15896');
INSERT INTO Customer VALUES('Antony Wayne','4875632159', 'antonywayne@hotmail.com','4589 Henry Dr, Philadelphia PA 15896');
INSERT INTO Customer VALUES('Anne Doyen', '8974123658', 'annedoyen@gmail.com', '2568 Irie street, Philadelphia PA 14589');
INSERT INTO Customer VALUES('Lucien Rene', '2350002211', 'lucienrene@oal.com', '4879 Alto Dr, Philadelphia PA 14589');



-- Create table ReceptionDesk
CREATE TABLE IF NOT EXISTS ReceptionDesk
( 
    EmpID      VARCHAR(10),
    Name       VARCHAR(50),
    Phone      CHAR(10),
    StartDate  DATE,

    CONSTRAINT ReceptionDesk PRIMARY KEY(EmpID)
);

INSERT INTO ReceptionDesk VALUES(0011, 'Andrea Boutche', '6520003311', '2010-12-31');
INSERT INTO ReceptionDesk VALUES(0022, 'Juan Miguel', '4589630022', '2015-07-17');
INSERT INTO ReceptionDesk VALUES(1102, 'Line Jaber', '8889996621', '2020-11-26');
INSERT INTO ReceptionDesk VALUES(0125,'Bernard Lampard', '4589632145', '2019-05-15');
INSERT INTO ReceptionDesk VALUES(0235,'Chilma Brown', '4589321500', '2018-01-01');


-- Create table Orders
CREATE TABLE IF NOT EXISTS Orders
( 
    OrderNum      VARCHAR(50),
    Date          DATE,
    Email_FK      VARCHAR(50),
    EmpID_FK      VARCHAR(10),
  
   CONSTRAINT Orders PRIMARY KEY(OrderNum),

  CONSTRAINT Orders_FK1 FOREIGN KEY (Email_FK)
   REFERENCES Customer(Email),

   CONSTRAINT Orders_FK2 FOREIGN KEY (EmpID_FK)
   REFERENCES ReceptionDesk(EmpID)
);

INSERT INTO Orders VALUES(1200, '2021-03-30', 'edward@yahoo.fr', 0011);
INSERT INTO Orders VALUES(1500, '2021-04-15', 'ibtuard@gmail.com', 0022);
INSERT INTO Orders VALUES(0050, '2021-05-01', 'antonywayne@hotmail.com', 1102);
INSERT INTO Orders VALUES(0160, '2021-04-30','lucienrene@oal.com',0235);
INSERT INTO Orders VALUES(1256, '2021-03-30','annedoyen@gmail.com',0125);


-- Create table Repair
CREATE TABLE IF NOT EXISTS Repair
( 
    RepairNum      VARCHAR(50),
    Name           VARCHAR(50),
    size           INT,
    Quantity       INT,
    Cost          DOUBLE,
    EstRepairDate  DATE,
    OrderNum_FK    VARCHAR(50),

    CONSTRAINT Repair PRIMARY KEY(RepairNum),

    CONSTRAINT Repair FOREIGN KEY(OrderNum_FK)
    REFERENCES Orders(OrderNum)
    );

INSERT INTO Repair VALUES(7500, 'Addidas', 13, 1, 175.00, '2021-05-15',1200);
INSERT INTO Repair VALUES(256, 'Nike', 10, 3, 89.20, '2021-04-17',1500);
INSERT INTO Repair VALUES(170, 'Reebook', 15, 4, 250.20, '2021-04-20',0050);
INSERT INTO Repair VALUES(100, 'Addidas', 11, 2, 1000.40, '2021-04-19',1256);
INSERT INTO Repair VALUES(562, 'Nike', 9, 23, 800.80, '2021-04-25',0160);
INSERT INTO Repair VALUES(5610, 'Nike', 12, 6, 800.80, '2021-04-25',0050);



-- Create table Sale
CREATE TABLE IF NOT EXISTS Sale
( 
    ProductNum    VARCHAR(50),
    Name          VARCHAR(50),
    Quantity      INT,
    Price         DOUBLE,
    OrderNum_FK   VARCHAR(50),

    CONSTRAINT Sale PRIMARY KEY(ProductNum),

    CONSTRAINT Sale FOREIGN KEY(OrderNum_FK)
    REFERENCES Orders(OrderNum)
);

INSERT INTO Sale VALUES(0012, 'glue', 12, 59,1200);
INSERT INTO Sale VALUES(1112, 'Addidas shoes', 32, 250, 1500);
INSERT INTO Sale VALUES(1000, 'Colorine', 16, 20, 0050);
INSERT INTO Sale VALUES(4500, 'sandal', 7, 40, 1256);
INSERT INTO Sale VALUES(2564, 'Nike Shoes', 9, 200, 0160);
INSERT INTO Sale VALUES(5483, 'Nike Shoes', 9, 250, 1500);
INSERT INTO Sale VALUES(5983, 'Nike Shoes', 6, 350, 1500);



-- Statement to show all tables.
SHOW TABLES;

--Statement to describe the content of the Customer Table.
DESCRIBE Customer;
SELECT * FROM Customer;

--Statement to describe the content of the ReceptionDesk Table.
DESCRIBE ReceptionDesk;
SELECT * FROM ReceptionDesk;

--Statement to describe the content of the Orders Table.
DESCRIBE Orders;
SELECT * FROM Orders;

--Statement to describe the content of the Repair Table.
DESCRIBE Repair;
SELECT * FROM Repair;

--Statement to describe the content of the Sale Table.
DESCRIBE Sale;
SELECT * FROM Sale;



                       --PART 2

--Write a query that performs a Union on your main table and another table

SELECT Quantity FROM Repair
UNION 
SELECT Quantity FROM Sale;


--Write a query that performs an intersection on your main table and another table. 

SELECT Name  
FROM Repair
WHERE OrderNum_FK =1500
INTERSECT
SELECT Name   
FROM Sale 
WHERE Quantity >5;




-- queries to perform a Difference Operation on your main table and another table

--First except query
SELECT Quantity   
FROM Repair 
EXCEPT  
SELECT Quantity   
FROM Sale;  

--Second except query
SELECT Name   
FROM Repair 
EXCEPT  
SELECT Name   
FROM Sale; 



-- JOIN Query using two or more of your tables.  A table and two or more tables that it has a relationship with:
 --First Query
 SELECT 
      r.RepairNum,
      r.Name repairs,
      s.ProductNum,
      s.Name Sale
FROM Repair r
INNER JOIN Sale s
      ON r.OrderNum_FK = s.OrderNum_FK;

--Second Query
 SELECT 
      s.price,
      r.cost
FROM Sale s
INNER JOIN Repair r
      ON r.Quantity = s.Quantity;



-- Create two queries that will alter the structure of your entity table:
ALTER TABLE Repair 
MODIFY cost INT;

ALTER TABLE Sale 
MODIFY ProductNum CHAR(10);


-- two queries that will update two different categories of rows in the tables of the set of tables that you have chosen 
--First query
UPDATE ReceptionDesk 
SET 
    Name = 'Gobi Julien Halway'
WHERE
    EmpID = 0235;

--Second Query
UPDATE Customer 
SET 
    Address = '5980 Warrington Avenue, Philadelphia PA 19145'
WHERE
    Name = 'Lucien Rene';


-- two queries that will delete two different categories of rows in your tables 
--First query
DELETE FROM Sale 
WHERE ProductNum = 2564;

--Second query
DELETE FROM Repair
WHERE cost = 800.80;


-- two queries that perform aggregate functions on at least your Primary Table in your set of individual tables.
--First Query
SELECT avg(price) Avg_Price 
FROM Sale 
WHERE Quantity >1;

--Second Query
SELECT MIN(cost) Lowest_cost 
FROM repair 
WHERE Name='Addidas';


--two queries that use a HAVING clause on different categories of rows in your set of tables chosen. 
--First Query
SELECT Repair.Name, Repair.cost
FROM Repair
WHERE Name ='Addidas'
HAVING cost>180;

--Secon Query
SELECT Sale.Name, Sale.price
FROM Sale
WHERE Quantity > 1
HAVING Sale.price > 40 AND Sale.price < 251;


--two queries that use a GROUP BY and HAVING clause on different categories of rows in your entity table or a combination of the set of tables chosen
--First Query
SELECT Sale.Name, Sale.price, Sale.ProductNum, Sale.Quantity
FROM Sale
GROUP BY Quantity
HAVING COUNT(Sale.Quantity)<2;

--Second Query
SELECT Repair.Name, Repair.cost
FROM Repair
GROUP BY cost
HAVING COUNT(Repair.cost)>=2;


--two queries that sort the results in Ascending and Descending order of the set of tables chosen.
--Order Ascending  
SELECT * FROM Sale
ORDER BY price ASC;

-- Order Descending
SELECT name, phone, email from Customer
ORDER BY name DESC;


--two queries that create two SQL VIEWS.  These view statements should also include the SELECT Statements to execute them.
-- First Created View
CREATE VIEW CustomerInformation
AS 
SELECT 
    name, 
    phone, 
    Email, 
    address
FROM
    customer
    GROUP BY name
    ORDER BY name DESC;

-- Select Statement to execute the first created view
SELECT name, phone, Email, address 
FROM CustomerInformation;


-- Second Created View
CREATE VIEW EmployeeAtDesk
AS 
SELECT 
    name, 
    phone, 
    StartDate
FROM
    ReceptionDesk
    GROUP BY StartDate
    ORDER BY StartDate ASC;
    
-- Select Statement to execute the Second created view
SELECT name, phone, StartDate 
FROM EmployeeAtDesk;


/*
--two Stored Procedures
DELIMITER $$

CREATE PROCEDURE GetNameByPrice(
	IN  Name VARCHAR(25),
	OUT Price Double
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO Price
	FROM Sale
	WHERE Name = Addidas;
END$$

DELIMITER;


CALL GetNameByPice('Addidas',@price);
SELECT @Price;
*/


--Stored Triggers

-- create a new table named ReceptionDesk_audit to keep the changes to the employees table

CREATE TABLE ReceptionDesk_audit(
    EmpID      VARCHAR(10),
    Name       VARCHAR(50),
    Phone      CHAR(10),
    StartDate  DATE,
    address VARCHAR(50),
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
    );

--SELECT Statements visually confirming the success of the operations for ReceptionDesk_audit table
SELECT * FROM ReceptionDesk_audit;

CREATE TRIGGER before_ReceptionDesk_update 
    BEFORE UPDATE ON ReceptionDesk
    FOR EACH ROW 
 INSERT INTO ReceptionDesk_audit
 SET action = 'update',
     EmpID = OLD.EmpID,
     Name = OLD.Name,
     Phone = OLD.Phone,
     StartDate = OLD.StartDate,
     changedat = NOW();

--show all triggers in the current database by using the SHOW TRIGGERS statement:
SHOW TRIGGERS;

--updates a row in the receptionDesk table:
UPDATE ReceptionDesk 
SET 
    name = 'Francois Benao'
WHERE
    EmpID = 1102;



--Create New Users  

--Create two new fictious user accounts
CREATE USER Chris IDENTIFIED BY 'Securepassword';
--exit;

 -- Login to a second session as Chris
mysql -u Chris -p

  --assign appropriate privileges to the users for the assignment
 GRANT ALL PRIVILEGES 
 ON ShoesRepairSaleShop_DB.*TO Chris;


-- Show privilege granted
 SHOW GRANTS FOR Chris;

 --Statements that revoke privileges to the new user.  
REVOKE ALL PRIVILEGES 
ON ShoesRepairSaleShop_DB.* 
FROM Chris;

--Show Grants after revoking privilege
SHOW GRANTS FOR Chris;
