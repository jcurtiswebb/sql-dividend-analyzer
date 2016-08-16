/* Stored Procedure for Updating Valuation to all Reports */
CREATE PROC prd.Valuation
	@rateaboveriskfree AS smallmoney,
	@riskfree AS smallmoney
AS
BEGIN
	--If percentages were given instead of decimals, divide percentage by 100
		IF @riskfree > 0
			BEGIN
				SET @riskfree = @riskfree/100
			END
		IF @rateaboveriskfree > 0
			BEGIN
				SET @rateaboveriskfree = @rateaboveriskfree /100
			END
	UPDATE N2
		SET N2.Valuation = ROUND((N1.div_growth+1),3)*ROUND(N1.dividend,3)/((@riskfree + @rateaboveriskfree)*ROUND(N1.Beta,3) - ROUND(N1.div_growth,3))
	FROM SQLFinance.prd.Report AS N2
		INNER JOIN SQLFinance.prd.Report AS N1
			ON N1.symbol = N2.symbol
			AND N1.fiscal_year = N2.fiscal_year
			AND N1.period_focus = n2.period_focus
	WHERE N1.period_focus = 'FY'
		AND ((@riskfree + @rateaboveriskfree)*N1.Beta - N1.div_growth) > 0
END;


