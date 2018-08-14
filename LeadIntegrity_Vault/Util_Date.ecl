﻿Import ut, std;

export Util_Date := module;

		datepattern	:= '(^[[:digit:]]{8}$)|(^[[:space:]]{8}$)|(^0$)|(^$)|(^[0]{8}$)';
		
		export IsAllDigits(STRING8 InDate) := if(regexfind(datepattern,trim(InDate, left, right)), TRUE, FALSE);

		export getFileBuildDateFromCurrentDate() := FUNCTION

				InDate := (STRING8)Std.Date.Today();
				
				inStrYear	:= InDate[1..4];
				intYear 	:= (Integer)InDate[1..4];
				// prevYear  := (String)(intYear-1);
				
				buildDate := MAP (InDate [5..6] = '01' => inStrYear+'0115',
													(Std.Date.IsLeapYear(intYear) and  InDate [5..6] = '02') => inStrYear+'0215',
													(~Std.Date.IsLeapYear(intYear) and  InDate [5..6] = '02') => inStrYear+'0215',
													InDate [5..6] = '03' => inStrYear+'0315',
													InDate [5..6] = '04' => inStrYear+'0415',
													InDate [5..6] = '05' => inStrYear+'0515',
													InDate [5..6] = '06' => inStrYear+'0615',
													InDate [5..6] = '07' => inStrYear+'0715',
													InDate [5..6] = '08' => inStrYear+'0815',
													InDate [5..6] = '09' => inStrYear+'0915',
													InDate [5..6] = '10' => inStrYear+'1015',
													InDate [5..6] = '11' => inStrYear+'1115',
													InDate [5..6] = '12' => inStrYear+'1215',																	
													''); 
				Return buildDate;
		
		END;

		//requires Date in YYYYMMDD format
		export ValidDate (STRING8 InDate) := FUNCTION
	
				in_Year 					    := (INTEGER) InDate [1..4];
				l_range   		        := (INTEGER) 1000;
				
				BOOLEAN isValidYear 	:= IF (in_Year >= l_range, TRUE, FALSE);
				BOOLEAN isValidMonth	:= IF (InDate [5..6] between '01' and '12', TRUE, FALSE);
				
				BOOLEAN isValidDay 	:= MAP ((InDate [5..6] = '01') AND (InDate [7..8] between '01' and '31') => TRUE,
														(Std.Date.IsLeapYear(in_Year) and  InDate [5..6] = '02') AND (InDate [7..8] between '01' and '29') => TRUE,
														(~Std.Date.IsLeapYear(in_Year) and  InDate [5..6] = '02') AND (InDate [7..8] between '01' and '28') => TRUE,
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

				IsValidDate := IF(IsAllDigits(InDate),
											 IF((IsValidYear AND IsValidMonth AND IsValidDay), TRUE, FALSE),
											 FALSE); 
											
				RETURN IsValidDate;
		END;

		//requires Date in YYYYMMDD format
		export ValidLIDate (STRING8 InDate) := FUNCTION
	
				in_Year 					    := (INTEGER) InDate [1..4];
				l_range   		        := (INTEGER) 1000;
				
				BOOLEAN isValidYear 	:= IF (in_Year >= l_range, TRUE, FALSE);
				BOOLEAN isValidMonth	:= IF (InDate [5..6] between '01' and '12', TRUE, FALSE);
				
				BOOLEAN isValidDay 	:= MAP ((InDate [5..6] = '01') AND (InDate [7..8] = '15') => TRUE,
														(Std.Date.IsLeapYear(in_Year) and  InDate [5..6] = '02') AND (InDate [7..8] = '15') => TRUE,
														(~Std.Date.IsLeapYear(in_Year) and  InDate [5..6] = '02') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '03') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '04') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '05') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '06') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '07') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '08') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '09') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '10') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '11') AND (InDate [7..8] = '15') => TRUE,
																								(InDate [5..6] = '12') AND (InDate [7..8] = '15') => TRUE,
																								FALSE); 

				IsValidDate := IF(IsAllDigits(InDate),
											 IF((IsValidYear AND IsValidMonth AND IsValidDay), TRUE, FALSE),
											 FALSE); 
											
				RETURN IsValidDate;
		END;		
		
END;