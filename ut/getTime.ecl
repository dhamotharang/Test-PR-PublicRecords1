IMPORT STD; 
/**
 * Returns the current time of day in string format
 **/
 
 EXPORT getTime() := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S') : DEPRECATED('Use Std.Date.SecondsToString'); 