USE SQLFinance;
GO

EXEC dbo.usp_InsertStagingData
	@type = 'report',
	@loadinitial = 1,
	@startdate = '03-23-2015',
	@enddate = '01-23-2016';
GO

EXEC dbo.usp_InsertStagingData
	@type = 'price',
	@loadinitial = 1,
	@startdate = '03-23-2015',
	@enddate = '07-24-2016';
GO

/*
TRUNCATE TABLE stg.Report;
GO
TRUNCATE TABLE stg.Price;
GO
ALTER DATABASE SQLFinance SET RECOVERY SIMPLE
DBCC SHRINKFILE('SQLFinance_log', 0, TRUNCATEONLY);
GO
DBCC DROPCLEANBUFFERS;
GO
ALTER DATABASE SQLFinance SET RECOVERY FULL;
GO
*/


