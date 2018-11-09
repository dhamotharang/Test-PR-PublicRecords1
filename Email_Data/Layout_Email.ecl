export Layout_Email := module
export layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
end;

export layout_clean182 := RECORD
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
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string5 county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
end;

export base := record
  string200 clean_email := '';
  string100 append_email_username;
  string120 append_domain := '';
  string12  append_domain_type := '';
  string100 append_domain_root := '';
  string20  append_domain_ext := '';
  boolean   append_is_tld_state := false;
  boolean   append_is_tld_generic := false;
  boolean   append_is_tld_country := false;
  boolean   append_is_valid_domain_ext := false;
	unsigned	email_rec_key;
	string2 email_src;
	unsigned rec_src_all;
	unsigned email_src_all;
	unsigned email_src_num;
	unsigned num_email_per_did := 0;
	unsigned num_did_per_email:= 0;
  string orig_pmghousehold_id;
  string orig_pmgindividual_id;
  string orig_first_name;
  string orig_last_name;
  string orig_address;
  string orig_city;
  string orig_state;
  string orig_zip;
  string orig_zip4;
  string orig_email;
  string orig_ip;
	string orig_login_date := '';
  string orig_site;
  string orig_e360_id;
  string orig_teramedia_id;
  unsigned6 did;
  unsigned8 did_score;
	string10  did_type := '';
	boolean	 is_did_prop := false;
	unsigned hhid := 0;
  Layout_Clean_Name clean_name;
  Layout_Clean182 clean_address;
  unsigned8 append_rawaid;
  string9 best_ssn;
  unsigned4 best_dob;
	string8		process_date := '';
	string1 activecode;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
	boolean current_rec;
 end;
 
 //Flattened layout that SCRUBS expects
 export Scrubs_Layout := record
  string200 clean_email := '';
  string100 append_email_username;
  string120 append_domain := '';
  string12  append_domain_type := '';
  string100 append_domain_root := '';
  string20  append_domain_ext := '';
  boolean   append_is_tld_state := false;
  boolean   append_is_tld_generic := false;
  boolean   append_is_tld_country := false;
  boolean   append_is_valid_domain_ext := false;
	unsigned	email_rec_key;
	string2 email_src;
	unsigned rec_src_all;
	unsigned email_src_all;
	unsigned email_src_num;
	unsigned num_email_per_did := 0;
	unsigned num_did_per_email:= 0;
  string orig_pmghousehold_id;
  string orig_pmgindividual_id;
  string orig_first_name;
  string orig_last_name;
  string orig_address;
  string orig_city;
  string orig_state;
  string orig_zip;
  string orig_zip4;
  string orig_email;
  string orig_ip;
	string orig_login_date := '';
  string orig_site;
  string orig_e360_id;
  string orig_teramedia_id;
  unsigned6 did;
  unsigned8 did_score;
	string10  did_type := '';
	boolean	 is_did_prop := false;
	unsigned hhid := 0;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
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
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string5 county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  unsigned8 append_rawaid;
  string9 best_ssn;
  unsigned4 best_dob;
	string8		process_date := '';
	string1 activecode;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
	boolean current_rec;
end;
 
 //Appended SCRUBS bits field in flat layout
 export Scrubs_bits_flat := record
	Scrubs_Layout;
	unsigned scrubsbits1 := 0;
end;

//Base layout with SCRUBS bits field 
 export Scrubs_bits_base := record
	base;
	unsigned scrubsbits1 := 0;
end;

//Base layout with temp Validation fields
export temp_Validate	:= RECORD
		base;
		Boolean SkipRec;
		Boolean IsDeath;
	END; 
 
export keys := record
		Base /*and not [		Append_RawAID, 
											date_first_seen, 
											date_last_seen, 
											date_vendor_first_reported, 
											date_vendor_last_reported,
											
											
											//NEW FIELDS NOT IN ENTIERA
											clean_email,
											email_username,
											domain,
											domain_type,
											domain_root,
											domain_ext,
											is_tld_state,
											is_tld_generic,
											is_tld_country,
											is_valid_domain_ext,
											email_rec_key,
											email_did_key,
											rec_src_all,
											email_src_all,
											email_src_num,
											num_email_per_did,
											num_did_per_email,
											did_type,
											is_did_prop,
											hhid ,
											match_best_lname,
											match_best_addr,
											activecode]*/;
			end
		 ;

export Autokey_layout :=record
keys;
unsigned1 zero := 0;
string1   blank:='';
end;

export base_sz := record
		string200 clean_email := '';
		string100 append_email_username;
		string120 append_domain := '';
		string12  append_domain_type := '';
		string100 append_domain_root := '';
		string20  append_domain_ext := '';
		string1   append_is_tld_state := '0';
		string1   append_is_tld_generic := '0';
		string1   append_is_tld_country := '0';
		string1   append_is_valid_domain_ext := '0';
		string15	email_rec_key;
		string6 	email_src;
		string5 	rec_src_all;
		string5 	email_src_all;
		string5 	email_src_num;
		string5 	num_email_per_did := '00000';
		string5 	num_did_per_email:= '00000';
		string20 	orig_pmghousehold_id;
		string50 	orig_pmgindividual_id;
		string20 	orig_first_name;
		string20 	orig_last_name;
		string64 	orig_address;
		string25 	orig_city;
		string2 	orig_state;
		string5 	orig_zip;
		string4 	orig_zip4;
		string50 	orig_email;
		string20 	orig_ip;
		string8 	orig_login_date := '';
		string25 	orig_site;
		string14 	orig_e360_id;
		string14 	orig_teramedia_id;
		string15 	did;
		string20 	did_score;
		string10  did_type := '';
		string1	 	is_did_prop := '0';
		string15 	hhid := '00000';
		Layout_Clean_Name clean_name;
		Layout_Clean182 clean_address;
		string20 	append_rawaid;
		string9 	best_ssn;
		string10 	best_dob;
		string8		process_date := '';
		string1 	activecode;
		string8 	date_first_seen;
		string8 	date_last_seen;
		string8 	date_vendor_first_reported;
		string8 	date_vendor_last_reported;
		string1 	current_rec;
end;

//Base_sz with EOR 
export EOR_base_sz := record
			base_sz;
			string2 eor := '\n\t';
end;

//Base_sz with scrubsbit
// export Scrubs_bits_base_sz := record
			// base_sz;
			// unsigned scrubsbits1 := 0;
// end;

end;