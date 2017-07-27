// This does leave some 'holes' that do not really exist - but that is fine for our purposes
// The numbers are monotonically increasing - and without huge gaps
//export fn_YYYYMMDD_to_Int(UNSIGNED4 yyyymmdd) :=  (UNSIGNED3)((yyyymmdd DIV 10000 * 12 + (yyyymmdd DIV 100) % 100) * 31 + yyyymmdd % 100 - 1);
EXPORT fn_YYYYMMDD_to_Int(UNSIGNED4 yyyymmdd) := FUNCTION
//At this piont (as confirmed from Header.File_Header, dates have strlens of either 6 or 8
valid := IF((LENGTH(TRIM((STRING) yyyymmdd))) = 6, yyyymmdd * 100, yyyymmdd);
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
RETURN (year - 1)* 365 + (year - 1) DIV 4 + yday;
END;
