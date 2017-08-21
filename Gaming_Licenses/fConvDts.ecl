EXPORT fConvDts(STRING pDate) := FUNCTION

INTEGER yr_start_pos := LENGTH(pDate)-1;
INTEGER yr_end_pos := LENGTH(pDate);


Format_yr(STRING pYr) := IF(pYr[1..1] = '0','20','19') + pYr;
			

INTEGER mm_start_pos := 1;
INTEGER mm_end_pos := stringlib.stringfind(pDate, '-', 1) - 1;  

INTEGER dd_start_pos := mm_end_pos + 2; //including dash
INTEGER dd_end_pos := stringlib.stringfind(pDate, '-', 2) - 1; 


STRING Format_mm_or_dd(STRING pDt,
                       INTEGER pStart_Pos,
			           INTEGER pEnd_Pos) := IF(LENGTH(pDt[pStart_Pos..pEnd_Pos]) = 1,
				                               '0' + pDt[pStart_Pos..pEnd_Pos],
								  		       pDt[pStart_Pos..pEnd_Pos]);

RETURN (INTEGER) (Format_yr(pDate[yr_start_pos..yr_end_pos]) + 
                  Format_mm_or_dd(pDate,mm_start_pos,mm_end_pos) +
                  Format_mm_or_dd(pDate,dd_start_pos,dd_end_pos));
END;