USE SQLFinance;
GO

CREATE CLUSTERED COLUMNSTORE INDEX cci_pprice ON prd.Price;
GO


