USE SQLFinance;
GO

IF OBJECT_ID(N'dbo.usp_InsertStagingData', N'P') IS NOT NULL
	DROP PROC dbo.usp_InsertStagingData;
GO


CREATE PROC dbo.usp_InsertStagingData
	@type AS varchar(8), --can be price or report
	@loadinitial AS BIT, --there are up to three initial files that need to be loaded to get older data, inputting 1 will load them
	@startdate AS DATE, 
	@enddate AS DATE
AS
BEGIN
	DECLARE @path AS VARCHAR(512), 
		@pathresult AS INT,
		--@tempid AS uniqueidentifier = NEWID(),
		@sql VARCHAR(MAX);
	CREATE TABLE #tempPath (datapath VARCHAR(512))
	IF @loadinitial = 1
		BEGIN
			DECLARE @initial INT = 1
			WHILE @initial <= 3
				BEGIN
					--path is set manually based on installation instructions to download and unzip all py stock crawler data into C:\
					--All potential paths of data will be stored in temporary table
					INSERT INTO #tempPath (datapath) VALUES ('C:\pystock-data-gh-pages\2015\000' + CAST(@initial AS varchar(1)) +'_initial\' + @type + 's.csv');
					SET @initial = @initial + 1;
				END
		END
	DECLARE @loopdate AS DATE
	SET @loopdate = @startdate;
	WHILE @loopdate <= @enddate
		BEGIN
			--All potential paths of data files will be stored in temporary table
			INSERT INTO #tempPath (datapath) 
			VALUES ('C:\pystock-data-gh-pages\' + CONVERT(varchar(4), @loopdate, 112) +'\' + CONVERT(varchar(8), @loopdate, 112) + '\' + @type + 's.csv')
			SET @loopdate = DATEADD(dd, 1, @loopdate)
		END
		--Cursor is defined in order to iterate through all temporary table of all possible datapaths to bulk insert
		DECLARE cursorPath CURSOR
			FOR SELECT datapath FROM #tempPath	
		OPEN cursorPath
		FETCH NEXT FROM cursorPath INTO @path
		WHILE @@FETCH_STATUS = 0
			BEGIN
				--Each file is checked to see if it exists, if exists, continue with bulk insert			
				EXEC master.dbo.xp_fileexist @path, @pathresult OUTPUT
				IF @pathresult = 1 
					BEGIN
						PRINT @path + ' exists'
						SET @sql = 'BULK INSERT SQLFinance.stg. ' + @type + ' FROM ''' 
						+ @path + ''' 
						WITH
						(
							FIRSTROW = 2,
							FIELDTERMINATOR='',''
						)'
						EXEC(@sql)						
					END
				FETCH NEXT FROM cursorPath into @path
			END
			CLOSE cursorPath
			DEALLOCATE cursorPath
	DROP TABLE #tempPath;
END;






