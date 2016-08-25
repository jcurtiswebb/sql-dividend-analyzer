--Need to manually set path to SQLFinance Folder.
--SQLCMD needs to be turned on
-- Can this be done dynamically?
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
:r $(datapath)Production_Data_Transfer.sql
:r $(datapath)Update_Price_Percent_Change.sql
:r $(datapath)Update_Report_Dividend_Growth.sql
:r $(datapath)Update_Report_Beta.sql
:r $(datapath)Update_Report_Valuation.sql
:r $(datapath)Stock_Crawler_Execute.sql

