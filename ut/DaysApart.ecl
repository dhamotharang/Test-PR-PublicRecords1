//this works only with dates in YYYYMMDD format
export integer8 DaysApart(string8 d1, string8 d2) := 
	abs(DaysSince1900(d1[1..4], d1[5..6], d1[7..8]) -
	DaysSince1900(d2[1..4], d2[5..6], d2[7..8]));