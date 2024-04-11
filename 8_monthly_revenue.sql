SELECT YEAR(i.InvoiceDate) AS Year, MONTH(i.InvoiceDate) AS Month, SUM(od.Quantity * od.UnitPrice) AS MonthlyRevenue
FROM Invoices i
JOIN OrderDetails od ON i.InvoiceID = od.InvoiceID
GROUP BY YEAR(i.InvoiceDate), MONTH(i.InvoiceDate)
ORDER BY Year, Month;
