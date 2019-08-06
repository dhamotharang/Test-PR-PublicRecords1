EXPORT Layout_Sanctions := RECORD
  unsigned8		key;
  string			name;
  string80		first;
  string80		middle;
  string80		last;							// or organization nem
  string10		suffix;
  string8			dateofbirth;			// YYYYMMDD
  string80		street_1;
  string80		street_2;
  string80		city;
  string2			state;
  string5			zip;
  string5			country;
  string15		phone;
  string10		phone_type;
  string2			exclusion_state;
  string			offense;
  string8			offense_date;
  string			action;
  string8			action_date;
  string8			action_start;
  string8			action_end;
  string			fine;
  string			license_number;
  string1			type_id;				// Individual or Organization
  string			cred;
  string			medicaid_number;
  string10		npi_number;
  string9			dea_number;
  string			specialty_description;
  string			specialty_class_type;
  string			board;
  string10		county;
END;