--Amirreza Hosseini 9820363
--Exp 7

USE AdventureWorks2012;
GO
--present working path
--E:\DB\Lab\7

sp_configure 
 'show advanced options', 
 1;
RECONFIGURE;
GO
sp_configure 
 'Ad Hoc Distributed Queries', 
 1;
RECONFIGURE;
GO
EXEC sp_configure 
     'Advanced', 
     1;
RECONFIGURE;
EXEC sp_configure 
     'Ad Hoc Distributed Queries', 
     1;
RECONFIGURE;
EXEC master.dbo.sp_MSset_oledb_prop 
     N'Microsoft.ACE.OLEDB.12.0', 
     N'AllowInProcess', 
     1;
EXEC master.dbo.sp_MSset_oledb_prop 
     N'Microsoft.ACE.OLEDB.12.0', 
     N'DynamicParameters', 
     1;
GO
EXEC sp_configure 
     'xp_cmdshell', 
     1;
GO
-- To update the currently configured value for this feature.
RECONFIGURE;
GO
																			  
---------Q1
EXEC xp_cmdshell 
     'bcp AdventureWorks2012.Sales.SalesTerritory out E:\DB\Lab\7\Q1.txt -T -c -t^|';

CREATE TABLE [Sales].[SalesTerritoryNew]
([TerritoryID]       [INT], 
 [Name]              [dbo].[Name], 
 [CountryRegionCode] [NVARCHAR](3), 
 [Group]             [NVARCHAR](50), 
 [SalesYTD]          [MONEY], 
 [SalesLastYear]     [MONEY], 
 [CostYTD]           [MONEY], 
 [CostLastYear]      [MONEY], 
 [rowguid]           [UNIQUEIDENTIFIER], 
 [ModifiedDate]      [DATETIME]
);
--drop table [Sales].[SalesTerritoryNew]
BULK INSERT [Sales].[SalesTerritoryNew] FROM 'E:\DB\Lab\7\Q1.txt' WITH(FIELDTERMINATOR = '|');

SELECT *
FROM AdventureWorks2012.[Sales].[SalesTerritoryNew];
																														 
---------Q2
EXEC xp_cmdshell 
     'bcp "select [Name],TerritoryID  from AdventureWorks2012.Sales.SalesTerritory" queryout E:\DB\Lab\7\Q2.txt -T -c -t^|';


---------Q3
exec xp_cmdshell 'bcp AdventureWorks2012.Production.Location out E:\DB\Lab\7\location.dat  -T -c -t,'



 ---------Q4
SELECT [Name], 
       Demographics.query('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $x in /StoreSurvey
return 
<AnnualSales>
{$x/AnnualSales}
</AnnualSales>') AS Annual_Sales, 
       Demographics.query('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $y in /StoreSurvey 
return 
<YearOpened>
{$y/YearOpened}
</YearOpened>') AS Year_Opened, 
       Demographics.query('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $z in /StoreSurvey
return  
<NumberEmployees>
{$z/NumberEmployees}
</NumberEmployees>') AS Number_of_Employees
FROM AdventureWorks2012.Sales.Store;

EXEC xp_cmdshell 
     'bcp "select Name, Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $x in /StoreSurvey return  <AnnualSales>{$x/AnnualSales}</AnnualSales>'') as Annual_Sales,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $y in /StoreSurvey return <YearOpened>{$y/YearOpened}</YearOpened>'') as Year_Opened,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $z in /StoreSurvey return  <NumberEmployees>{$z/NumberEmployees}</NumberEmployees>'') as Number_of_Employees from AdventureWorks2012.Sales.Store" queryout E:\DB\Lab\7\Q4.txt -T -c -q -t,';
