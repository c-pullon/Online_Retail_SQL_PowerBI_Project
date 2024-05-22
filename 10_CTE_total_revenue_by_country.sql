-- Using CTE to calculate total revenue by country

WITH RevenueByCountry AS (
    SELECT
        c.CountryName,
        SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
    FROM
        dbo.Countries c
        JOIN dbo.Customers cu ON c.CountryID = cu.CountryID
        JOIN dbo.Invoices i ON cu.NewCustomerID = i.NewCustomerID
        JOIN dbo.OrderDetails od ON i.InvoiceID = od.InvoiceID
    GROUP BY
        c.CountryName
)
SELECT
    CountryName,
    TotalRevenue
FROM
    RevenueByCountry
ORDER BY
    TotalRevenue DESC;
