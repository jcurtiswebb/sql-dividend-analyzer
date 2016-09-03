--Stock Crawler Get Data
USE SQLFinance;
GO

EXEC dbo.usp_StockCrawler
	@stockTicker ='msft',
	@startDate ='00-01-2009',
	@endDate = '07-21-2016';
GO