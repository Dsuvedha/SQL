USE Test

CREATE TABLE Database_table
(Name VARCHAR(50),
 RollNo INT,
 Location VARCHAR(50),
 PhoneNo VARCHAR(10)
 );

 INSERT INTO  Database_table
 VALUES
 ('Ram',101,'Chennai',9876543430),
 ('Raj',102,'Coimbatore',9876543849),
 ('Sasi',103,'Madurai',9876541090),
 ('Ravi',104,'Salem',9876547890);

 SELECT * from Database_table;

 CREATE TABLE Student_table
(Name VARCHAR(50),
 RollNo INT,
 Section VARCHAR(50),
 );

 INSERT INTO  Student_table
 VALUES
 ('Ram',101,'A'),
 ('Raj',102,'B'),
 ('Ravi',104,'C');

 SELECT * from Student_table;

 --Subquery--

 SELECT  
    Name,
    Location, 
	RollNo,
    PhoneNo  
FROM  
    Database_table  
WHERE 
    RollNo IN(
   SELECT  
    RollNo
   FROM  
    Student_table  
   WHERE Section = 'A' );

   --CTE--

   CREATE DATABASE DB;
   USE DB;

   CREATE TABLE Employees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID)
VALUES (1, 'John', 'Smile', 101),
       (2, 'Jane', 'Dog', 102),
       (3, 'Alice', 'Johns', 101),
       (4, 'Bob', 'Willis', 102);

SELECT * from Employees;

WITH DepartmentEmployees AS (
    SELECT EmployeeID, FirstName, LastName
    FROM Employees
    WHERE DepartmentID = 102
)
SELECT * from DepartmentEmployees;

-------------------------------------------

WITH Department101 AS (
    SELECT EmployeeID, FirstName, LastName
    FROM Employees
    WHERE DepartmentID = 101
),
Department102 AS (
    SELECT EmployeeID, FirstName, LastName
    FROM Employees
    WHERE DepartmentID = 102
)
SELECT * FROM Department101
UNION ALL
SELECT * FROM Department102;
