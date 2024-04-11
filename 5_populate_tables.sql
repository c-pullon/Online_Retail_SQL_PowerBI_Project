-- Populate Countries Table
INSERT INTO Countries (CountryName)
SELECT DISTINCT Country
FROM full_dataset;

-- Populate Customers Table
INSERT INTO Customers (CustomerID, CountryID)
SELECT DISTINCT f.CustomerID, c.CountryID
FROM full_dataset f
INNER JOIN Countries c ON f.Country = c.CountryName;

-- Populate Products Table
INSERT INTO Products (StockCode, Description)
SELECT DISTINCT StockCode, Description
FROM full_dataset;

-- Populate Invoices Table
INSERT INTO Invoices (InvoiceNo, InvoiceDate, NewCustomerID)
SELECT DISTINCT f.InvoiceNo, f.InvoiceDate, c.NewCustomerID
FROM full_dataset f
INNER JOIN Customers c ON f.CustomerID = c.CustomerID;

-- Populate OrderDetails Table
INSERT INTO OrderDetails (InvoiceID, ProductID, Quantity, UnitPrice)
SELECT i.InvoiceID, p.ProductID, f.Quantity, f.UnitPrice
FROM full_dataset f
INNER JOIN Invoices i ON f.InvoiceNo = i.InvoiceNo
INNER JOIN Products p ON f.StockCode = p.StockCode;

