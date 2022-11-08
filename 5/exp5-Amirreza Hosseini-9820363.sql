--Amirreza Hosseini 9820363
--EXP5

USE AdventureWorks2012;
GO
-----------------Q1
SELECT [Name], 
       [Europe], 
       [North America], 
       [Pacific]
FROM
(
    SELECT Production.Product.[Name], 
           Sales.SalesTerritory.[Group], 
           Sales.SalesOrderDetail.OrderQty
    FROM Production.Product, 
         Sales.SalesOrderDetail, 
         Sales.SalesOrderHeader, 
         Sales.SalesTerritory
    WHERE Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
          AND Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
          AND Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
) AS Q1_sample 
PIVOT(COUNT(Q1_sample.OrderQty) FOR [Group] IN([Europe], 
                                                      [North America], 
                                                      [Pacific])) AS pvt;

-----------------Q2
SELECT [PersonType], 
       [M], 
       [F]
FROM
(
    SELECT Person.Person.PersonType, 
           HumanResources.Employee.Gender, 
           Person.Person.BusinessEntityID
    FROM Person.Person
         JOIN HumanResources.Employee ON(Person.BusinessEntityID = Employee.BusinessEntityID)
) AS Q2_sample 
PIVOT(COUNT(BusinessEntityID) FOR Gender IN([M], [F])) AS pvt;

-----------------Q3
SELECT pp.[Name]
FROM Production.Product	AS pp
WHERE LEN(pp.[Name]) < 15
      AND PATINDEX('%e%', pp.[Name]) = LEN(pp.[Name]) - 1;

------------------Q4
DROP FUNCTION IF EXISTS Q4_Func;

GO
CREATE FUNCTION Q4_Func(@input CHAR(10))
RETURNS VARCHAR(32)
AS
     BEGIN
         DECLARE @return VARCHAR(32);
         DECLARE @Day VARCHAR(10);
         DECLARE @temp VARCHAR(10);
         DECLARE @Month VARCHAR(10);
         DECLARE @year VARCHAR(10);
		 SET @temp = LEFT(@input, 7);
         SET @Day = RIGHT(@input, 2);
         SET @Month = RIGHT(@temp, 2);
         SET @year = LEFT(@temp, 4);
         IF --wrong input 
         (LEN(@input) != 10
          OR (LEN(@Day) != 2
              OR ISNUMERIC(@Day) = 0)
          OR (LEN(@Month) != 2
              OR ISNUMERIC(@Month) = 0)
          OR (LEN(@year) != 4
              OR ISNUMERIC(@year) = 0))
             SET @return = 'Wrong format';
             ELSE --input form is correct
             BEGIN
                 IF @Month = '01'
                     SET @return = @Day + ' Farvardin mah ' + @year + ' Shamsi';
                 IF @Month = '02'
                     SET @return = @Day + ' Ordibehesht mah ' + @year + ' Shamsi';
                 IF @Month = '03'
                     SET @return = @Day + ' Khordad mah ' + @year + ' Shamsi';
                 IF @Month = '04'
                     SET @return = @Day + ' Tir mah ' + @year + ' Shamsi';
                 IF @Month = '05'
                     SET @return = @Day + ' Mordad mah ' + @year + ' Shamsi';
                 IF @Month = '06'
                     SET @return = @Day + ' Shahrivar mah ' + @year + ' Shamsi';
                 IF @Month = '07'
                     SET @return = @Day + ' Mehr mah ' + @year + ' Shamsi';
                 IF @Month = '08'
                     SET @return = @Day + ' Aban mah ' + @year + ' Shamsi';
                 IF @Month = '09'
                     SET @return = @Day + ' Azar mah ' + @year + ' Shamsi';
                 IF @Month = '10'
                     SET @return = @Day + ' Month mah ' + @year + ' Shamsi';
                 IF @Month = '11'
                     SET @return = @Day + ' Bahman mah ' + @year + ' Shamsi';
                 IF @Month = '12'
                     SET @return = @Day + ' Esfand mah ' + @year + ' Shamsi';
         END;
         RETURN @return;
     END;
GO

Select dbo.Q4_Func ('1399/05/04');
Select dbo.Q4_Func ('1401/11/27');
Select dbo.Q4_Func ('99/01we/03');
Select dbo.Q4_Func ('13399/01/');


------------------Q5
DROP FUNCTION IF EXISTS Q5_Func;
GO
CREATE FUNCTION Q5_Func
(@year  INT, 
 @month INT, 
 @product  VARCHAR(50)
)
RETURNS TABLE
AS
     RETURN
(
    SELECT DISTINCT 
           Sales.SalesTerritory.[Name]
    FROM Production.Product
         INNER JOIN Sales.SalesOrderDetail ON(Production.Product.ProductID = Sales.SalesOrderDetail.ProductID)
         INNER JOIN Sales.SalesOrderHeader ON(Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID)
         INNER JOIN Sales.SalesTerritory ON(Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID)
    WHERE YEAR(Sales.SalesOrderHeader.OrderDate) = @year
          AND MONTH(Sales.SalesOrderHeader.OrderDate) = @month
          AND Production.Product.[Name] = @product
);
GO

SELECT *
FROM Q5_Func(2005, 07, 'Mountain-100 Black, 44');

SELECT *
FROM Q5_Func(2005, 08, 'Mountain-100 Black, 44');