
-- Some rows have incorrect data so are removed before trying to convert columns
-- Delete rows where Quantity cannot be converted to INT
DELETE FROM Online_Retail.dbo.full_dataset
WHERE TRY_CAST(Quantity AS INT) IS NULL;

-- Convert columns to appropriate data types
ALTER TABLE Online_Retail.dbo.full_dataset
ALTER COLUMN Quantity INT;

ALTER TABLE Online_Retail.dbo.full_dataset
ALTER COLUMN UnitPrice FLOAT;

-- Convert 'InvoiceDate' column to DATE data type
UPDATE Online_Retail.dbo.full_dataset
SET InvoiceDate = CONVERT(DATE, InvoiceDate, 103); 

-- Alter 'InvoiceDate' column to DATE data type
ALTER TABLE Online_Retail.dbo.full_dataset
ALTER COLUMN InvoiceDate DATE;
