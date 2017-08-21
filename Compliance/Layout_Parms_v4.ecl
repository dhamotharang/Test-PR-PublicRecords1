EXPORT Layout_Parms_v4 := 
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
		
		integer4	age_lower := 0;		//December 2014; for "Age Range(nn to nn)"
		integer4	age_upper := 0;		//December 2014; for "Age Range(nn to nn)"

//June 2016: See Compliance.Layout_Details_from_ACTION_field	
		string	ACTION_DPPA := '';
		string	ACTION_GLBA := '';
		string	ACTION_DMF_Desc := '';
		string	ACTION_DMF_Value := '';
		string	ACTION_FuncName := '';
		
	END;