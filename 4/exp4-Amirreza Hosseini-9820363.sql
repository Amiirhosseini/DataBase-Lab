--Amirreza Hosseini 9820363
--EXP4

-----------------Q1
USE AdventureWorks2012;
GO
USE AdventureWorks2012;
GO
SELECT Sales.SalesOrderHeader.CustomerID, 
       Sales.SalesOrderHeader.SalesOrderID, 
       Sales.SalesOrderHeader.OrderDate, 
       Sales.SalesOrderDetail.LineTotal, 
       AVG(Sales.SalesOrderDetail.LineTotal) OVER(PARTITION BY Sales.SalesOrderHeader.CustomerID
       ORDER BY Sales.SalesOrderHeader.OrderDate, 
                Sales.SalesOrderHeader.SalesOrderID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM Sales.SalesOrderHeader
     JOIN Sales.SalesOrderDetail ON(SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID)
order by orderdate,SalesOrderID

------------------Q2
SELECT CASE GROUPING(Sales.SalesTerritory.[Name])
           WHEN 1
           THEN 'ALL Territories'
           WHEN 0
           THEN Sales.SalesTerritory.[Name]
       END AS TerritoryName,
       CASE GROUPING(Sales.SalesTerritory.[Group])
           WHEN 1
           THEN 'ALL Region'
           WHEN 0
           THEN Sales.SalesTerritory.[Group]
       END AS Region, 
       SUM(sales.SalesOrderHeader.SubTotal) AS SalesTotal, 
       COUNT(Sales.SalesOrderHeader.SalesOrderID) AS SalesCount
FROM Sales.SalesTerritory
     INNER JOIN Sales.SalesOrderHeader ON(Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID)
GROUP BY ROLLUP(Sales.SalesTerritory.[Group], Sales.SalesTerritory.[Name])


--------------Q3
			   SELECT CASE GROUPING(Production.ProductSubcategory.Name)
           WHEN 1
           THEN 'ALL SubCategory'
           WHEN 0
           THEN Production.ProductSubcategory.Name
       END AS Subcategory,
       CASE GROUPING(Production.ProductCategory.Name)
           WHEN 0
           THEN Production.ProductCategory.Name
           WHEN 1
           THEN CASE GROUPING(Production.ProductSubcategory.Name)
                    WHEN 0
                    THEN Production.ProductCategory.Name
                    WHEN 1
                    THEN 'ALL Category'
                END
       END AS Category, 
       COUNT(Sales.SalesOrderDetail.OrderQty) AS SalesCount, 
       SUM(Sales.SalesOrderDetail.LineTotal) AS SalesTotal
FROM Sales.SalesOrderDetail
     INNER JOIN Production.Product ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
     INNER JOIN Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
     INNER JOIN Production.ProductCategory ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
GROUP BY ROLLUP(Production.ProductCategory.Name, Production.ProductSubcategory.Name) --- hierarchy important
ORDER BY SubCategory, 
         Category DESC;

--------------Q4
WITH karmand(ID, 
             gender, 
             mstate, 
             onvan)
     AS (SELECT h.NationalIDNumber,
                CASE h.Gender
                    WHEN 'F'
                    THEN 'Female'
                    WHEN 'M'
                    THEN 'Male'
                END AS gender,
                CASE h.MaritalStatus
                    WHEN 'S'
                    THEN 'Single'
                    WHEN 'M'
                    THEN 'Married'
                END AS mstate, 
                h.JobTitle
         FROM HumanResources.Employee AS h),
     onvan_num(onvan, 
               number)
     AS (SELECT e.JobTitle, 
                COUNT(e.JobTitle) AS number
         FROM HumanResources.Employee e
         GROUP BY(e.JobTitle)
         HAVING COUNT(e.JobTitle) > 3)
     SELECT karmand.ID AS nationalID, 
            karmand.gender, 
            karmand.mstate AS marriageState, 
            karmand.onvan AS title, 
            onvan_num.number AS numberOFworkers
     FROM karmand
          INNER JOIN onvan_num ON karmand.onvan = onvan_num.onvan;