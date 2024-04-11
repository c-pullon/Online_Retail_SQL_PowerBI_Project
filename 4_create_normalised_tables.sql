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
