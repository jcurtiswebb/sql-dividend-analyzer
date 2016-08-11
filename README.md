# sql-dividend-analyzer
Use pystock parsed financial data to calculate dividend growth rates and compare stocks

Requirements
-SQL Server 2012 or newer

Installation
-Download all financial data from http://data.pystock.com/
-Unzip all financial data and store in main directory of C: drive in 'pystock-data-gh-pages'
-Using SSMS execute the .sql files in the following order:
  1. Database_Table_Initialization.sql
  2. Staging_Data_Load_Initialization.sql
  3. Staging_Data_Load.sql
  4. Production_Data_Transfer.sql
  5. Update_Report_Dividend_Growth.sql

