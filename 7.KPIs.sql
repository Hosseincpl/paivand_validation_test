use AdventureWorks2022

-- AverageOrderValue
SELECT AVG(TotalDue) AS AverageOrderValue
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1
GO

-- InternetSalesPercentage
-- due to number od orders
SELECT 
    (CAST(COUNT(CASE WHEN OnlineOrderFlag = 1 THEN 1 END) AS FLOAT) / CAST(COUNT(*) AS FLOAT)) * 100 AS InternetSalesPercentage
FROM Sales.SalesOrderHeader
GO
-- due to price
SELECT 
    (CAST(SUM(CASE WHEN OnlineOrderFlag = 1 THEN TotalDue ELSE 0 END) AS FLOAT) / CAST(SUM(TotalDue) AS FLOAT)) * 100 AS InternetSalesPercentage
FROM Sales.SalesOrderHeader
GO