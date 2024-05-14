
Cursors 

Static cursor:
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
);
DECLARE @FirstName VARCHAR(50), @LastName VARCHAR(50) —- variable declaration

DECLARE static_cursor CURSOR STATIC FOR —- cursor declaration
SELECT StudentID, FirstName
FROM Students;

OPEN static_cursor;

FETCH NEXT FROM static_cursor INTO @FirstName, @LastName; —- fetches first row


WHILE @@FETCH_STATUS = 0 —- loop
BEGIN
    
    PRINT @FirstName + ' ' + @LastName;

    FETCH NEXT FROM static_cursor INTO @FirstName, @LastName;
END;

CLOSE static_cursor;
DEALLOCATE static_cursor;

Key set cursor:

CREATE TABLE Students (
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
);
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth)
VALUES
    (1, 'John', 'Doe', '2000-05-15'),
    (2, 'Jane', 'Smith', '1999-08-20'),
    (3, 'Michael', 'Johnson', '2001-02-10'),
    (4, 'Emily', 'Brown', '2002-11-30'),
    (5, 'William', 'Davis', '2003-07-25');
 SELECT * from Students;

DECLARE @StudentID VARCHAR(50), @FirstName VARCHAR(50), @LastName VARCHAR(50);
DECLARE keyset_cursor CURSOR KEYSET FOR
SELECT StudentID, FirstName, LastName
FROM Students;

OPEN keyset_cursor;


FETCH LAST FROM keyset_cursor INTO @StudentID, @FirstName, @LastName;


WHILE @@FETCH_STATUS = 0
BEGIN
    
    PRINT @StudentID + ' ' + @FirstName + ' ' + @LastName;
	Select @StudentID as StdId, @FirstName as FirstName , @LastName AS Lastname;

    
    FETCH PRIOR FROM keyset_cursor INTO @StudentID, @FirstName, @LastName;
END;

CLOSE keyset_cursor;
DEALLOCATE keyset_cursor;

Forward only cursor:

CREATE TABLE AuditTable (
    AuditID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ModifiedDate DATE,
);
INSERT INTO AuditTable (AuditID, FirstName, LastName, ModifiedDate)
VALUES
    (1, 'John', 'Doe', '2000-05-15'),
    (2, 'Jane', 'Smith', '1999-08-20'),
	(3, 'Michael', 'Johnson', '2001-02-10'),
    (4, 'Emily', 'Brown', '2002-11-30'),
    (5, 'William', 'Davis', '2003-07-25');
 SELECT * from AuditTable; 

DECLARE @FirstName VARCHAR(50), @LastName VARCHAR(50)

DECLARE forward_only_cursor CURSOR FORWARD_ONLY FOR
SELECT AuditID, ModifiedDate
FROM AuditTable;

OPEN forward_only_cursor;

FETCH NEXT FROM forward_only_cursor INTO @FirstName, @LastName;


WHILE @@FETCH_STATUS = 0
BEGIN
   
    PRINT @FirstName + ' ' + @LastName;

    FETCH NEXT FROM forward_only_cursor INTO @FirstName, @LastName;
END;

CLOSE forward_only_cursor;
DEALLOCATE forward_only_cursor;

Dynamic cursor:

CREATE TABLE Department (
    DeptID INT,
    DepartmentName VARCHAR(50),
    ModifiedDate DATE,
);
INSERT INTO Department (DeptID, DepartmentName, ModifiedDate)
VALUES
    (1, 'John', '2000-05-15'),
    (2, 'Jane', '1999-08-20'),
	(3, 'Michael', '2001-02-10'),
    (4, 'Emily', '2002-11-30'),
    (5, 'William', '2003-07-25');
 SELECT * from Department; 

DECLARE @DeptID VARCHAR(50), @DepartmentName VARCHAR(50), @ModifiedDate VARCHAR(50)

DECLARE dynamic_cursor CURSOR DYNAMIC FOR
SELECT *
FROM Department;

OPEN dynamic_cursor;

FETCH LAST FROM dynamic_cursor INTO @DeptID, @DepartmentName ,@ModifiedDate;


WHILE @@FETCH_STATUS = 0
BEGIN
    
    UPDATE Department
    SET DepartmentName = @DepartmentName
    WHERE DeptID = @DeptID;
    
	 Select @DeptID as DeptId, @DepartmentName as DeptName ,@ModifiedDate as Ondate;
    
    FETCH PRIOR FROM dynamic_cursor INTO @DeptId, @DepartmentName ,@ModifiedDate;
END;

CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;

TRIGGERS

USE TestDB;


CREATE TABLE Workers (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Workers (EmployeeID, FirstName, LastName, Salary)
VALUES 
    (1, 'John', 'Doe', 50000.00),
    (2, 'Jane', 'Smith', 60000.00),
    (3, 'Michael', 'Johnson', 75000.00),
    (4, 'Emily', 'Williams', 1000.00);

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[altertriggerchange]
ON [dbo].[Workers]
INSTEAD OF INSERT
AS
BEGIN
 
    IF EXISTS (SELECT 1 FROM inserted WHERE salary = 1000)
    BEGIN
        RAISERROR ('Salary cannot be equal to 1000', 16, 1)
        ROLLBACK TRANSACTION;
    END;
    ELSE
    BEGIN
        
        INSERT INTO Employee
        SELECT * FROM inserted;
    END;
END;

– – After triggers– –
USE Tempdb

GO


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE
);


CREATE TABLE IF NOT EXISTS AuditTable (
    AuditID INT PRIMARY KEY,
    Action VARCHAR(10),
    EmployeeID INT,
    ModifiedDate DATETIME
);


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[AfterAuditChange]
ON [dbo].[Employees]
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AuditTable (Action, EmployeeID, ModifiedDate)
        SELECT 'INSERT', EmployeeID, GETDATE() FROM inserted;
    END;
END;









