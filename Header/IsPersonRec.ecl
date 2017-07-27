import business_header;

export isPersonRec(string fname, string mname, string lname, string suff) := 
	business_header.CheckPersonName(fname, mname, lname, suff) or
	((integer)(datalib.NameClean(fname + mname + lname + suff)[142])) < 9;