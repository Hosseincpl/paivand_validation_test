USE AdventureWorks2022
GO
WITH SubcategorySales AS (
    SELECT 
        PC.Name AS Category,
        PS.Name AS Subcategory,
        SUM(D.LineTotal) AS TotalOnlineSales,
        ROW_NUMBER() OVER (PARTITION BY PC.Name ORDER BY SUM(D.LineTotal) DESC) AS SubcategoryRank
    FROM 
        Production.ProductSubcategory PS
    INNER JOIN 
        Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
    INNER JOIN 
        Production.Product P ON PS.ProductSubcategoryID = P.ProductSubcategoryID
    INNER JOIN 
        Sales.SalesOrderDetail D ON P.ProductID = D.ProductID
    INNER JOIN 
        Sales.SalesOrderHeader H ON D.SalesOrderID = H.SalesOrderID
    WHERE 
        H.OnlineOrderFlag = 1
    GROUP BY 
        PC.Name, PS.Name
)
SELECT 
    Category,
    Subcategory,
    TotalOnlineSales,
    SubcategoryRank
FROM 
    SubcategorySales
ORDER BY 
    Category, SubcategoryRank
Go
