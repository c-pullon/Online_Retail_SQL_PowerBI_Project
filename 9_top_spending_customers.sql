SELECT cu.NewCustomerID, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Customers cu
JOIN Invoices i ON cu.NewCustomerID = i.NewCustomerID
JOIN OrderDetails od ON i.InvoiceID = od.InvoiceID
GROUP BY cu.NewCustomerID
ORDER BY TotalRevenue DESC;
