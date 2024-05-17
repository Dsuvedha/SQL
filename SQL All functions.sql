USE DB;
--strings--
SELECT CONCAT('Hello ', 'Gorgeous') AS ConcatenatedString;

SELECT SUBSTRING('Hello Gorgeous', 7, 8) AS SubstringResult;

SELECT UPPER('Hello') AS UppercaseString;

SELECT LOWER ('HELLO') AS LowercaseString;

SELECT Len('HelloGorgeous') AS Lengthofstring;

SELECT TRIM('   HelloGorgeous') AS TrimmedString;

SELECT REPLACE('Hello Gorgeous', 'Gorgeous', 'Beauty') AS ReplacedString;

SELECT LEFT('Hello Gorgeous', 5) AS LeftString;

SELECT RIGHT('Hello Gorgeous', 8) AS RightString;

--date and time--

SELECT CURRENT_TIMESTAMP AS CurrentDateTime;

SELECT DATEADD(DAY, 7, CURRENT_TIMESTAMP) AS NewDate;

SELECT DATEADD(month, 7, '2024-05-07') AS NewDate;

SELECT DATEADD(year, 7, '2024-05-07') AS NewYear;

SELECT DATEADD(hour, 7, '2024-05-07 12:00:00') AS NewHours;
       ------------
SELECT DATEDIFF(day, '2001-03-21', '2024-05-16') AS DayDifference;

SELECT DATEDIFF(year, '1996-12-03', '2001-03-21') AS YearDifference;

SELECT DATEDIFF(day, '1996-12-03', '2024-05-16') AS DayDifference;

SELECT DATEDIFF(minute, '1996-12-03 12:00:00', '2024-05-16 12:00:00') AS MinuteDifference;

SELECT DATEPART(day, '2024-05-07') AS day;

SELECT DATEPART(month, '2024-12-03') AS month;

SELECT DAY('2001-03-21') AS DayOfMonth;

SELECT GETDATE() AS CurrentDateTime;

SELECT FORMAT(GETDATE(), 'dd') AS FormattedMonth;

SELECT FORMAT(GETDATE(), 'tt') AS FormattedAMPM;

SELECT CONVERT(DATETIME, '2024-05-07') AS DateConverted;

------------

SELECT ABS(-24) As Postive;

SELECT POWER(10, 2) AS Root;

SELECT PI();

SELECT EXP(2);
SELECT LOG(2);

USE DB;

CREATE TABLE Employee(
EmployeeID INT Primary Key,
FirstName VarChar(50),
LastName VarChar(50),
Salary DECIMAL(10,2)
);

INSERT INTO Employee(EmployeeID,FirstName,LastName,Salary)
Values
(1,'Aksh','agna',50000.00),
(2,'Swe','danaseg',80000.00),
(3,'John','smith',55000.00),
(4,'Rob','patt',60000.00);

SELECT * from Employee;

SELECT EmployeeID, FirstName, LastName, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary ASC) AS RowNumber
FROM Employee;


SELECT EmployeeID, FirstName, Salary,
        RANK() OVER (ORDER BY FirstName ASC) AS Rank
FROM Employee;

SELECT EmployeeID, FirstName, LastName, Salary,
       DENSE_RANK() OVER (ORDER BY LastName DESC) AS DenseRank
FROM Employee;

--------------Aggregate

SELECT * from Employee;

SELECT COUNT(EmployeeID) AS TotalEmployee
 FROM Employee;

SELECT AVG (Salary) AS AverageSalary
FROM Employee;

SELECT MAX(Salary) AS MaxSalary
FROM Employee;

SELECT STUFF((SELECT ', ' + FirstName 
              FROM Employee 
              FOR XML PATH('')), 1, 2, '') AS AllFirstNames;

DECLARE @originalString VARCHAR(50) = 'hello Gorgeous!'
SELECT STUFF(@originalString, 5, 4, 'SQL') AS ChangedString;

-------------scalar-------

CREATE DATABASE ADB;

USE ADB;

CREATE TABLE Employee(
EmployeeID INT Primary Key,
FirstName VarChar(50),
LastName VarChar(50),
Salary DECIMAL(10,2),
DateOfBirth Date
);

