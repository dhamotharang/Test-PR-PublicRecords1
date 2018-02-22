import std;

INTEGER2 dayofyr(integer1 month,integer1 day) := 
CHOOSE( month,0,31,59,90,120,151,181,212,243,273,304,334 ) + day;

export INTEGER2 DayOfYear(integer4 year,integer1 month,integer1 day) := 
dayofyr(month,day) + IF( Std.Date.IsLeapYear(year) and month > 2, 1, 0);