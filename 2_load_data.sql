BULK INSERT Online_Retail.dbo.full_dataset
FROM 'C:\Users\Charl\Desktop\online+retail\Online Retail.csv'
WITH (
    FIELDTERMINATOR = ',',     -- Field terminator is comma
    ROWTERMINATOR = '\n',      -- Row terminator is newline
    FIRSTROW = 2,              -- Skip header row
    ERRORFILE = 'C:\Users\Charl\Desktop\online+retail\Online_Retail_Errors.log', -- Log errors
    TABLOCK                  -- Use TABLOCK for performance
);