INSERT INTO Employee(EmployeeID,FirstName,LastName,Salary,DateOfBirth)
Values
(1,'Aksh','agna',50000.00,'2024-02-28'),
(2,'Swe','danaseg',80000.00, '2024-03-15'),
(3,'John','smith',55000.00,'2001-03-21'),
(4,'Rob','patt',60000.00, '1996-12-03');

SELECT * from Employee;

CREATE FUNCTION dbo.CalculateAge (@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
	DECLARE @Age INT;

	SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());

	RETURN @Age;
END;

SELECT FirstName
	,LastName
	,DateOfBirth
	,dbo.CalculateAge(DateOfBirth) AS Age
FROM Employee;

UPDATE Employee
SET DateOfBirth = '2001-03-21'
WHERE EmployeeID = 3;

UPDATE Employee
SET DateOfBirth = '1996-12-03' 
WHERE EmployeeID = 4;

CREATE FUNCTION dbo.ConcatenateName (@FirstName VARCHAR(50), @LastName VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FullName VARCHAR (100);
   
    SET @FullName = @FirstName + ' ' + @LastName;
    
    RETURN @FullName;
END;

SELECT FirstName
	,LastName
	,DateOfBirth
	,dbo.CalculateAge(DateOfBirth) AS Age
	,dbo.ConcatenateName(FirstName, LastName) AS FullName
FROM Employee;

------- Inline table---
USE ADB;

SELECT * from Employee;

UPDATE Employee
SET DateOfBirth = '1945-05-01' 
WHERE EmployeeID = 2;


CREATE FUNCTION dbo.GetEmployeesAboveAge
(
    @AgeThreshold INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT EmployeeID, FirstName, LastName, DateOfBirth
    FROM Employee
    WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) > @AgeThreshold
);

SELECT *
FROM dbo.GetEmployeesAboveAge(30);

-------------------------------------------
USE ADB;

CREATE TABLE Employe(
EmployeeID INT Primary Key,
FirstName VarChar(50),
LastName VarChar(50),
Salary DECIMAL(10,2),
HireDate Date
);

INSERT INTO Employe(EmployeeID,FirstName,LastName,Salary,HireDate)
Values
(1,'Aksh','agna',50000.00,'2024-03-06'),
(2,'Swe','danaseg',80000.00,'2023-05-09'),
(3,'John','smith',55000.00,'2024-08-06'),
(4,'Rob','patt',60000.00,'2022-01-01');

SELECT * from Employe;

CREATE FUNCTION GetEmployeesByHireDateRange (@StartDate DATE, @EndDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT EmployeeID, FirstName, LastName, HireDate
    FROM Employe
    WHERE HireDate BETWEEN @StartDate AND @EndDate
);

SELECT *
FROM dbo.GetEmployeesByHireDateRange('2023-01-01', '2024-12-31');

---------------multi line-------------
CREATE DATABASE MS;

USE MS;

CREATE TABLE Workers(
EmployeeID INT Primary Key,
FirstName VarChar(50),
LastName VarChar(50),
Salary DECIMAL(10,2),
HireDate Date,
DateOfBirth  Date
);

INSERT INTO Workers(EmployeeID,FirstName,LastName,Salary,HireDate,DateOfBirth)
VALUES
(1,'Aksh','agna',50000.00,'2024-03-06','2024-02-28'),
(2,'Swe','danaseg',80000.00,'2023-05-09','2001-03-21'),
(3,'John','smith',55000.00,'2024-08-06','1996-02-09'),
(4,'Rob','patt',60000.00,'2022-01-01','1996-12-03');

SELECT * from Workers;

CREATE FUNCTION dbo.GetEmployeesInAgeRange
(
    @MinAge INT,
    @MaxAge INT
)
RETURNS @Employees TABLE 
(
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE
)
AS
BEGIN
    INSERT INTO @Employees (EmployeeID, FirstName, LastName, DateOfBirth)
    SELECT EmployeeID, FirstName, LastName, DateOfBirth
    FROM Workers
    WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) BETWEEN @MinAge AND @MaxAge;

    RETURN;
END;









SELECT *
FROM dbo.GetEmployeesInAgeRange(20, 30);
