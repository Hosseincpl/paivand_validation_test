CREATE PROCEDURE GetInternetSalesGrowthByYear
    @Year INT
AS
BEGIN
    DECLARE @StartDate DATE = CONVERT(DATE, CONVERT(VARCHAR(4), @Year) + '-01-01');
    DECLARE @EndDate DATE = CONVERT(DATE, CONVERT(VARCHAR(4), @Year) + '-12-31');

    WITH MonthlySales AS (
        SELECT 
            MONTH(H.OrderDate) AS MonthNumber,
            YEAR(H.OrderDate) AS Year,
            SUM(D.LineTotal) AS TotalMonthlySales
        FROM 
            Sales.SalesOrderHeader H
        INNER JOIN 
            Sales.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
        WHERE 
            H.OnlineOrderFlag = 1
            AND H.OrderDate >= @StartDate
            AND H.OrderDate <= @EndDate
        GROUP BY 
            YEAR(H.OrderDate), MONTH(H.OrderDate)
    )
    SELECT 
        MonthNumber,
        COALESCE((TotalMonthlySales - LAG(TotalMonthlySales) OVER (ORDER BY MonthNumber)) / NULLIF(LAG(TotalMonthlySales) OVER (ORDER BY MonthNumber), 0) * 100, 0) AS SalesGrowthPercentage
    FROM 
        MonthlySales
    ORDER BY 
        MonthNumber;
END;

EXEC GetInternetSalesGrowthByYear @Year = 2023; -- Replace 2023 with the desired year
