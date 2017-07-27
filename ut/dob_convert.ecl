pos1(string dob) := stringlib.StringFind(dob, '/', 1);
pos2(string dob) := stringlib.StringFind(dob, '/', 2);

integer2 iday(string dob) := (integer2)(dob[pos1(dob) + 1..pos2(dob) - 1]);
integer2 imonth(string dob) := (integer2)(dob[1..pos1(dob) - 1]);
integer2 iyear(string dob, integer2 year_digits) 
	:= (integer2)(dob[pos2(dob) + 1..pos2(dob) + 1 + year_digits]);

export string8 dob_convert(string dob, integer2 year_digits) := 
	intformat(if(year_digits = 2, iyear(dob, year_digits) + 1900, iyear(dob, year_digits)), 4, 1) + 
	intformat(imonth(dob), 2, 1) +
	intformat(iday(dob), 2, 1):DEPRECATED('Application-specific; not appropriate for UT');