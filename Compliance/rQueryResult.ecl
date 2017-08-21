export rQueryResult := RECORD
	string200   searchstr;
	unsigned6	did;
	string14 Is_DL;
	string14 Is_Vehicle;
	string64 contributing_source;
	unsigned3	dt_vendor_first_reported;
	unsigned3	dt_vendor_last_reported;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	UNSIGNED4 dod;
	integer4	dob;
	string9		ssn;
	string10	phone;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		suffix;
	string2		postdir;
	string10 	unit_desig;
	string8		sec_range;
	string25	city_name;
	string2		st;
	string5		zip;
	string4		zip4;
	string10	query;
END;
