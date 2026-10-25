SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS data_digger;
USE data_digger;

CREATE TABLE customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE,
    Address VARCHAR(100)
);

INSERT INTO customer VALUES
(1, "Alice", "alice@gmail.com", "Surat"),
(2, "Bob" , "Bob@gmail.com", "Sun franchinsec"),
(3, "Chrilce", "chrilce@gmail.com", "LONDON"),
(4, "David", "David@gmail.com", "NEW YORK"),
(5, "Eye", "Eye@gmail.com", "Brigliam");

SELECT * FROM customer;

UPDATE customer
SET Address = "Vadodara"
WHERE customerID = 4;

DELETE FROM customer
WHERE customerID = 5;

CREATE TABLE order_Table (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount INT,
    FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID)
);

INSERT INTO order_Table VALUES
(101, 1, '2026-10-01', 250),
(102, 2, '2026-10-05', 1200),
(103, 3, '2026-10-10', 450),
(104, 4, '2026-10-15', 890),
(105, 4, '2026-10-20', 150);

SELECT * FROM order_Table;

SELECT * FROM order_Table
WHERE CustomerID = 1;

UPDATE order_Table
SET TotalAmount = 350
WHERE OrderID = 101;

DELETE FROM order_Table
WHERE OrderID = 105;

SELECT * FROM order_Table
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT 
    MAX(TotalAmount) AS HighestAmount,
    MIN(TotalAmount) AS LowestAmount,
    AVG(TotalAmount) AS AverageAmount
FROM order_Table; 

CREATE TABLE Product (
    Product_id INT PRIMARY KEY,
    ProductName VARCHAR(100) NULL,
    Price INT,
    Stock INT
);

INSERT INTO Product (Product_id, ProductName, Price, Stock) VALUES
(1, 'Wireless Mouse', 25, 150),
(2, 'Mechanical Keyboard', 85, 45),
(3, 'Gaming Monitor 27"', 299, 20),
(4, 'USB-C Hub 6-in-1', 40, 85),
(5, 'Bluetooth Headphones', 120, 60);

SELECT * FROM Product;

SELECT * FROM Product
ORDER BY Price DESC;

UPDATE Product
SET Price = 140
WHERE Product_id = 2;

DELETE FROM Product
WHERE Product_id = 1;

SELECT * FROM Product 
WHERE Price BETWEEN 500 AND 2000;

SELECT
    MAX(Price) AS Maximum_price,
    MIN(Price) AS Minimum_price
FROM Product; 

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    Product_id INT,
    Quantity INT,
    SubTotal INT,
    FOREIGN KEY (OrderID) REFERENCES order_Table(OrderID),
    FOREIGN KEY (Product_id) REFERENCES Product(Product_id)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, Product_id, Quantity, SubTotal) VALUES
(1, 101, 2, 2, 280),
(2, 101, 4, 1, 40),
(3, 102, 3, 1, 299),
(4, 103, 2, 2, 280),
(5, 104, 5, 3, 360);

SELECT * FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;

SELECT Product_id, SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY Product_id
ORDER BY TotalQuantitySold DESC
LIMIT 3;

SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE Product_id = 2;


SHOW TABLES;


DROP TABLE OrderDetails;
DROP TABLE order_Table;
DROP TABLE Product;
DROP TABLE customer;
