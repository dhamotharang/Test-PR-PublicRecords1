integer daynum(string dt) := 100*(integer1)dt[5..6]+(integer1)dt[7..8];
EXPORT AgeAsOf(string dob, string rightnow) := FUNCTION
	yrs := (integer4)(rightnow[1..4]) - (integer4)(dob[1..4]);
	daysapart := IF(daynum(rightnow) >= daynum(dob),1,-1);
	return MAP(
		dob = '' => 0,
		daysapart < 0 => yrs - 1,
		yrs
	);
END;