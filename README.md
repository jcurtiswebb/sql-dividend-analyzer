# sql-dividend-analyzer
Use pystock parsed financial data to calculate dividend growth rates and compare stocks

<b>Requirements</b>

-SQL Server 2016 (SQL Server 2014 can also be used if the code to drop temporary tables is changed)

<b>Installation</b>

-Download all financial data from http://data.pystock.com/

-Unzip all financial data and store in main directory of C: drive in 'pystock-data-gh-pages'

-Place SQLFinance & clrStockCrawler folders somewhere within the C: drive

-Open the file 00_Main_Initalization.sql; copy the path of where the SQLFinance folder is, and replace the path in this .sql file

-Execute the .sql file

<b>Current features include:</b>

-Dividend growth column within reports updated for quarterly and annual financial reports

-Updated of Beta value based on the capital asset pricing model

-Update of valuation column for Fiscal Year financial reports. valuation based on the gordon growth model for dividend investing.


