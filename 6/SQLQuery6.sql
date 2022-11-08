--Amirreza Hosseini 9820363
--EXP6

USE AdventureWorks2012;
GO
-----------------Q1
CREATE TABLE Production.ProductLogs(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25),
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15),
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint] ,
	[StandardCost] [money] ,
	[ListPrice] [money] ,
	[Size] [nvarchar](5) ,
	[SizeUnitMeasureCode] [nchar](3) ,
	[WeightUnitMeasureCode] [nchar](3) ,
	[Weight] [decimal](8, 2) ,
	[DaysToManufacture] [int] ,
	[ProductLine] [nchar](2) ,
	[Class] [nchar](2) ,
	[Style] [nchar](2) ,
	[ProductSubcategoryID] [int] ,
	[ProductModelID] [int] ,
	[SellStartDate] [datetime] ,
	[SellEndDate] [datetime] ,
	[DiscontinuedDate] [datetime] ,
	[rowguid] [uniqueidentifier],
	[ModifiedDate] [datetime] ,
	[change] varchar(10)
	);
CREATE TABLE Production.ProductLogsCopy(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25),
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15),
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint] ,
	[StandardCost] [money] ,
	[ListPrice] [money] ,
	[Size] [nvarchar](5) ,
	[SizeUnitMeasureCode] [nchar](3) ,
	[WeightUnitMeasureCode] [nchar](3) ,
	[Weight] [decimal](8, 2) ,
	[DaysToManufacture] [int] ,
	[ProductLine] [nchar](2) ,
	[Class] [nchar](2) ,
	[Style] [nchar](2) ,
	[ProductSubcategoryID] [int] ,
	[ProductModelID] [int] ,
	[SellStartDate] [datetime] ,
	[SellEndDate] [datetime] ,
	[DiscontinuedDate] [datetime] ,
	[rowguid] [uniqueidentifier],
	[ModifiedDate] [datetime] ,
	[change] varchar(10)
	);
select * from Production.Product
select * from Production.ProductLogs
drop table Production.ProductLogs
delete from Production.ProductLogsCopy

GO
CREATE TRIGGER ProductTrigger1 ON Production.Product
AFTER INSERT
AS
     BEGIN
         INSERT INTO Production.ProductLogs
         (ProductID, 
          [Name], 
          ProductNumber, 
          MakeFlag, 
          FinishedGoodsFlag, 
          Color, 
          SafetyStockLevel, 
          ReorderPoint, 
          StandardCost, 
          ListPrice, 
          Size, 
          SizeUnitMeasureCode, 
          WeightUnitMeasureCode, 
          [Weight], 
          DaysToManufacture, 
          ProductLine, 
          Class, 
          Style, 
          ProductSubcategoryID, 
          ProductModelID, 
          SellStartDate, 
          SellEndDate, 
          DiscontinuedDate, 
          rowguid, 
          ModifiedDate, 
          [change]
         )
                SELECT ProductID, 
                       [Name], 
                       ProductNumber, 
                       MakeFlag, 
                       FinishedGoodsFlag, 
                       Color, 
                       SafetyStockLevel, 
                       ReorderPoint, 
                       StandardCost, 
                       ListPrice, 
                       Size, 
                       SizeUnitMeasureCode, 
                       WeightUnitMeasureCode, 
                       [Weight], 
                       DaysToManufacture, 
                       ProductLine, 
                       Class, 
                       Style, 
                       ProductSubcategoryID, 
                       ProductModelID, 
                       SellStartDate, 
                       SellEndDate, 
                       DiscontinuedDate, 
                       rowguid, 
                       ModifiedDate, 
                       'INSERT'
                FROM inserted;
     END;

GO
CREATE TRIGGER ProductTrigger2 ON Production.Product
AFTER UPDATE
AS
     BEGIN
         INSERT INTO Production.ProductLogs
         (ProductID, 
          [Name], 
          ProductNumber, 
          MakeFlag, 
          FinishedGoodsFlag, 
          Color, 
          SafetyStockLevel, 
          ReorderPoint, 
          StandardCost, 
          ListPrice, 
          Size, 
          SizeUnitMeasureCode, 
          WeightUnitMeasureCode, 
          [Weight], 
          DaysToManufacture, 
          ProductLine, 
          Class, 
          Style, 
          ProductSubcategoryID, 
          ProductModelID, 
          SellStartDate, 
          SellEndDate, 
          DiscontinuedDate, 
          rowguid, 
          ModifiedDate, 
          [change]
         )
                SELECT ProductID, 
                       [Name], 
                       ProductNumber, 
                       MakeFlag, 
                       FinishedGoodsFlag, 
                       Color, 
                       SafetyStockLevel, 
                       ReorderPoint, 
                       StandardCost, 
                       ListPrice, 
                       Size, 
                       SizeUnitMeasureCode, 
                       WeightUnitMeasureCode, 
                       [Weight], 
                       DaysToManufacture, 
                       ProductLine, 
                       Class, 
                       Style, 
                       ProductSubcategoryID, 
                       ProductModelID, 
                       SellStartDate, 
                       SellEndDate, 
                       DiscontinuedDate, 
                       rowguid, 
                       ModifiedDate, 
                       'UPDATE'
                FROM inserted;
     END;


