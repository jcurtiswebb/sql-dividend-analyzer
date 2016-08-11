WITH T1 AS
(
	SELECT N1.symbol
	, N1.period_focus
	, N1.fiscal_year As Current_Year
	, N2.fiscal_year As Prior_Year
	, N1.dividend AS Current_Dividend
	, N2.dividend AS Prior_Dividend
	FROM SQLFinance.prd.Report AS N1
	INNER JOIN SQLFinance.prd.Report AS N2 ON
		YEAR(N1.end_date) = (YEAR(N2.end_date)+1)
		AND N1.symbol = N2.symbol
	WHERE N1.period_focus ='FY' AND N2.period_focus='FY' and N1.dividend > 0 AND N2.dividend > 0
)
UPDATE T2
SET T2.div_growth = ((T1.Current_Dividend/T1.Prior_dividend) - 1)
FROM SQLFinance.prd.Report AS T2
INNER JOIN T1
ON T1.Current_Year = T2.fiscal_year 
	AND T1.symbol = T2.symbol 
	AND T1.period_focus = T2.period_focus;

--Update dividend growth by quarter

WITH T1 AS
(
	SELECT N1.symbol
	, N1.period_focus
	, N1.fiscal_year As Current_Year
	, N2.fiscal_year As Prior_Year
	, N1.dividend AS Current_Dividend
	, N2.dividend AS Prior_Dividend
	FROM SQLFinance.prd.Report AS N1
	INNER JOIN SQLFinance.prd.Report AS N2 ON
		YEAR(N1.end_date) = (YEAR(N2.end_date)+1)
		AND N1.symbol = N2.symbol
		AND N1.period_focus = N2.period_focus
	WHERE N1.period_focus <>'FY' and N1.dividend > 0 AND N2.dividend > 0
) 
UPDATE T2
SET T2.div_growth = ((T1.Current_Dividend/T1.Prior_dividend) - 1)
FROM SQLFinance.prd.Report AS T2
INNER JOIN T1
ON T1.Current_Year = T2.fiscal_year 
	AND T1.symbol = T2.symbol 
	AND T1.period_focus = T2.period_focus