USE Test

CREATE TABLE Country (
  Id INT PRIMARY KEY IDENTITY(1, 1), 
  CountryName nvarchar(100),
  CurrencyName nvarchar(50)
); 


CREATE TYPE UT_Country AS TABLE( 
    CountryName nvarchar(100),
    CurrencyName nvarchar(50)
);
GO

CREATE PROCEDURE AddCountries
 @addc UT_Country READONLY
AS
BEGIN
INSERT INTO Country (CountryName, CurrencyName)
SELECT CountryName,CurrencyName FROM @addc
END
GO

DECLARE @addc as UT_Country
INSERT INTO @addc VALUES ('India','Indian Rupee'),('UAE','Dirham')
EXEC AddCountries @addc

SELECT * from Country