IMPORT STD ; 
/**
 * Returns the current time and date in string format
 **/
EXPORT getTimeDate() := STD.Date.SecondsToString(STD.Date.CurrentSeconds(TRUE), '%F %H:%M:%S'); 
