/**
 * Transforms MMDDYY to YYYYMMDD
**/
IMPORT STD; 
EXPORT Date_MMDDYY_I2_V2 (string6 s) := Std.Date.FromStringToDate(s,'%m%d%y'):DEPRECATED('Use Std.Date.FromStringToDate Instead');
