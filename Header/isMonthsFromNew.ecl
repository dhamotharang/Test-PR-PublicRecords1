integer8 monthsever(string6 strdate) :=
	((integer)(strdate[1..4])) * 12 + 
	((integer)(strdate[5..6]));

df := monthsever(sourcedata_month);

export isMonthsFromNew(integer4 datein, integer1 months) := 
	(df - monthsever((string6)datein)) < months and 
	(df - monthsever((string6)datein)) >= 0;