-- Example: Create a stored procedure to retrieve customer details by country
CREATE PROCEDURE GetCustomersByCountry
    @CountryName NVARCHAR(100)
AS
BEGIN
    SELECT C.NewCustomerID, C.CustomerID, Co.CountryName
    FROM dbo.Customers AS C
    JOIN dbo.Countries AS Co ON C.CountryID = Co.CountryID
    WHERE Co.CountryName = @CountryName;
END;

-- Example: Execute the stored procedure to get customers from Spain
EXEC GetCustomersByCountry @CountryName = 'Spain';
