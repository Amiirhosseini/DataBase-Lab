--Amirreza Hosseini 9820363
--Exp 8
--Q2-part1

USE AdventureWorks2012;
GO

--dirty read  
BEGIN TRAN;
SELECT Sales.SalesPerson.BusinessEntityID, 
       Sales.SalesPerson.SalesQuota
FROM Sales.SalesPerson
WHERE Sales.SalesPerson.BusinessEntityID = '275';
WAITFOR DELAY '00:00:10';
UPDATE Sales.SalesPerson
  SET 
      Sales.SalesPerson.SalesQuota = 763923.10
WHERE Sales.SalesPerson.BusinessEntityID = '275';
SELECT Sales.SalesPerson.BusinessEntityID, 
       Sales.SalesPerson.SalesQuota
FROM Sales.SalesPerson
WHERE Sales.SalesPerson.BusinessEntityID = '275';



--non reapeatable read
BEGIN TRAN;
SELECT Sales.SalesTaxRate.SalesTaxRateID, 
       Sales.SalesTaxRate.TaxRate
FROM Sales.SalesTaxRate
WHERE Sales.SalesTaxRate.SalesTaxRateID = '1';
WAITFOR DELAY '00:00:5';
UPDATE Sales.SalesTaxRate
  SET 
      Sales.SalesTaxRate.TaxRate = Sales.SalesTaxRate.TaxRate + 1
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
WAITFOR DELAY '00:00:5';
SELECT Sales.SalesTaxRate.SalesTaxRateID, 
       Sales.SalesTaxRate.TaxRate
FROM Sales.SalesTaxRate
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
WAITFOR DELAY '00:00:5';
UPDATE Sales.SalesTaxRate
  SET 
      Sales.SalesTaxRate.TaxRate = Sales.SalesTaxRate.TaxRate + 1
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
WAITFOR DELAY '00:00:5';
SELECT Sales.SalesTaxRate.SalesTaxRateID, 
       Sales.SalesTaxRate.TaxRate
FROM Sales.SalesTaxRate
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
COMMIT TRAN;