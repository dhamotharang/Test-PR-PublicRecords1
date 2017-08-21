import ut, MDR;

EXPORT ValidDOB (STRING10 InDate, STRING2 SRC = '') := FUNCTION

	fpos := stringlib.stringfind(InDate,'/',1);
	spos := stringlib.stringfind(InDate,'/',2);

	s_month := InDate[1..(stringlib.stringfind(InDate,'/',1) - 1)];
	s_day		:= InDate[fpos + 1 .. spos - 1];
	s_year 	:= InDate[spos + 1 ..];
	
	INTEGER2 i_month	:=	(integer) s_month;
	INTEGER2 i_day		:=	(integer) s_day;
	INTEGER2 i_year	:=	(integer) s_year;	
	
	Current_Year					:= (INTEGER) ut.getDate [1..4];
	l_range 							:= Current_Year - 120;
	lower_range						:= INTFORMAT (l_range,4,1);

	BOOLEAN isValidYear 	:= IF ((INTEGER)i_year >= (INTEGER) lower_range and (INTEGER)i_year <= (INTEGER)ut.getDate [1..4], TRUE, FALSE);
	BOOLEAN isValidMonth	:= IF (i_month between 1 and 12, TRUE, FALSE);
	BOOLEAN isValidDay 		:= MAP ((i_month = 1) AND (i_day between 1 and 31) => TRUE,
													(ut.LeapYear(I_Year) and  i_month = 2) AND (i_day between 1 and 29) => TRUE,
													(~ut.LeapYear(I_Year) and  i_month = 2) AND (i_day between 1 and 28) => TRUE,
																							(i_month = 3) AND (i_day between 1 and 31) => TRUE,
																							(i_month = 4) AND (i_day between 1 and 30) => TRUE,
																							(i_month = 5) AND (i_day between 1 and 31) => TRUE,
																							(i_month = 6) AND (i_day between 1 and 30) => TRUE,
																							(i_month = 7) AND (i_day between 1 and 31) => TRUE,
																							(i_month = 8) AND (i_day between 1 and 31) => TRUE,
																							(i_month = 9) AND (i_day between 1 and 30) => TRUE,
																							(i_month = 10) AND (i_day between 1 and 31) => TRUE,
																							(i_month = 11) AND (i_day between 1 and 30) => TRUE,
																							(i_month = 12) AND (i_day between 1 and 31) => TRUE,
																																														FALSE
	); 
	
	isGTCurrentDate := IF (isValidYear and isValidMonth and isValidDay and (integer) inDate <= (integer) ut.GetDate [1..8], true, false);
	
	isBadDOB				:=	map (SRC = MDR.SourceTools.src_AMS and i_month = 1 and i_month = 1 => TRUE,
													 SRC = MDR.SourceTools.src_Enclarity and i_month = 1 and i_month = 1 => TRUE,
														FALSE);
	
	IsValidDate := IsValidYear AND IsValidMonth AND IsValidDay AND IsGTCurrentDate and ~isBadDOB;
	
	RETURN IsValidDate;
END;