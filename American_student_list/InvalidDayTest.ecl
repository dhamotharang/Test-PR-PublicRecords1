import ut;

EXPORT InvalidDayTest(STRING8 InDate) := FUNCTION
	
	in_Year 					    := (INTEGER) InDate [1..4];
	Current_Year					:= (INTEGER) ut.getDate [1..4];
	l_range   		        := (INTEGER) 1900;
	h_range               := Current_Year + 13;
	BOOLEAN isValidYear 	:= IF (in_Year >= l_range and in_Year <= h_range, TRUE, FALSE);
	BOOLEAN isValidMonth	:= IF (InDate [5..6] between '01' and '12', TRUE, FALSE);
	BOOLEAN isValidDay 		:= MAP ((InDate [5..6] = '01') AND (InDate [7..8] between '01' and '31') => TRUE,
													(ut.LeapYear(in_Year) and  InDate [5..6] = '02') AND (InDate [7..8] between '01' and '29') => TRUE,
													(~ut.LeapYear(in_Year) and  InDate [5..6] = '02') AND (InDate [7..8] between '01' and '28') => TRUE,
																							(InDate [5..6] = '03') AND (InDate [7..8] between '01' and '31') => TRUE,
																							(InDate [5..6] = '04') AND (InDate [7..8] between '01' and '30') => TRUE,
																							(InDate [5..6] = '05') AND (InDate [7..8] between '01' and '31') => TRUE,
																							(InDate [5..6] = '06') AND (InDate [7..8] between '01' and '30') => TRUE,
																							(InDate [5..6] = '07') AND (InDate [7..8] between '01' and '31') => TRUE,
																							(InDate [5..6] = '08') AND (InDate [7..8] between '01' and '31') => TRUE,
																							(InDate [5..6] = '09') AND (InDate [7..8] between '01' and '30') => TRUE,
																							(InDate [5..6] = '10') AND (InDate [7..8] between '01' and '31') => TRUE,
																							(InDate [5..6] = '11') AND (InDate [7..8] between '01' and '30') => TRUE,
																							(InDate [5..6] = '12') AND (InDate [7..8] between '01' and '31') => TRUE,
																																																									FALSE
	); 
	
			result:= MAP(isValidYear AND isValidMonth AND isValidDay => InDate,
										isValidYear AND isValidMonth AND ~isValidDay => InDate[1..6]+(string)ut.Month_Days((unsigned) InDate[1..6]),
										isValidYear AND ~isValidMonth AND isValidDay =>	InDate[1..4]+'1231',
										isValidYear AND ~isValidMonth AND ~isValidDay => InDate[1..4]+'1231',
										'');
	// result:=if(isValidYear AND isValidMonth AND ~isValidDay, if(isValidYear AND ~isValidMonth AND ~isValidDay, if(InDate[1..4]+'1231'),InDate[1..6]+(string)ut.Month_Days((unsigned) InDate[1..6])),if(isValidYear AND ~isValidMonth AND isValidDay,Indate[1..4]+'12'+Indate[7..8],InDate));
	// result:=if(isValidYear AND ~isValidMonth AND ~isValidDay, InDate[1..4]+'1231',InDate);

	RETURN result;
END;