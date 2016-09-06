--Need all stocks that beat the S&P each year, which also paid a dividend.
--Should I come up with a yearly gain metric?
--Instead of running total. use two days for each: start of year & end of year
--How can reverse splits be dealt with?
USE SQLFinance;
GO

DROP TABLE IF EXISTS #TempMinDate;
GO
DROP TABLE IF EXISTS #TempMaxDate;
GO
DROP TABLE IF EXISTS #TempMinDatePrice;
GO
DROP TABLE IF EXISTS #TempMaxDatePrice;
GO


SELECT DISTINCT P1.symbol, (SELECT MIN(P2.pricedate) FROM SQLFinance.prd.Price AS P2 
						WHERE P2.symbol = P1.symbol
						AND P2.pricedate < DATEADD(Year, YEAR(P1.Pricedate)-1899, DATEADD(month, 0, DATEADD(day, 0, 0)))
						AND P2.pricedate > DATEADD(Year, YEAR(P1.Pricedate)-1901, DATEADD(month, 0, DATEADD(day, 0, 0)))
						) AS pricedate
INTO #TempMinDate
FROM SQLFinance.prd.Price AS P1

SELECT DISTINCT P1.symbol, (SELECT MAX(P2.pricedate) FROM SQLFinance.prd.Price AS P2 
						WHERE P2.symbol = P1.symbol
						AND P2.pricedate < DATEADD(Year, YEAR(P1.Pricedate)-1899, DATEADD(month, 0, DATEADD(day, 0, 0)))
						AND P2.pricedate > DATEADD(Year, YEAR(P1.Pricedate)-1901, DATEADD(month, 0, DATEADD(day, 0, 0)))
						) AS pricedate
INTO #TempMaxDate
FROM SQLFinance.prd.Price AS P1;
GO


--First Create temporary table with each symbol and it's yearly performance
SELECT N1.symbol, N1.pricedate, N2.closeprice, YEAR(N1.pricedate) AS FY
INTO #TempMinDatePrice
FROM #TempMinDate AS N1
INNER JOIN SQLFinance.prd.Price AS N2
ON N2.symbol = N1.symbol
AND N2.pricedate = N1.pricedate;
GO

SELECT N1.symbol, N1.pricedate, N2.closeprice, YEAR(N1.pricedate) AS FY
INTO #TempMaxDatePrice
FROM #TempMaxDate AS N1
INNER JOIN SQLFinance.prd.Price AS N2
ON N2.symbol = N1.symbol
AND N2.pricedate = N1.pricedate;
GO



WITH yearAggregate AS
(
SELECT N1.symbol, N1.closeprice/N2.closeprice - 1 AS gain, N1.FY
FROM #TempMaxDatePrice N1
INNER JOIN #TempMinDatePrice AS N2
	ON N1.symbol = N2.symbol
	AND N1.FY = N2.FY
WHERE N2.closeprice > 0
)
SELECT T1.symbol, T1.fy TradingYear, T1.gain Symbolgain, T2.gain AS Indexgain
FROM yearAggregate AS T1
	INNER JOIN yearAggregate AS T2
		ON T1.fy = T2.fy
		AND T2.symbol = 'SPY'
WHERE T1.gain > T2.gain
 

