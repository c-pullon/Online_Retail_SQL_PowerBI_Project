## Introduction
This project focuses on analysing an online retail dataset using SQL to derive insights and build a normalised database schema. The dataset includes information about invoices, products, customers, and countries.

Simple queries are first performed to find total revenue by country, top selling products etc before moving on to more complex queries using subqueries, window functions, CTEs, stored procedures, and temp tables.

Following analysis in SQL, the database is imported into Power BI where an interactive dashboard is created to clearly illustrate key relationships and patterns.

## Tools Used
- **SQL Server** for database management and executing SQL queries.
- **GitBash** for version control and managing the repository.
- **Power BI** for visualising insights and dashboard creation.
- **VSCode** for editing the readme markdown file.

## Schema Creation in SQL 
The initial dataset is a single CSV file, which is imported into SQL Server as one table.

**Table creation.** Here a table is created with columns defined as VARCHAR initially for flexible data import.
```sql
-- Define and populate initial table from CSV file
USE Online_Retail;

CREATE TABLE full_dataset (
    InvoiceNo VARCHAR(25) NOT NULL,
    StockCode VARCHAR(25) NOT NULL,
    Description VARCHAR(50) NOT NULL,
    Quantity VARCHAR(25) NOT NULL,
    InvoiceDate VARCHAR(25) NOT NULL,
    UnitPrice VARCHAR(25) NOT NULL,
    CustomerID VARCHAR(25) NOT NULL,
    Country VARCHAR(50)
);
```
**Population.** Bulk insert is used to load data directly from the CSV file into the full_dataset table.
```sql
BULK INSERT Online_Retail.dbo.full_dataset
FROM 'C:\Users\Charl\Desktop\Online_Retail\Online Retail.csv'
WITH (
    FIELDTERMINATOR = ',',     
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2              
);
```
**Initial cleaning and data type conversion**
Incorrect entries are removed after being identified: rows where quantity cannot be converted to INT are removed. Then quantity, unit price and date columns are converted to appropriate formats.
```sql
DELETE FROM Online_Retail.dbo.full_dataset
WHERE TRY_CAST(Quantity AS INT) IS NULL;

ALTER TABLE Online_Retail.dbo.full_dataset
ALTER COLUMN Quantity INT;

ALTER TABLE Online_Retail.dbo.full_dataset
ALTER COLUMN UnitPrice FLOAT;

UPDATE Online_Retail.dbo.full_dataset
SET InvoiceDate = CONVERT(DATE, InvoiceDate, 103); 
```
**Data Normalisation.**
The initial dataset is normalised into five tables which are linked by primary and foreign keys, to ensure efficient storage and data integrity. 

Five tables are created with columns and data types specified, as well as keys and identities:
```sql
-- Create Countries Table
CREATE TABLE Countries (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName VARCHAR(50)
);

-- Create Customers Table
CREATE TABLE Customers (
    NewCustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(25),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    StockCode VARCHAR(25),
    Description VARCHAR(100) 
);

-- Create Invoices Table
CREATE TABLE Invoices (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceNo VARCHAR(25),
    InvoiceDate DATE,
    NewCustomerID INT, 
    FOREIGN KEY (NewCustomerID) REFERENCES Customers(NewCustomerID)
);


-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Quantity INT, 
    UnitPrice FLOAT,
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```
**Table Population**
Once the five tables are created and linked by keys, data from the full_dataset is inserted into the relevant tables based on column names.:
```sql
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
```
## SQL Analysis
Now that the normalised schema has been established, the data is ready to be queried. Various SQL techniques are utilised to retrieve the required data.

The first three queries are basic, using joins, groups and ordering to quickly identify key information. 

- **Finding total revenue by country in descending order:**
```sql
SELECT c.CountryName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Countries c
JOIN Customers cu ON c.CountryID = cu.CountryID
JOIN Invoices i ON cu.NewCustomerID = i.NewCustomerID
JOIN OrderDetails od ON i.InvoiceID = od.InvoiceID
GROUP BY c.CountryName
ORDER BY TotalRevenue DESC;
```
- **Top 10 products by quantity sold**
```
SELECT TOP 10 p.Description AS Product, SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.Description
ORDER BY TotalQuantity DESC;
```
- **Total monthly revenue in date order:**
```sql
SELECT YEAR(i.InvoiceDate) AS Year, MONTH(i.InvoiceDate) AS Month, SUM(od.Quantity * od.UnitPrice) AS MonthlyRevenue
FROM Invoices i
JOIN OrderDetails od ON i.InvoiceID = od.InvoiceID
GROUP BY YEAR(i.InvoiceDate), MONTH(i.InvoiceDate)
ORDER BY Year, Month;
```
-