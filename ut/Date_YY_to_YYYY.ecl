// Convert two-digit years to four digits, using a 100-year window
// around the current year, as defined by a delta of the end of the
// window relative to to the current year.
//
// Ex: In 2010 with a delta of 5, we return years from 1916-2015.
//
export unsigned Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function
	unsigned now	:= (unsigned)ut.GetDate;
	unsigned high	:= (unsigned)now[1..4] + delta;
	unsigned test	:= yy + ((unsigned)now[1..2]*100);
	unsigned yyyy	:= if(test<=high, test, test-100);
	return yyyy;
	// NOTE: Pass yy<100 and delta<100 or craziness ensues
end;