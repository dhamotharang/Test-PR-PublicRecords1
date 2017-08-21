layout :=
RECORD
	// STRING userid;
	STRING14 dl_number;
	STRING9 ssn;
	// STRING uniqueid;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 name_suffix;
	STRING8 deceased;
	STRING20 best_fname;
	STRING20 best_mname;
	STRING20 best_lname;
	STRING5 best_name_suffix;
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


export File_In_FlUnauthorized := dataset('~thor_data200::in::nowl_new',layout,csv(QUOTE('"')));