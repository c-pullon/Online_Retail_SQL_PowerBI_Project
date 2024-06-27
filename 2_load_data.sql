BULK INSERT Online_Retail.dbo.full_dataset
FROM 'C:\Users\Charl\Desktop\Online_Retail\Online Retail.csv'
WITH (
    FIELDTERMINATOR = ',',     
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2              
);

