// This does leave some 'holes' that do not really exist - but that is fine for our purposes
// The numbers are monotonically increasing - and without huge gaps
//export fn_YYYYMMDD_to_Int(UNSIGNED4 yyyymmdd) :=  (UNSIGNED3)((yyyymmdd DIV 10000 * 12 + (yyyymmdd DIV 100) % 100) * 31 + yyyymmdd % 100 - 1);
/*
This function takes a date in ANY of the formats (YYYYMM/YYYYMMDD/YYYYMMDDHHMMSS) and converts it to the reporteddate value (Rangefield value) by day. 
This means that the output will be the SAME for any of 200412 / 20041213 / 2004121301202. In all these cases year,month and day are the same and thats the only thing this 
function cares about. 
*/
EXPORT fn_YYYYMMDD_to_Int(UNSIGNED6 yyyymmdd) := FUNCTION
/*
//At this point (as confirmed from Header.File_Header, dates have strlens of either 6 or 8. Also adding support for strlens of 14 (for yyyymmddhhmmss)
valid := CASE((LENGTH(TRIM((STRING) yyyymmdd))), 6 => yyyymmdd * 100, 14 => yyyymmdd DIV 1000000, yyyymmdd); //Convert data to yyyymmdd
*/
yyyymmdd_part := (UNSIGNED4)((STRING)yyyymmdd)[..8];
len:= LENGTH(TRIM((STRING)yyyymmdd_part));
valid := MAP(//len < 5 => (UNSIGNED4)(yyyymmdd_part * POWER(10 ,8-(LENGTH(TRIM((STRING)yyyymmdd_part))))) +101, // 2002 is treated as 20020101
							len >= 6  AND len < 8 => (UNSIGNED4)(yyyymmdd_part * POWER(10 ,8-(LENGTH(TRIM((STRING)yyyymmdd_part))))) + 1, // 200206 is treated as 20020601
							yyyymmdd_part); // else length is 8 
year :=  valid DIV 10000;
nonleap := year % 4;
month := (valid DIV 100) % 100;
vmonth := IF(month < 1 OR month >12, 6, month);
day := valid % 100;
md := [31,28,31,30,31,30,31,31,30,31,30,31];
cmd := [0,31,59,90,120,151,181,212,243,273,304,334,365];
yday := cmd[vmonth] + IF(day < 1 OR day > 31, 15, MAP(nonleap <> 0 OR vmonth = 1  => IF(cmd[vmonth+1] < cmd[vmonth] + day, 15, day),
						nonleap = 0 AND vmonth > 2 => 1+ IF(cmd[vmonth+1] < cmd[vmonth] + day, 15, day),
						IF(day > 29, 15,day)));
RETURN IF(valid = 0, 0,(year - 1)* 365 + (year - 1) DIV 4 + yday);
END;
