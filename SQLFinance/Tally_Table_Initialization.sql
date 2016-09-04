USE SQLFinance;
GO

SELECT TOP (32768) 
ROW_NUMBER() OVER (ORDER BY sc1.id) AS N
INTO ref.Tally
FROM master.dbo.syscolumns sc1, master.dbo.syscolumns sc2;
GO

ALTER TABLE ref.Tally
	ALTER COLUMN N INT NOT NULL
GO

ALTER TABLE ref.Tally
	ADD CONSTRAINT pk_Tally_N
		PRIMARY KEY CLUSTERED (N) WITH FILLFACTOR=100;
GO