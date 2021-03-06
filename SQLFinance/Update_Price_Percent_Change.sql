WITH T1 AS
(
SELECT 
	symbol,
	pricedate,
	closeprice,
	LAG(closeprice) OVER(PARTITION BY symbol ORDER BY pricedate) AS prevclose
FROM SQLFinance.prd.Price	
)
UPDATE T2
SET T2.daygain = 
	CASE WHEN ((T1.closeprice/T1.prevclose) - 1) < 10000
		THEN ((T1.closeprice/T1.prevclose) - 1)
		ELSE 0
	END
FROM SQLFinance.prd.Price AS T2
INNER JOIN T1
ON T1.symbol = T2.symbol
	AND T1.pricedate = T2.pricedate
WHERE T1.prevclose > 0       


                                                                                                                                                                                                                                                                                                                                                                                      