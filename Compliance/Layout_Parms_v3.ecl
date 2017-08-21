EXPORT Layout_Parms_v3 := 
	RECORD
		Layout_In;
		string200	searchstr;
		string which_parms := '';	//August 2014
		string10	class;
		unsigned6	uid;
		string20	fname;
		string20	mname;
		string20	lname;
		string64	address;
		string28	city;
		string2		state;
		string5		zip;
		string10	ssn;
		integer4	dob;
		string10	phone;
		string80	fullname;
		string80	busname;
		
		string tag := '';
		string vin := '';
		
		string name_clnr_string := '';	//April 2014
		string addr_clnr_string := '';	//April 2014
	
	END;