USE AdventureWorks2022
GO

SELECT TOP 1 CustomerID, TotalOnlinePurchaseAmount
FROM (
    SELECT 
        CustomerID,
        SUM(LineTotal) AS TotalOnlinePurchaseAmount,
        ROW_NUMBER() OVER (ORDER BY SUM(LineTotal) DESC) AS RowNumber
    FROM 
        Sales.SalesOrderHeader H
    INNER JOIN 
        Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
    WHERE 
        H.OnlineOrderFlag = 1
    GROUP BY 
        CustomerID
) AS CustomerSales
WHERE 
    RowNumber = 2
ORDER BY 
    TotalOnlinePurchaseAmount DESC
GO
