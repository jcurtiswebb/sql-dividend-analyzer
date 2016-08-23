USE SQLFinance;
GO

IF OBJECT_ID(N'tempdb..#tPrice') IS NOT NULL DROP TABLE #tPrice;
GO

CREATE TABLE #tPrice
(
 [Date] varchar(20) NULL,
 [Open] varchar(20) NULL,
 [High] varchar(20) NULL,
 [Low] varchar(20) NULL,
 [Close] varchar(20) NULL,
 [Volume] varchar(20) NULL,
 [Adj Close] varchar(20) NULL
)
BULK INSERT #tPrice
FROM 'C:\sql-stock-crawler\data.csv'
WITH
(
	FIRSTROW = 2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='0x0a'
)
GO

INSERT INTO stg.Price 
(pricedate,openprice,highprice,lowprice,closeprice,volume,adjclose)
SELECT [Date],[Open],[High],[Low],[Close],[Volume],[Adj Close]
FROM #tPrice;
GO

IF OBJECT_ID(N'tempdb..#tPrice') IS NOT NULL DROP TABLE #tPrice;
GO

UPDATE SQLFinance.stg.Price
set symbol='SPY'
WHERE symbol IS NULL;
GO

