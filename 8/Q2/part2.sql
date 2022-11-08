--Amirreza Hosseini 9820363
--Exp 8
--Q2-part2

USE AdventureWorks2012;
GO

--dirty read  
BEGIN TRAN;
SELECT Sales.SalesPerson.BusinessEntityID, 
       Sales.SalesPerson.SalesQuota
FROM Sales.SalesPerson
WHERE Sales.SalesPerson.BusinessEntityID = '275';


--non reapeatable  
BEGIN TRAN;
SELECT Sales.SalesTaxRate.SalesTaxRateID, 
       Sales.SalesTaxRate.TaxRate
FROM Sales.SalesTaxRate
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
UPDATE Sales.SalesTaxRate
  SET 
      Sales.SalesTaxRate.TaxRate = Sales.SalesTaxRate.TaxRate + 1
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
SELECT Sales.SalesTaxRate.SalesTaxRateID, 
       Sales.SalesTaxRate.TaxRate
FROM Sales.SalesTaxRate
WHERE Sales.SalesTaxRate.SalesTaxRateID = '2';
COMMIT TRAN;