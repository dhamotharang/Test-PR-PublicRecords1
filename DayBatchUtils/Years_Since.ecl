import ut;

export Years_Since(STRING startDate,STRING endDate) := FUNCTION
	startYear := startDate[1..4];
	startMonth := IF((UNSIGNED)(startDate[5..6]) != 0,startDate[5..6],'01');
	startDay		:= IF((UNSIGNED)(startDate[7..8]) != 0,startDate[7..8],'01');
	useStartDate := startYear + startMonth + startDay;
	
	endYear := endDate[1..4];
	endMonth := IF((UNSIGNED)(endDate[5..6]) != 0,endDate[5..6],'1');
	endDay		:= IF((UNSIGNED)(endDate[7..8])!= 0,endDate[7..8],'1');
	useEndDate := endYear + endMonth + endDay;
	
	yearsSince := IF(TRIM(startYear) <> '' AND TRIM(endYear) <> '',
										ut.DaysApart(useStartDate,useEndDate) DIV 365,
										-1
										);	
	RETURN yearsSince;
END;