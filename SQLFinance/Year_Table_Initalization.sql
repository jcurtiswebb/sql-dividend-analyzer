INSERT INTO SQLFinance.ref.Yr 
SELECT TRY_CAST(N AS varchar(4))
FROM SQLFinance.ref.Tally
WHERE N > 1999
	AND N < (YEAR(GETDATE()) + 1) 


