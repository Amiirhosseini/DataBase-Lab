--Amirreza Hosseini 9820363
--Exp 8
--Q1-part1

use AdventureWorks2012
GO

begin tran
update Sales.SalesPerson
set Sales.SalesPerson.TerritoryID='3'
where Sales.SalesPerson.BusinessEntityID='277'

waitfor delay '00:00:15'

update Sales.Store
set [Name]='Amir'
where Sales.Store.BusinessEntityID='292'

waitfor delay '00:00:10'

commit tran