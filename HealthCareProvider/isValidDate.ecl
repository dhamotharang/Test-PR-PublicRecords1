import ut;

EXPORT isValidDate (STRING8 InDate) := FUNCTION
	
	LEN_DATE							:=	LENGTH(TRIM(InDate,LEFT,RIGHT));
	Integer Year 					:= (Integer) InDate [1..4];
	Current_Year					:=	(INTEGER) ut.getDate [1..4];
	l_range 							:=	 1900;
	h_range 							:=	 2100;
	lower_range						:=	INTFORMAT (l_range,4,1);
	high_range						:=	INTFORMAT (h_range,4,1);
	BOOLEAN isValidYear 	:= IF ((INTEGER)InDate [1..4] >= (INTEGER) lower_range and (INTEGER)InDate [1..4] <= (INTEGER)high_range, TRUE, FALSE);
	BOOLEAN isValidMonth	:= IF (InDate [5..6] between '01' and '12', TRUE, FALSE);
	BOOLEAN isValidDay 		:= MAP ((InDate [5..6] = '01') AND (InDate [7..8] between '01' and '31') => TRUE,
													(ut.LeapYear(Year) and  InDate [5..6] = '02') AND (InDate [7..8] between '01' and '29') => TRUE,
													(~ut.LeapYear(Year) and  InDate [5..6] = '02') AND (InDate [7..8] between '01' and '28') => TRUE,
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
	IsValidDate := IsValidYear AND IsValidMonth AND IsValidDay AND LEN_DATE = 8;
	
	RETURN IsValidDate;
END;