export string1 getCusType(string fname, string lname, string cname) := 
	map(fname <> '' or lname <> '' => 'I',
	    cname <> '' => 'B', 'U');