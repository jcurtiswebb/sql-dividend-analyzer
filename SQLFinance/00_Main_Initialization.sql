--IMPORTANT: User needs to manually set path to SQLFinance Folder.
--IMPORTANT: SQLCMD needs to be turned on before running
--Potential improvemet: make both path setting dynamic and SQLCMD turning on to be dynamic
--GO values needed because USE 'database' does not function properly with SQLCMD. Therefore each .sql file needs to be run as a batch.
:setvar datapath "C:\Users\Josh\Documents\SQL Server Management Studio\SQL Server Scripts1\SQLFinance\"
:r $(datapath)Database_Table_Initialization.sql
GO
:r $(datapath)Staging_Data_Load_Initialization.sql
GO
:r $(datapath)Valuation_Initialization.sql
GO
:r $(datapath)clrAssembly_Initialization.sql
GO
:r $(datapath)Stock_Crawler_Initialization.sql
GO
:r $(datapath)Stock_Crawler_Execute.sql
GO
:r $(datapath)Crawler_Load_Data.sql
GO
:r $(datapath)Staging_Data_Load.sql
GO
:r $(datapath)Production_Data_Transfer.sql
GO
:r $(datapath)Production_Table_Index_Initialization.sql
GO
:r $(datapath)Update_Price_Percent_Change.sql
GO
:r $(datapath)Update_Report_Dividend_Growth.sql
GO
:r $(datapath)Update_Report_Beta.sql
GO
:r $(datapath)Update_Report_Valuation.sql
GO
:r $(datapath)Tally_Table_Initialization.sql
GO
:r $(datapath)Year_Table_Initialization.sql
GO
:r $(datapath)Outperformers.sql
GO

