Inner join:
USE TestDB;


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departmonts(id)
);


INSERT INTO employees (id, name, department_id) VALUES
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Michael Johnson', 1),
(4, 'Emily Brown', 3);


CREATE TABLE departmonts (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO departmonts (id, name) VALUES
(1, 'HR'),
(2, 'Marketing'),
(3, 'Finance');

� � Inner Join � � All matched rows
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
INNER JOIN departmonts ON employees.department_id = departmonts.id;

� � Right Join � � matched rows and all rows in right table
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
RIGHT JOIN departmonts ON employees.department_id = departmonts.id;

� � Left Join � � matching rows and all rows in left table 
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
LEFT JOIN departmonts ON employees.department_id = departmonts.id;

� � full outer join � �
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
FULL OUTER JOIN departmonts ON employees.department_id = departmonts.id;

� � Cross join � �
CREATE TABLE table1(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE table2 (
    id INT PRIMARY KEY,
    description VARCHAR(50)
);

INSERT INTO table1 (id, name) VALUES
(1, 'A'),
(2, 'B');

INSERT INTO table2 (id, description) VALUES
(1, 'X'),
(2, 'Y'),
(3, 'Z'); 


SELECT table1.name AS table1_name, table2.description AS table2_description
FROM table1
CROSS JOIN table2;


Having
CREATE TABLE orderss (
    order_id INT,
    customer_id INT,
    order_amount DECIMAL(10, 2)
);


INSERT INTO orderss (order_id, customer_id, order_amount)
VALUES
    (1, 101, 5000.00),
    (2, 102, 200.00),
    (3, 101, 800.00),
    (4, 103, 3500.00),
    (5, 104, 300.00);

SELECT customer_id, SUM(order_amount) AS total_order_amount
FROM orderss
GROUP BY customer_id
HAVING SUM(order_amount) > 1000;

Order by:

USE Tempdb

CREATE TABLE Employes (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE
);

INSERT INTO Employes (EmployeeID, FirstName, LastName, HireDate)
VALUES (1, 'John', 'Doe', '2020-01-15'),
       (2, 'Jane', 'Smith', '2019-08-20'),
       (3, 'Alice', 'Johnson', '2021-03-10'),
       (4, 'Bob', 'Williams', '2022-05-05');


SELECT * FROM Employes
ORDER BY HireDate Asc;

GroupBy
USE tempdb


CREATE TABLE Sales (
    Product VARCHAR(50),
    Category VARCHAR(50),
    Amount DECIMAL(10, 2)
);


INSERT INTO Sales (Product, Category, Amount)
VALUES 
    ('Laptop', 'Electronics', 1500.00),
    ('Printer', 'Electronics', 500.00),
    ('Chair', 'Furniture', 100.00),
    ('Desk', 'Furniture', 300.00),
    ('Headphones', 'Electronics', 200.00),
    ('Table', 'Furniture', 250.00),
    ('TV', 'Electronics', 1200.00);

-- total sales amount by category--
SELECT Category, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY Category;
