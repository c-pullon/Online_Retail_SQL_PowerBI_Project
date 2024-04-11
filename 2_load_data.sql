BULK INSERT Online_Retail.dbo.full_dataset
FROM 'C:\Users\Charl\Desktop\online+retail\Online Retail.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- 
);
