--Stock Crawler Get Data
USE SQLFinance;
GO

EXEC dbo.usp_StockCrawler
	@stockTicker ='msft';
GO