GO
CREATE TRIGGER ProductTrigger3 ON Production.Product
AFTER DELETE
AS
     BEGIN
         INSERT INTO Production.ProductLogs
         (ProductID, 
          [Name], 
          ProductNumber, 
          MakeFlag, 
          FinishedGoodsFlag, 
          Color, 
          SafetyStockLevel, 
          ReorderPoint, 
          StandardCost, 
          ListPrice, 
          Size, 
          SizeUnitMeasureCode, 
          WeightUnitMeasureCode, 
          [Weight], 
          DaysToManufacture, 
          ProductLine, 
          Class, 
          Style, 
          ProductSubcategoryID, 
          ProductModelID, 
          SellStartDate, 
          SellEndDate, 
          DiscontinuedDate, 
          rowguid, 
          ModifiedDate, 
          [change]
         )
                SELECT ProductID, 
                       [Name], 
                       ProductNumber, 
                       MakeFlag, 
                       FinishedGoodsFlag, 
                       Color, 
                       SafetyStockLevel, 
                       ReorderPoint, 
                       StandardCost, 
                       ListPrice, 
                       Size, 
                       SizeUnitMeasureCode, 
                       WeightUnitMeasureCode, 
                       [Weight], 
                       DaysToManufacture, 
                       ProductLine, 
                       Class, 
                       Style, 
                       ProductSubcategoryID, 
                       ProductModelID, 
                       SellStartDate, 
                       SellEndDate, 
                       DiscontinuedDate, 
                       rowguid, 
                       ModifiedDate, 
                       'DELETE'
                FROM deleted;
     END;


INSERT INTO Production.Product
([Name], 
 ProductNumber, 
 MakeFlag, 
 FinishedGoodsFlag, 
 Color, 
 SafetyStockLevel, 
 ReorderPoint, 
 StandardCost, 
 ListPrice, 
 Size, 
 SizeUnitMeasureCode, 
 WeightUnitMeasureCode, 
 [Weight], 
 DaysToManufacture, 
 ProductLine, 
 Class, 
 Style, 
 ProductSubcategoryID, 
 ProductModelID, 
 SellStartDate, 
 SellEndDate, 
 DiscontinuedDate, 
 rowguid, 
 ModifiedDate
)
VALUES
('product1', 
 '12345', 
 0, 
 0, 
 'red', 
 4000, 
 520, 
 10000, 
 10000, 
 NULL, 
 NULL, 
 NULL, 
 NULL, 
 0, 
 NULL, 
 NULL, 
 NULL, 
 NULL, 
 NULL, 
 '2001-04-30 00:00:00.000', 
 NULL, 
 NULL, 
 '694215b7-08f7-4c0d-acb1-d734bab4c0c8', 
 '2014-02-08 10:01:36.827'
);


DELETE FROM Production.Product
WHERE ProductNumber = '12345';


INSERT INTO Production.Product
([Name], 
 ProductNumber, 
 MakeFlag, 
 FinishedGoodsFlag, 
 Color, 
 SafetyStockLevel, 
 ReorderPoint, 
 StandardCost, 
 ListPrice, 
 Size, 
 SizeUnitMeasureCode, 
 WeightUnitMeasureCode, 
 [Weight], 
 DaysToManufacture, 
 ProductLine, 
 Class, 
 Style, 
 ProductSubcategoryID, 
 ProductModelID, 
 SellStartDate, 
 SellEndDate, 
 DiscontinuedDate, 
 rowguid, 
 ModifiedDate
)
VALUES
('product2', 
 '6789', 
 0, 
 0, 
 'blue', 
 4000, 
 20, 
 10000, 
 10000, 
 NULL, 
 NULL, 
 NULL, 
 NULL, 
 0, 
 NULL, 
 NULL, 
 NULL, 
 NULL, 
 NULL, 
 '2001-04-30 00:00:00.000', 
 NULL, 
 NULL, 
 '694215b7-08f7-4c0d-acb1-d734bab4c0c8', 
 '2016-02-09 10:01:36.827'
);


DELETE FROM Production.Product
WHERE ProductNumber = '6789';
UPDATE Production.Product
  SET 
      MakeFlag = 1
WHERE ProductNumber = '6789';




-----------------Q2
INSERT INTO Production.ProductLogsCopy
       SELECT *
       FROM Production.ProductLogs;

SELECT *
FROM Production.ProductLogsCopy;

UPDATE Production.ProductLogsCopy
  SET 
      Color = 'green'
WHERE ProductID = 1000
      AND [change] = 'INSERT';
UPDATE Production.ProductLogsCopy
  SET 
      Color = 'yellow'
WHERE ProductID = 1001
      AND [change] = 'UPDATE';

-----------------Q3
CREATE TABLE Production.ProductLogsDiff(
	[ProductID] [int] ,
	[Name] [dbo].[Name] ,
	[ProductNumber] [nvarchar](25),
	[MakeFlag] [dbo].[Flag] ,
	[FinishedGoodsFlag] [dbo].[Flag] ,
	[Color] [nvarchar](15),
	[SafetyStockLevel] [smallint] ,
	[ReorderPoint] [smallint] ,
	[StandardCost] [money] ,
	[ListPrice] [money] ,
	[Size] [nvarchar](5) ,
	[SizeUnitMeasureCode] [nchar](3) ,
	[WeightUnitMeasureCode] [nchar](3) ,
	[Weight] [decimal](8, 2) ,
	[DaysToManufacture] [int] ,
	[ProductLine] [nchar](2) ,
	[Class] [nchar](2) ,
	[Style] [nchar](2) ,
	[ProductSubcategoryID] [int] ,
	[ProductModelID] [int] ,
	[SellStartDate] [datetime] ,
	[SellEndDate] [datetime] ,
	[DiscontinuedDate] [datetime] ,
	[rowguid] [uniqueidentifier],
	[ModifiedDate] [datetime] ,
	[change] varchar(10)
	);

select * from Production.ProductLogsDiff

go
CREATE PROCEDURE diff
AS
BEGIN
WITH temp as (select * from Production.ProductLogs except select * from Production.ProductLogsCopy)
insert into Production.ProductLogsDiff select * from temp
END

EXECUTE diff;