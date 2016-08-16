-- Beta = Covariance(Rate(asset) , Rate(index)) / Variance(index)
-- Use BAM for index until index data is added
WITH T1 AS
(
	SELECT 
		N1.symbol,
		N1.pricedate,
		N2.Fiscal_Year,
		N1.daygain*100 assetgain
		,N5.daygain*100 indexgain
		,(SELECT AVG(N3.daygain*100) FROM SQLFinance.prd.Price AS N3
		 WHERE N3.symbol = N1.symbol
			AND N3.pricedate < DATEADD(YYYY,1,'01-01-' + N2.Fiscal_Year)) AS Avggain,
		(SELECT AVG(N4.daygain*100) FROM SQLFinance.prd.Price AS N4
		 WHERE N4.symbol = 'bam'
			AND N4.pricedate < DATEADD(YYYY,1,'01-01-' + N2.Fiscal_Year)) AS Avgindexgain
	FROM SQLFinance.prd.Price AS N1
		INNER JOIN SQLFinance.prd.Report AS N2
			ON N1.symbol=  N2.symbol
		INNER JOIN SQLFinance.prd.Price AS N5
			ON N1.pricedate = N5.pricedate
	WHERE N2.period_focus = 'FY'
		AND N5.symbol = 'bam'
)
UPDATE T2 
SET T2.beta = T3.beta 
FROM SQLFinance.prd.Report AS T2
	INNER JOIN 
	(SELECT symbol, fiscal_year, SUM((assetgain-avggain)*(indexgain-avgindexgain))/(COUNT(symbol)*VAR(indexgain)) 
	AS beta
	 FROM T1
	 WHERE Avggain IS NOT NULL
		AND Avgindexgain IS NOT NULL
	 GROUP by symbol, fiscal_year) AS T3
		ON T3.symbol = T2.symbol
		AND T3.fiscal_year = T2.fiscal_year
WHERE T2.period_focus ='FY'