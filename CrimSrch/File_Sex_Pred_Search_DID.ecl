import ut;
/*
ds_layout_new := RECORD
	string16 seisint_primary_key;
	string8 dt_last_reported;
	string8 upload_date; //New
	string2 vendor_code;
	string20 source_file;
	string2 orig_state;
	string50 name_orig;
	string1 name_type;
	string9 ssn;
	string8 dob;
	string8 dob_aka;
	string125 registration_address_1;
	string45 registration_address_2;
	string35 registration_address_3;
	string35 registration_address_4;
	string35 registration_address_5;
	string10 registration_home_phone;
	string10 registration_cell_phone;
	string125 other_registration_address_1;
	string45 other_registration_address_2;
	string35 other_registration_address_3;
	string35 other_registration_address_4;
	string35 other_registration_address_5;
	string35 other_registration_county;
	string10 other_registration_phone;
	string125 temp_lodge_address_1;
	string45 temp_lodge_address_2;
	string35 temp_lodge_address_3;
	string35 temp_lodge_address_4;
	string35 temp_lodge_address_5;
	string35 temp_lodge_county;
	string10 temp_lodge_phone;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 cleaning_score;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 fips_st;
	string3 fips_county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string12 did;
	string3 did_score;
	string9 ssn_appended;
	unsigned8 rawaid;
	string2 newline;
END;
*/

ds_layout_new := record
  string16 seisint_primary_key;
  string8 dt_last_reported;
	string8 src_upload_date;
  string2 vendor_code;
  string20 source_file;
  string2 orig_state;
  string50 name_orig;
	string30 orig_firstname;
	string30 orig_middlename;
	string30 orig_lastname;
	string10 orig_suffix;
  string1 name_type;
  string9 ssn;
  string8 dob;
  string8 dob_aka;
  string125 registration_address_1;
  string45 registration_address_2;
  string35 registration_address_3;
  string35 registration_address_4;
  string35 registration_address_5;
	string10 registration_home_phone;		//new field added
	string10 registration_cell_phone;		//new field added
	string125 other_registration_address_1;	//new field added
	string45 other_registration_address_2;	//new field added
	string35 other_registration_address_3;	//new field added
	string35 other_registration_address_4;	//new field added
	string35 other_registration_address_5;	//new field added
	string35 other_registration_county;		//new field added
	string10 other_registration_phone;		//new field added
	string125 temp_lodge_address_1;			//new field added
	string45 temp_lodge_address_2;			//new field added
	string35 temp_lodge_address_3;			//new field added
	string35 temp_lodge_address_4;			//new field added
	string35 temp_lodge_address_5;			//new field added
	string35 temp_lodge_county;				//new field added
	string10 temp_lodge_phone;				//new field added
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 cleaning_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_st;
  string3 fips_county;
  string10 geo_lat; //changed name
  string11 geo_long;//changed name
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string3 did_score;
  string9 ssn_appended;
	unsigned8 rawaid;
	string2 newline;
end;

inputFile	:= dataset(ut.foreign_prod+'~thor_data400::in::sex_pred_search_' + CrimSrch.Version.SexPred,
							ds_layout_new,flat,unsorted
							);

CrimSrch.Layout_Sex_Pred_Search_DID oldFormat(inputFile l):= transform
	self.state_of_origin 	:= l.orig_state;
	self.orig_ssn 			:= l.ssn;
	self.date_of_birth 		:= l.dob;
	self.suffix 			:= l.addr_suffix;
	self.score				:= l.did_score;
	self.best_ssn			:= l.ssn_appended;
	self.crlf				:= l.newline;
	self := l;
end;

export File_Sex_Pred_Search_DID  := project(inputFile, oldFormat(left));

/*export File_Sex_Pred_Search_DID
 := dataset('~thor_data400::in::sex_pred_search_' + CrimSrch.Version.SexPred,
			CrimSrch.Layout_Sex_Pred_Search_DID,flat,unsorted
		   );*/