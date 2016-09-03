--Stock Crawler Get Data
--Month must be inputted as 00-11 for Jan-Dec
USE SQLFinance;
GO

EXEC dbo.usp_StockCrawler
	@stockTicker ='msft',
	@startDate ='01-01-2001',
	@endDate = '01-01-2012';
GO
