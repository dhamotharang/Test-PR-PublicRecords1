export string10 percentage_diff(integer oldnum, integer newnum) := 
	map(oldnum = 0 and newnum > 0 => '\'+infinity',
		newnum = 0 and oldnum > 0 => '\'-infinity',
		(string10)round((-100 * ((oldnum - newnum) / oldnum))));