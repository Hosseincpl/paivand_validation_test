CREATE PROCEDURE GetInternetSalesCountByProductID
    @ProductID INT
AS
BEGIN
    SELECT 
        COUNT(DISTINCT H.SalesOrderID) AS InternetSalesCount
    FROM 
        Sales.SalesOrderHeader H
    INNER JOIN 
        Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
    WHERE 
        H.OnlineOrderFlag = 1
        AND D.ProductID = @ProductID;
END
GO

EXEC GetInternetSalesCountByProductID @ProductID = 776
GO
