--Amirreza Hosseini 9820363
--Exp 8
--Q1-part2

use AdventureWorks2012
GO

begin tran
select  [Name] from Sales.Store
where Sales.Store.BusinessEntityID='292'

waitfor delay '00:00:10'

select  Sales.SalesPerson.TerritoryID from Sales.SalesPerson
where Sales.SalesPerson.BusinessEntityID='277'


waitfor delay '00:00:02'

--commit Tran