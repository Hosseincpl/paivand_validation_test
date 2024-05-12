USE AdventureWorks2022
GO

SELECT
    CASE T.[Name]
        WHEN 'northwest' THEN 'USA'
        WHEN 'northeast' THEN 'USA'
        WHEN 'central'   THEN 'USA'
        WHEN 'southwest' THEN 'USA'
        WHEN 'southeast' THEN 'USA'
        ELSE T.[Name]
    END AS CountryName,
    SUM(D.LineTotal) AS TotalOnlineSales
FROM 
    Sales.SalesOrderHeader H
INNER JOIN 
    Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
INNER JOIN 
    Sales.SalesTerritory T ON T.TerritoryID = H.TerritoryID
WHERE 
    H.OnlineOrderFlag = 1
GROUP BY 
    CASE T.[Name]
        WHEN 'northwest' THEN 'USA'
        WHEN 'northeast' THEN 'USA'
        WHEN 'central'   THEN 'USA'
        WHEN 'southwest' THEN 'USA'
        WHEN 'southeast' THEN 'USA'
        ELSE T.[Name]
    END
GO