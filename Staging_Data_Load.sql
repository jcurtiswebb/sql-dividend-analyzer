EXEC stg.StagingData
	@type = 'report',
	@loadinitial = 1,
	@startdate = '03-23-2015',
	@enddate = '01-23-2016';
GO

EXEC stg.StagingData
	@type = 'price',
	@loadinitial = 0,
	@startdate = '03-23-2015',
	@enddate = '07-24-2015';
GO

