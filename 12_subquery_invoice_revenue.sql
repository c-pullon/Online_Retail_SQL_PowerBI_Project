-- calculating total revenue for each invoice

SELECT InvoiceID, InvoiceNo,
    (SELECT SUM(Quantity * UnitPrice)
     FROM dbo.OrderDetails
     WHERE InvoiceID = I.InvoiceID) AS TotalRevenue
FROM dbo.Invoices AS I
ORDER BY TotalRevenue DESC
