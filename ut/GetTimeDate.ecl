IMPORT STD; 
/**
 * Returns the current time and date in string format
 **/
EXPORT GetTimeDate() := Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u') : DEPRECATED('Use STD.Date.SecondsToString'); 
