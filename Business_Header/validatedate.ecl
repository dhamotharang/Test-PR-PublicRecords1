export string8 validatedate(string8 mydate, integer4 dateformat = 0) :=
map(dateformat = 0 =>
map(mydate = '' or (integer)mydate > (integer)(stringlib.GetDateYYYYMMDD()) or (integer)mydate < 16000101 => '',
	mydate),
	dateformat = 1 =>
map(mydate = '' or (integer)mydate > (integer)(stringlib.GetDateYYYYMMDD()[1..6]) or (integer)mydate < 160001 => '',
	mydate), mydate);
