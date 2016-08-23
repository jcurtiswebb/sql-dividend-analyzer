IF OBJECT_ID(N'dbo.usp_StockCrawler', N'PC') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_StockCrawler];
GO

CREATE PROC dbo.usp_StockCrawler
AS
-- assembly name.class name.method
EXTERNAL NAME clrAssemblyStockCrawler.clrFunctions.uspDownloadData;
GO