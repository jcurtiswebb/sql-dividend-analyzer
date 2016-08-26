IF OBJECT_ID(N'dbo.usp_StockCrawler', N'PC') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_StockCrawler];
GO

CREATE PROC dbo.usp_StockCrawler(
@stockTicker nvarchar(max), 
@startDate nvarchar(10),
@endDate nvarchar(10))
AS
-- assembly name.class name.method
EXTERNAL NAME clrAssemblyStockCrawler.clrFunctions.uspDownloadData;
GO