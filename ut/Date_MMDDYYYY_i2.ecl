/**
 * Converts Date from MMDDYYYY to YYYYMMDD 
**/
IMPORT STD; 

EXPORT Date_MMDDYYYY_I2(STRING8 s) := FUNCTION 
 
 RETURN IF( LENGTH(TRIM(S,LEFT,RIGHT)) = 8 , Std.Date.FromStringToDate(s,'%m%d%Y'), (UNSIGNED4) s) ;
 
END;
