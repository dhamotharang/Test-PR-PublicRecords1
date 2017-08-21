IMPORT STD; 
/**
  * This function returns the current date and time in any format supported by strftime
  * The default format is yyyymmdd
  * If UTC is false, the result will be the local time
  * If UTC is true, the result will be Coordinated Universal Time
  * NOTE: '%T' will display the time as hh:mm:ss
  */
EXPORT STRING Now(VARSTRING fmtout='%Y%m%d', BOOLEAN utc=false) :=  Std.Date.SecondsToString(Std.date.CurrentSeconds(~utc), fmtout)  : DEPRECATED ('Use STD.SecondsToString') ;   
   

