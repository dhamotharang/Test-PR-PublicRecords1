EXPORT Layout_Sanctions := RECORD
  unsigned8		key;
  string			name;
  string80		first;
  string80		middle;
  string80		last;							// or organization nem
  string10		suffix;
  string8			dateofbirth;			// YYYYMMDD
  string		street_1;
  string		street_2;
  string		city;
  string		state;
  string		zip;
  string			country;
  string		phone;
  string		phone_type;
  string2			exclusion_state;
  string			offense;
  string8			offense_date;
  string			action;
  string8			action_date;
  string8			action_start;
  string			action_end;
  string			fine;
  string			license_number;
  string1			type_id;				// Individual or Organization
  string			cred;
  string			medicaid_number;
  string		npi_number;
  string			dea_number;
  string			specialty_description;
  string			specialty_class_type;
  string			board;
  string10		county;
	string8			Entity_Date;
END;