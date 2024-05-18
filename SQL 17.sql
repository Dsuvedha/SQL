USE ADB;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    is_active TINYINT
);

CREATE TABLE UserD (
    user_id INT PRIMARY KEY,
	user_num TINYINT,
	user_name VARCHAR(50)
);

 INSERT INTO UserD(user_id, user_num, user_name)
 VALUES
 (1,'230','aksh'),
 (2,'150','swe');

 SELECT * from UserD;
------------------------------
DECLARE @value1 MONEY = 10.50;
DECLARE @value2 MONEY = 20.75;

DECLARE @resultAddition MONEY = @value1 + @value2;   

----------------------------------

CREATE TABLE Transactions (
    id INT PRIMARY KEY,
    amount_real REAL,
    amount_double DOUBLE PRECISION
);

INSERT INTO Transactions (id, amount_real, amount_double)
VALUES (1, 10.123456789, 10.123456789);

SELECT 
    amount_real * 2 AS result_real,
    amount_double * 2 AS result_double
FROM Transactions;

----------------------------

CREATE TABLE Emojis (
    ID INT PRIMARY KEY,
    EmojiString NVARCHAR(100)
);

INSERT INTO Emojis (ID, EmojiString) VALUES
(1, N'This is a winking emoji 😉'),
(2, N'This is a heart emoji ❤️');

SELECT * from Emojis;
---------------------------

CREATE TABLE SampleDate (
    id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
	task_duration TIME
);

INSERT INTO SampleDate (id, event_name, event_date, task_duration)
VALUES
    (1, 'Event 1', '2024-05-14', '08:30:00'),
    (2, 'Event 2', '2024-05-15', '09:20:00');

SELECT * from SampleDate;

--------------------------------------------------

USE ADB;

CREATE TABLE People (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50)
); 

INSERT INTO People (CustomerID, Name, Email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com');

CREATE PROCEDURE GetCustomerInfo
    @CustomerID INT
AS
BEGIN
    SELECT * FROM People WHERE CustomerID = @CustomerID;
END;

EXEC GetCustomerInfo @CustomerID = 1;

CREATE PROCEDURE InsertCustomer
    @Name VARCHAR(50),
    @Email VARCHAR(50)
AS
BEGIN
    INSERT INTO People (Name, Email) VALUES (@Name, @Email);
END;

EXEC InsertCustomer @Name = 'Bob Brown', @Email = 'bob@example.com';

CREATE PROCEDURE UpdateCustomerEmail
    @CustomerID INT,
    @NewEmail VARCHAR(50)
AS
BEGIN
    UPDATE People SET Email = @NewEmail WHERE CustomerID = @CustomerID;
END;

EXEC UpdateCustomerEmail @CustomerID = 2, @NewEmail = 'jane.smith@example.com';

CREATE PROCEDURE DeleteCustomer
    @CustomerID INT
AS
BEGIN
    DELETE FROM People WHERE CustomerID = @CustomerID;
END;

EXEC DeleteCustomer @CustomerID = 3;