
-- CREATE DATABASE assigndb;
-- USE assigndb
-- CREATE TABLE ProductDetail (
--     OrderID INT,
--     CustomerName VARCHAR(100),
--     Products VARCHAR(255)
-- );
-- INSERT INTO ProductDetail (OrderID, CustomerName, Products)
-- VALUES
-- (101, 'John Doe', 'Laptop, Mouse'),
-- (102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
-- (103, 'Emily Clark', 'Phone');
-- Transform ProductDetail table into 1NF
-- SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
-- FROM ProductDetail
-- JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) n
--   ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
-- ORDER BY OrderID;

CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderDetails table with OrderID and Product as composite primary key
CREATE TABLE OrderDetailsClean (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into OrderDetailsClean table
INSERT INTO OrderDetailsClean (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
