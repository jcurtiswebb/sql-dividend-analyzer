USE SQLFinance;
GO

IF OBJECT_ID(N'dbo.usp_InsertStagingData', N'P') IS NOT NULL
	DROP PROC dbo.usp_InsertStagingData;
GO

CREATE PROC dbo.usp_InsertStagingData
	@type AS varchar(8),
	@loadinitial AS BIT,
	@startdate AS DATE,
	@enddate AS DATE
AS
BEGIN
	DECLARE @path AS VARCHAR(500),
		@pathresult AS INT,
		@sql VARCHAR(MAX);
	IF @loadinitial = 1
		BEGIN
			DECLARE @initial AS INT;
			SET @initial = 1
			WHILE @initial <= 3
				BEGIN
					SET @path = 'C:\pystock-data-gh-pages\2015\000' + CAST(@initial AS varchar(1)) +'_initial\' + @type + 's.csv'
					/* check if file exists before loading data*/
					PRINT @path
					EXEC master.dbo.xp_fileexist @path, @pathresult OUTPUT
					IF @pathresult = 1 
						BEGIN
							PRINT 'Exists'
							SET @sql = 'BULK INSERT SQLFinance.stg.' + @type + ' FROM ''' 
							+ @path + ''' 
							WITH
							(
								FIRSTROW = 2,
								FIELDTERMINATOR='',''
							)'
							EXEC(@sql)
						END
					SET @initial = @initial + 1;
				END
		END
	DECLARE @loopdate AS DATE
	SET @loopdate = @startdate;
	WHILE @loopdate <= @enddate
		BEGIN
			SET @path = 'C:\pystock-data-gh-pages\' 
				+ CONVERT(varchar(4), @loopdate, 112) +'\' + CONVERT(varchar(8), @loopdate, 112) + '\' + @type + 's.csv'
			PRINT @path 
			/* check if file exists */
			EXEC master.dbo.xp_fileexist @path, @pathresult OUTPUT
			IF @pathresult = 1 
				BEGIN
					PRINT 'exists'
					SET @sql = 'BULK INSERT SQLFinance.stg. ' + @type + ' FROM ''' 
					+ @path + ''' 
					WITH
					(
						FIRSTROW = 2,
						FIELDTERMINATOR='',''
					)'
					EXEC(@sql)
				END
			/* BULK INSERT file */
			/* Incriment the current date by 1 */
			SET @loopdate = DATEADD(dd, 1, @loopdate)
		END
END;




