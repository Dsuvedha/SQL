USE Test

CREATE TABLE Sales
(
    Product NVARCHAR(50),
    SaleAmount INT
);
INSERT INTO Sales VALUES ('iPhone', 500)
INSERT INTO Sales VALUES ('Laptop', 800)
INSERT INTO Sales VALUES ('iPhone', 1000)
INSERT INTO Sales VALUES ('Speakers', 400)
INSERT INTO Sales VALUES ('Laptop', 600)

SELECT * from Sales;

SELECT 
  Product, 
  SUM(SaleAmount) AS TotalSales 
FROM 
  Sales 
GROUP BY 
  Product 
HAVING 
  SUM(SaleAmount) > 500 

 SELECT 
  Product, 
  SUM(SaleAmount) AS TotalSales 
FROM 
  Sales 
WHERE 
  Product in ('iPhone', 'Speakers') 
GROUP BY 
  Product

 SELECT 
  Product, 
  SUM(SaleAmount) AS TotalSales 
FROM 
  Sales 
GROUP BY 
  Product 
HAVING 
  Product in ('iPhone', 'Speakers')

  groupby and havingconcept

 SELECT 
  Product, 
  SUM(SaleAmount) AS TotalSales 
FROM 
  Sales 
WHERE 
  Product in ('iPhone', 'Speakers') 
GROUP BY 
  Product
HAVING 
  SUM(SaleAmount) > 500 
  -----------------------------------

  USE TestDB

 CREATE TABLE Developers (
    D_id INT PRIMARY KEY,
    D_name VARCHAR(50),
    D_age INT,
    D_state VARCHAR(50),
    D_salary DECIMAL(10, 2)
);

INSERT INTO Developers (D_id, D_name, D_age, D_state, D_salary)
VALUES
    (1, 'John Smith', 30, 'California', 75000.00),
    (2, 'Emma Johnson', 28, 'New York', 80000.00),
    (3, 'Michael Brown', 35, 'Texas', 90000.00),
    (4, 'Sophia Lee', 32, 'Florida', 85000.00);
-- groupby--
SELECT 
  D_state, 
  COUNT(*) AS Developer_Count 
FROM 
  Developers 
GROUP BY
  D_state;


  --orderby--
 SELECT 
  D_name,
  D_salary
   
FROM 
  Developers 

ORDER BY 
  D_salary DESC;
 
 --both--

 SELECT 
  D_state, 
  COUNT(*) AS Developer_Count 
FROM 
  Developers 
GROUP BY 
  D_state 
ORDER BY 
  Developer_Count DESC;




