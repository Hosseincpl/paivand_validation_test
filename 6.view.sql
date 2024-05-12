CREATE VIEW TopSellingProducts AS
SELECT TOP 3 WITH TIES
    D.ProductID,
    P.Name AS ProductName,
    SUM(D.LineTotal) AS TotalSalesAmount
FROM 
    Sales.SalesOrderDetail D
INNER JOIN 
    Production.Product P ON D.ProductID = P.ProductID
INNER JOIN 
    Sales.SalesOrderHeader H ON D.SalesOrderID = H.SalesOrderID
WHERE 
    H.OnlineOrderFlag = 1
GROUP BY 
    D.ProductID, P.Name
ORDER BY 
    SUM(D.LineTotal) DESC
GO


SELECT * FROM TopSellingProducts
GO
