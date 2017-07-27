/**
 * Transforms MMDDYY to YYYYMMDD
**/
IMPORT STD; 
EXPORT Date_MMDDYY_I2(STRING6 s) := Std.Date.FromStringToDate(s,'%m%d%y'):DEPRECATED('Use Std.Date.FromStringToDate Instead');