//this tries to get a state out of the zip or state field for distribution
//export string5 ZipState(string5 z, string2 st) := z;

export string2 ZipState(string5 z, string2 st) := 
	map(ziplib.ZipToState2(z) <> '' => ziplib.ZipToState2(z),
		st <> '' => st,
		z[1..2]);