import ut, std;

string4 guessyear(string2 yr, integer yearOU) := 
	if((integer)yr < yearOU, '20' + yr, '19' + yr);
	
unsigned4 thisyear := (unsigned4)(((STRING)Std.Date.Today())[1..4]);

checkflip(string8 dt) := 
	if(abs(thisyear - (unsigned4)(dt[1..4])) < abs(thisyear - (unsigned4)(dt[5..8])),
	dt,
	dt[5..8] + dt[1..4]);

export string8 get_BizRegDate(string dt, yearOU = 50) := 
	case(length(trim(dt)),
			 10 => ut.dob_convert(dt, 4),
			 8 => checkflip(dt),
			 6 => ut.dob_convert(dt[1..2] + '/' + dt[3..4] + '/' + guessyear(dt[5..6],yearOU), 4),
			 '');