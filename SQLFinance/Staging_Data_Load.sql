USE SQLFinance;
GO

EXEC dbo.usp_InsertStagingData
	@type = 'report',
	@loadinitial = 1,
	@startdate = '03-23-2009',
	@enddate = '07-23-2016';
GO

EXEC dbo.usp_InsertStagingData
	@type = 'price',
	@loadinitial = 1,
	@startdate = '03-23-2009',
	@enddate = '07-24-2016';
GO




