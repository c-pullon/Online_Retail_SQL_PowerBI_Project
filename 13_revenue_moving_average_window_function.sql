-- 3 month moving average of total revenue
SELECT
    InvoiceDate,
    SUM(Quantity * UnitPrice) AS MonthlyRevenue,
    AVG(SUM(Quantity * UnitPrice)) OVER (ORDER BY InvoiceDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM dbo.Invoices AS I
JOIN dbo.OrderDetails AS OD ON I.InvoiceID = OD.InvoiceID
GROUP BY InvoiceDate
ORDER BY InvoiceDate;
