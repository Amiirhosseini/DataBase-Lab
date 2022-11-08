-------INITIAL
SELECT * from Sales.SalesOrderHeader;
SELECT * from Sales.SalesTerritory;
SELECT * from Sales.SalesPerson;
SELECT * from SAles.Store;

-------Q1
SELECT
	* 
FROM
	sales.SalesOrderHeader AS sh
	INNER JOIN sales.SalesTerritory AS st ON sh.TerritoryID = st.TerritoryID 
WHERE
	st.[Name] LIKE 'France' 
	AND sh.Status = 5 
	AND sh.TotalDue < 500000 
	AND sh.TotalDue > 100000 UNION
SELECT
	* 
FROM
	sales.SalesOrderHeader AS sh
	INNER JOIN sales.SalesTerritory AS st ON sh.TerritoryID = st.TerritoryID 
WHERE
	st.[Group] LIKE 'North America' 
	AND sh.Status = 5 
	AND sh.TotalDue < 500000 
	AND sh.TotalDue > 100000;
	
	
-------Q2
SELECT
	sh.SalesOrderID,
	sh.CustomerID,
	sh.TotalDue,
	sh.OrderDate,
	st.[Name] 
FROM
	sales.SalesOrderHeader AS sh
	INNER JOIN sales.SalesTerritory AS st ON sh.TerritoryID = st.TerritoryID;
	
	
-------Q3
WITH product_sumOrder_territory ( ProductID, OrderQty, TerritoryID ) AS (
	SELECT
		ProductID,
		SUM ( OrderQty ),
		TerritoryID 
	FROM
		sales.SalesOrderDetail
		INNER JOIN sales.SalesOrderHeader ON sales.SalesOrderDetail.SalesOrderID = sales.SalesOrderHeader.SalesOrderID 
	GROUP BY
		ProductID,
		TerritoryID 
	),
	porduct_maxSell ( ProductID, MuxNum ) AS ( SELECT ProductID, MAX ( OrderQty ) FROM product_sumOrder_territory GROUP BY ProductID ) SELECT
	p.Name AS product_name,
	ss.Name AS territory_name 
FROM
	Production.Product AS p
	INNER JOIN porduct_maxSell AS pm ON pm.ProductID= p.ProductID
	INNER JOIN product_sumOrder_territory AS pst ON pm.ProductID = pst.ProductID
	INNER JOIN Sales.SalesTerritory AS ss ON pst.TerritoryID= ss.TerritoryID 
WHERE
	pm.MuxNum= pst.OrderQty;
	
	
-------Q4
WITH New_Table ( SalesOrderID, OrderDate, Status, CustomerID, TerritoryID, SubTotal, TotalDue ) AS (
	SELECT
		SalesOrderID,
		OrderDate,
		Status,
		CustomerID,
		SalesOrderHeader.TerritoryID,
		SubTotal,
		TotalDue 
	FROM
		Sales.SalesOrderHeader
		INNER JOIN Sales.SalesTerritory ON ( Sales.SalesOrderHeader.TerritoryID= Sales.SalesTerritory.TerritoryID ) 
	WHERE
		[Group] LIKE 'North America' 
		AND Status = 5 
		AND TotalDue < 500000 
		AND TotalDue > 100000 
	) SELECT
	* INTO NAmerica_Sales 
FROM
	New_Table;
SELECT * 
FROM
	NAmerica_Sales;
ALTER TABLE NAmerica_Sales ADD PriceLevel CHAR ( 4 ) CHECK ( PriceLevel IN ( 'Low', 'Mid', 'High' ) );
WITH temp_table ( avgDue ) AS ( SELECT AVG ( TotalDue ) FROM NAmerica_Sales ) UPDATE NAmerica_Sales 
SET NAmerica_Sales.PriceLevel = ( CASE WHEN TotalDue > avgDue THEN 'High' WHEN TotalDue = avgDue THEN 'Mid' WHEN TotalDue < avgDue THEN 'Low' END ) 
	FROM
	NAmerica_Sales,
	temp_table;
	
---------Q5
SELECT BusinessEntityID ,max(Rate) as MuxRate FROM HumanResources.EmployeePayHistory
GROUP BY BusinessEntityID
ORDER BY BusinessEntityID;


SELECT * FROM HumanResources.EmployeePayHistory
ORDER by Rate;


WITH BID_maxRate ( BusinessEntityID, MaxRate ) AS ( SELECT BusinessEntityID, MAX ( Rate ) AS MaxRate FROM HumanResources.EmployeePayHistory GROUP BY BusinessEntityID ),
partitioning ( BusinessEntityID, MaxRate, chart ) AS ( SELECT bm.BusinessEntityID, bm.MaxRate, NTILE ( 4 ) OVER ( ORDER BY bm.maxrate ) chart FROM BID_maxRate AS bm ),
adding ( BusinessEntityID, newMaxRate, chart ) AS (
	SELECT
		p.BusinessEntityID,
	CASE
			
			WHEN p.chart= 1 THEN
			( p.MaxRate* 1.2 ) 
			WHEN p.chart= 2 THEN
			( p.MaxRate* 1.15 ) 
			WHEN p.chart= 3 THEN
			( p.MaxRate* 1.1 ) ELSE ( p.MaxRate* 1.05 ) 
		END AS newMaxRate,
		p.chart 
	FROM
		partitioning AS p 
	),
	leveling ( BusinessEntityID, oldMaxRate, [level] ) AS (
	SELECT
		p.BusinessEntityID,
		p.MaxRate,
	CASE
			
			WHEN p.MaxRate < 29 THEN
			3 
			WHEN p.MaxRate >= 29 
			AND p.MaxRate< 50 THEN
				2 ELSE 1 
				END AS [LEVEL] 
		FROM
			partitioning AS p 
		) SELECT
		l.BusinessEntityID AS BID,
		a.newMaxRate AS NewSalary,
		l.[level] AS [LEVEL] 
	FROM
		leveling AS l,
		adding AS a 
	WHERE
		l.BusinessEntityID= a.BusinessEntityID 
ORDER BY
	BID