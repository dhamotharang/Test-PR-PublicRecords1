export Layout_rQsent0409 :=  record,maxlength(8192)
	string	qsent_key;				//	Qsent Key - The key will be the same for pairs of records (JOHN & MARY)
	string	parsed_lname;			//	Parsed last name
	string	parsed_fname;			//	Parsed first name
	string	parsed_mname;			//	Parsed middle name
	string	parsed_title;			//	Title - Mr, Mrs, etc.
	string	parsed_namesuffix;		//	Generational suffix
	string	parsed_gender;			//	Gender - assigned from Dayton's gender table
	string	parsed_nametype;		//	"A" for "Additional household member" for multi-name listings
	string	address;				//	CASS per Qsent
	string	city;					//	city
	string	state;					//	state
	string	zip;					//	zip
	string	phone;					//	phone10
	string	listing_class;			//	RS=Residential, BG=business/government, BR=business/residential
	string	listing_type;			//	Listing Type - SL is standard listing, NP and NL
	string	action_code;			//	Action Code - I, O and B (baseline from pre 11-01-2003).  We started receiving INs and OUTs on 11/01/2003 for a 10/31/2003 baseline master.
	string	action_date;			//	Action Date - Qsent's date of action
	string	listing_name;			//	Listing Name - Unparsed listing name
  end
 ;