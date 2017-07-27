export layout_cwp_out := record
  unsigned6 fdid; // internal id
  unsigned2 penalt;
  string20  lastname;
	string20  firstname;
	string20  middlename;
	string10  housenumber;
	string3   directional;
	string35  streetname;
	string7   streetsuffix;
	string9   suitenumber;
	string30  city;
	string2   province;
	string6   postalcode;
	string10  phonenumber;
	string60  company_name;
	string8		date_first_reported; // only in V2
	string8   date_last_reported;  // only in V2
	string1 	listing_type;        // just started using since V2
	string1	 history_flag;         // only in V2 
end;