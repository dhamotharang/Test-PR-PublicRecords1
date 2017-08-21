layout :=
RECORD
	// STRING userid;
	STRING9 ssn;
	STRING14 dl_number;
	// STRING uniqueid;
	STRING8 deceased;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 name_suffix;
	STRING address;
	STRING city;
	STRING2 state;
	STRING5 zip;
	STRING10 phone;
	STRING name_dual;
	STRING8 date_first;
	STRING8 date_last;
	STRING9 best_ssn;
END;

export File_Group_One := dataset('~thor_data400::in::nightowl::group_one',layout,CSV(QUOTE('"')));