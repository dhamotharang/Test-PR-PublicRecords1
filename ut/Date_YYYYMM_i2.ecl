/**
 * Calculates the number of whole months between since 1900.
 **/
IMPORT STD; 

EXPORT Date_YYYYMM_i2(STRING6 dte) := FUNCTION 
   
   tdte := TRIM(dte,LEFT,RIGHT);
   ldte := (UNSIGNED4)IF(LENGTH(tdte)=4 , tdte+'0000', tdte+'00'); 
	 RETURN IF(dte='',0, Std.Date.MonthsBetween(19000000,ldte));
	 
END; 