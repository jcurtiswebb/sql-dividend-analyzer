--Need all stocks that beat the S&P each year, which also paid a dividend.
--Should I come up with a yearly gain metric?
--Instead of running total. use two days for each: start of year & end of year
--How can reverse splits be dealt with?
USE SQLFinance;
GO

DECLARE @index AS varchar(8) = 'SPY'

--First Create temporary table with each symbol and it's yearly performance
WITH yearAggregate AS
(
SELECT symbol, YEAR(pricedate), 
FROM prd.Price AS N1
GROUP BY symbol, YEAR(pricedate)
)

--How do I find the starting and ending dates for each year:
--Option 1: find the max and min dates for each YEAR(pricedate) grouping for each symbol
--Option 2: find the max and min dates for each YEAR() based on some sample and then apply those dates to each symbol
(SELECT ((N2.closeprice / N2.openprice) - 1) FROM prd.Price AS N2 WHERE )