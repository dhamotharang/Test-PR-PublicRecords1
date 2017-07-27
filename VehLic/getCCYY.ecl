export string4 getCCYY(string2 year) := 
	map(year = '' or (data)year = x'0000'=> '',
		(integer)year < 30 => (string4)((integer)year + 2000), 
		(string4)((integer)year + 1900));