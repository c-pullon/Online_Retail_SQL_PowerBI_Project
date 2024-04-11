SELECT c.CountryName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Countries c
JOIN Customers cu ON c.CountryID = cu.CountryID
JOIN Invoices i ON cu.NewCustomerID = i.NewCustomerID
JOIN OrderDetails od ON i.InvoiceID = od.InvoiceID
GROUP BY c.CountryName
ORDER BY TotalRevenue DESC;
