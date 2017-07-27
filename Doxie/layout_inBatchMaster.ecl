export layout_inBatchMaster := record

	unsigned8   seq := 0;
	string20	 	acctno := '';
	
	string20		name_first := '';
	string20		name_middle := '';
	string20		name_last := '';
	string5			name_suffix := '';

	string10  	prim_range := '';
	string2   	predir := '';
	string28  	prim_name := '';
	string4   	addr_suffix := '';
	string2   	postdir := '';
	string10  	unit_desig := '';
	string8   	sec_range := '';
	string25  	p_city_name := '';
	string2   	st := '';
	string5   	z5 := '';
	string4   	zip4 := '';

	string12		ssn := '';
	string8			dob := '';
	string10  	homephone := '';
	string16		workphone := '';

	string25		dl:= '';
	string2			dlstate := '';
	
	String50		vin := '';
	String10		Plate := '';
	String2			PlateState := '';

	String20		searchType := '';
	string4		 	max_results := ''; //had '50' here, but that dont really work so ill put it in the file attr
	
	unsigned6   DID := 0;
	unsigned2 	score := 0;
	string20    MatchCode := '';

end;