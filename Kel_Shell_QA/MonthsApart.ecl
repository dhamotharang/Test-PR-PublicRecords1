IMPORT STD; 
/**
 * Calculate the number of months between two dates.
 * This works only with dates in YYYYMM format
**/
EXPORT INTEGER MonthsApart(STRING6 d1 , STRING6 d2) := FUNCTION 

 Adjustd1 := (unsigned)(d1+'01'); 
 Adjustd2 := (unsigned)(d2+'01'); 
 
 RETURN ABS(std.date.MonthsBetween(Adjustd1,Adjustd2)); 

END; 