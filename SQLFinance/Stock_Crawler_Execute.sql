--Stock Crawler Get Data
USE SQLFinance;
GO

EXEC dbo.usp_StockCrawler
	@stockTicker ='msft',
	@startDate ='01-01-2001',
	@endDate = '01-01-2012';
GO