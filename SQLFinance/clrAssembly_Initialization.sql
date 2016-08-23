USE SQLFinance;
GO

CREATE TABLE #fileSystem (dir VARCHAR(512))
INSERT INTO #fileSystem
EXECUTE master.dbo.xp_cmdshell 'dir "C:\" /s/b'

DECLARE @dllPath nvarchar(512) = 
	(SELECT TOP 1 dir FROM #fileSystem WHERE dir LIKE '%SQLFinance\clrStockCrawler.dll')
EXEC('CREATE ASSEMBLY clrAssemblyStockCrawler 
	FROM  ''' + @dllPath + '''
	WITH PERMISSION_SET = EXTERNAL_ACCESS');
GO


DROP TABLE #fileSystem;
GO


