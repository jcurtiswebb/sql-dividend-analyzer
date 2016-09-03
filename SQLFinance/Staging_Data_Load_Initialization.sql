USE SQLFinance; 
GO
IF OBJECT_ID(N'dbo.usp_InsertStagingData', N'P') IS NOT NULL
	DROP PROC dbo.usp_InsertStagingData; 
GO

CREATE PROC dbo.usp_InsertStagingData
	@type AS varchar(8), --can be price or report
	@loadinitial AS BIT, --1 will load initial three data files 
	@startdate AS DATE, @enddate AS DATE
AS
BEGIN
	DECLARE @path AS VARCHAR(512), 
		@pathresult AS INT, @sql VARCHAR(MAX);
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
		--Cursor will iterate through path table
		DECLARE cursorPath CURSOR FOR (SELECT datapath FROM #tempPath)	
		OPEN cursorPath
		FETCH NEXT FROM cursorPath INTO @path
		WHILE @@FETCH_STATUS = 0
			BEGIN --If file exists continue with bulk insert				
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






