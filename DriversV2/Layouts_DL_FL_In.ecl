
export Layouts_DL_FL_In := MODULE

	export Layout_FL_update := record
		 string  blob;
	end;
	
	export Layout_FL_Fixed := record
		 string1  issuance;
		 string1  address_change;
		 string1  name_change;
		 string1  dob_change;
		 string1  sex_change;
		 string52 name;
		 string30 addr1;
		 string20 city;
		 string2  st;
		 string5  zip;
		 string8  dob;
		 string1  race;
		 string1  sex_flag;
		 string12 lic_type;
		 string14 attention_flag;
		 string8  dod;
		 string5  restriction;
		 string8  exp_date;
		 string8  lic_issue_date;
		 string5  lic_endorsements;
		 string13 dl_number;
		 string9  ssn;
		 string3  age;
		 string13 new_dl_number;
		 string1  personal_info_flag;
		 string2  xxx1;
		 string8  dl_orig_issue_date;
		 string3  height;
		 string21 oos_previous_dl_number;
		 string2  oos_previous_st;
		 string1  filler2;
	end;
	
	export Layout_FL_With_ProcessDte := record
	     string8 process_date;
		 Layout_FL_Fixed;
	end;

end;