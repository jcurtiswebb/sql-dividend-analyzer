INSERT INTO SQLFinance.prd.Price([symbol]
      ,[pricedate]
      ,[openprice]
      ,[highprice]
      ,[lowprice]
      ,[closeprice]
      ,[volume]
      ,[adjclose])
SELECT TRY_CONVERT(varchar(20),[symbol])
      ,TRY_PARSE([pricedate] AS date)
      ,TRY_CONVERT(money, [openprice])
      ,TRY_CONVERT(money, [highprice])
      ,TRY_CONVERT(money, [lowprice])
      ,TRY_CONVERT(money, [closeprice])
      ,TRY_CONVERT(int, [volume])
      ,TRY_CONVERT(money, [adjclose])
FROM SQLFinance.stg.Price 

INSERT INTO SQLFinance.prd.Report(
	[symbol]
      ,[end_date]
      ,[amend]
      ,[period_focus]
      ,[fiscal_year]
      ,[doc_type]
      ,[revenues]
      ,[op_income]
      ,[net_income]
      ,[eps_basic]
      ,[eps_diluted]
      ,[dividend]
      ,[assets]
      ,[cur_assets]
      ,[cur_liab]
      ,[cash]
      ,[equity]
      ,[cash_flow_op]
      ,[cash_flow_inv]
      ,[cash_flow_fin])
SELECT TRY_CONVERT(varchar(20),[symbol])
      ,TRY_PARSE([end_date] AS date)
      ,TRY_CONVERT(varchar(5), [amend])
      ,TRY_CONVERT(varchar(2),[period_focus])
      ,TRY_CONVERT(varchar(20),[fiscal_year])
      ,TRY_CONVERT(varchar(8),[doc_type])
      ,TRY_CONVERT(money, [revenues])
      ,TRY_CONVERT(money, [op_income])
      ,TRY_CONVERT(money, [net_income])
      ,TRY_CONVERT(money, [eps_basic])
      ,TRY_CONVERT(money, [eps_diluted])
      ,TRY_CONVERT(smallmoney, [dividend])
      ,TRY_CONVERT(money, [assets])
      ,TRY_CONVERT(money, [cur_assets])
      ,TRY_CONVERT(money, [cur_liab])
      ,TRY_CONVERT(money, [cash])
      ,TRY_CONVERT(money, [equity])
      ,TRY_CONVERT(money, [cash_flow_op])
      ,TRY_CONVERT(money, [cash_flow_inv])
      ,TRY_CONVERT(money, [cash_flow_fin])
  FROM SQLFinance.stg.Report