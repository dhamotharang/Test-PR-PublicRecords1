import ut, MDR;

EXPORT ValidDOB (STRING10 InDate, STRING2 SRC = '') := FUNCTION
	
	Integer Year 					:= (Integer) InDate [7..10];
	Current_Year					:= (INTEGER) ut.getDate [1..4];
	l_range 							:= Current_Year - 120;
	lower_range						:= INTFORMAT (l_range,4,1);
	BOOLEAN isValidYear 	:= IF ((INTEGER)InDate [7..10] >= (INTEGER) lower_range and (INTEGER)InDate [7..10] <= (INTEGER)ut.getDate [1..4], TRUE, FALSE);
	BOOLEAN isValidMonth	:= IF (InDate [1..2] between '01' and '12', TRUE, FALSE);
	BOOLEAN isValidDay 		:= MAP ((InDate [1..2] = '01') AND (InDate [4..5] between '01' and '31') => TRUE,
													(ut.LeapYear(Year) and  InDate [1..2] = '02') AND (InDate [4..5] between '01' and '29') => TRUE,
													(~ut.LeapYear(Year) and  InDate [1..2] = '02') AND (InDate [4..5] between '01' and '28') => TRUE,
																							(InDate [1..2] = '03') AND (InDate [4..5] between '01' and '31') => TRUE,
																							(InDate [1..2] = '04') AND (InDate [4..5] between '01' and '30') => TRUE,
																							(InDate [1..2] = '05') AND (InDate [4..5] between '01' and '31') => TRUE,
																							(InDate [1..2] = '06') AND (InDate [4..5] between '01' and '30') => TRUE,
																							(InDate [1..2] = '07') AND (InDate [4..5] between '01' and '31') => TRUE,
																							(InDate [1..2] = '08') AND (InDate [4..5] between '01' and '31') => TRUE,
																							(InDate [1..2] = '09') AND (InDate [4..5] between '01' and '30') => TRUE,
																							(InDate [1..2] = '10') AND (InDate [4..5] between '01' and '31') => TRUE,
																							(InDate [1..2] = '11') AND (InDate [4..5] between '01' and '30') => TRUE,
																							(InDate [1..2] = '12') AND (InDate [4..5] between '01' and '31') => TRUE,
																																																									FALSE
	); 
	
	isGTCurrentDate := IF (isValidYear and isValidMonth and isValidDay and (integer) inDate <= (integer) ut.GetDate [1..8], true, false);
	
	isAMSDOB	:=	IF (SRC = MDR.SourceTools.src_AMS and InDate [1..2] = '01' and InDate [4..5] = '01',TRUE,FALSE);
	
	IsValidDate := IsValidYear AND IsValidMonth AND IsValidDay AND IsGTCurrentDate and ~isAMSDob;
	
	RETURN IsValidDate;
END;