/* Create the SQLFinance Database 
	
*/
USE master;
GO
IF DB_ID(N'SQLFinance') IS NOT NULL
	DROP DATABASE SQLFinance;
GO

--Query sys.master_files to discover where the master database is kept. SQLFinance will be created in the same directory
DECLARE @datapath AS nvarchar(500), @databasepath AS nvarchar(500), @logpath AS nvarchar(500)
SET @datapath = (SELECT TOP 1 physical_name FROM sys.master_files WHERE name='master')
SET @databasepath = LEFT(@datapath, (LEN(@datapath) - 10)) + 'SQLFinance.mdf'
SET @logpath = LEFT(@datapath, (LEN(@datapath) - 10)) + 'SQLFinance_log.mdf'
	EXEC('CREATE DATABASE SQLFinance
		ON
		( NAME = SQLFinance,  
			FILENAME =''' +  @databasepath + ''',  
			SIZE = 2048MB,  
			MAXSIZE = 4096MB,  
			FILEGROWTH = 512MB 
		)
		LOG ON  
		( NAME = SQLFinance_log,  
			FILENAME =''' + @logpath + ''',  
			SIZE = 2048MB,  
			MAXSIZE = 4096MB,  
			FILEGROWTH = 512MB )');
	GO

--No database recovery will ever be needed since all data will be acquired from yahoo finance API or py-stock-crawler
ALTER DATABASE SQLFinance
	SET RECOVERY SIMPLE;
GO

--Database trustworthy needs to be on for the CLR stock crawler stored procedure to write to the file system
ALTER DATABASE SQLFinance
	SET TRUSTWORTHY ON;
GO

/* Create 2 Schemas: Staging (stg) and Production (prd)
	Staging will hold all of the tables that new data will be dumped into. 
	Staging table columns must be compatible with production columns via SQL implicit conversion
*/
USE SQLFinance;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'stg')
BEGIN
    EXEC( 'CREATE SCHEMA stg' );
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'prd')
BEGIN
    EXEC( 'CREATE SCHEMA prd' );
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'ref')
BEGIN
    EXEC( 'CREATE SCHEMA ref' );
END

/* Create Staging Report and Price Tables */

IF OBJECT_ID(N'stg.Report', N'U') IS NOT NULL DROP TABLE stg.Report;

CREATE TABLE stg.Report(
	symbol varchar(50) NULL,
	end_date varchar(50) NULL,
	amend varchar(50) NULL,
	period_focus varchar(50) NULL,
	fiscal_year varchar(50) NULL,
	doc_type varchar(50) NULL,
	revenues varchar(50) NULL,
	op_income varchar(50) NULL,
	net_income varchar(50) NULL,
	eps_basic varchar(50) NULL,
	eps_diluted varchar(50) NULL,
	dividend varchar(50) NULL,
	assets varchar(50) NULL,
	cur_assets varchar(50) NULL,
	cur_liab varchar(50) NULL,
	cash varchar(50) NULL,
	equity varchar(50) NULL,
	cash_flow_op varchar(50) NULL,
	cash_flow_inv varchar(50) NULL,
	cash_flow_fin varchar(50) NULL
) 

IF OBJECT_ID(N'stg.Price', N'U') IS NOT NULL DROP TABLE stg.Price;

CREATE TABLE stg.Price
(
	symbol varchar(20) NULL,
	pricedate varchar(20) NULL,
	openprice varchar(20) NULL,
	highprice varchar(20) NULL,
	lowprice varchar(20) NULL,
	closeprice varchar(20) NULL,
	volume varchar(20) NULL,
	adjclose varchar(20) NULL
);
GO


/* Create Production Report and Price Tables */


IF OBJECT_ID(N'prd.Report', N'U') IS NOT NULL DROP TABLE prd.Report;

CREATE TABLE SQLFinance.prd.Report
(
	symbol varchar(20) null,
	end_date date null,	
	amend varchar(5) null,	
	period_focus varchar(2) null,	
	fiscal_year	varchar(20) null,
	doc_type varchar(8) null,	
	revenues money null,	
	op_income money null,	
	net_income	money null,
	eps_basic money null,	
	eps_diluted	money null,
	dividend smallmoney null,
	assets	money null,
	cur_assets money null,	
	cur_liab money null,	
	cash money null,	
	equity	money null,
	cash_flow_op money null,	
	cash_flow_inv money null,	
	cash_flow_fin money null,
	div_growth smallmoney null,
	valuation smallmoney null,
	beta smallmoney null
)

IF OBJECT_ID(N'prd.Price', N'U') IS NOT NULL DROP TABLE prd.Price;

CREATE TABLE SQLFinance.prd.Price(
	symbol varchar(20) NULL,
	pricedate date NULL,
	openprice money NULL,
	highprice money NULL,
	lowprice money NULL,
	closeprice money NULL,
	volume bigint NULL,
	adjclose money NULL,
	daygain decimal(9,5) NULL
)

IF OBJECT_ID(N'ref.Yr', N'U') IS NOT NULL DROP TABLE ref.Yr;

CREATE TABLE SQLFinance.ref.Yr(
	FY char(4) NULL
) 

-- To allow advanced options to be changed.  
EXEC sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- enabling the commandchell feature allows for the file system to be searched in clrAssembly_Initialization.sql 
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO 

