IMPORT STD;

EXPORT mod_Utilities := MODULE   
   
  EXPORT strCurrentDate := (STRING8)Std.Date.Today();
  EXPORT CurrentDate := Std.Date.Today();
  
  EXPORT CurrentDateTimeStamp := Std.Date.SecondsToString(STD.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S');

END;  

