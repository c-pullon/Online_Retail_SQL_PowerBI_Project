
-- monthly revenue temp table
CREATE TABLE #MonthlyRevenue (
    Month DATE,
    TotalRevenue DECIMAL(18, 2)
);

INSERT INTO #MonthlyRevenue (Month, TotalRevenue)
SELECT
    DATEFROMPARTS(YEAR(I.InvoiceDate), MONTH(I.InvoiceDate), 1) AS Month,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalRevenue
FROM
    dbo.Invoices I
    JOIN dbo.OrderDetails OD ON I.InvoiceID = OD.InvoiceID
GROUP BY
    YEAR(I.InvoiceDate), MONTH(I.InvoiceDate);

SELECT TOP 1 * FROM #MonthlyRevenue
ORDER BY TotalRevenue DESC;

-- Drop the temporary table
DROP TABLE #MonthlyRevenue;
