EXPORT Layout_Sole_Sourced_Out := 
		MODULE
			EXPORT	All_recs := 
					RECORD
						string sole_source := '';
						string sole_source_category := '';
						string source_cd := '';
						unsigned6 LexID := 0;
						string did_segment := '';
												
						string orig_lexid;
						string timestamp;
						string time;
						string data_src;
						string action;
						string dppa;
						string glba;
						string reference;
						string ip_address;
						string ip_location;
						string billgroup;
						string webid;
						string lexisid;
						string password;
						string lib;
						string file;
						string document_num;
						string database;
						string ansr_count;
						string permission_5a;
						string orig_search_terms;
						string edited_search_terms;
						integer8 orig_rid;
						
						string search_str;

						integer8 append_row_id;
					  string action_dmf_value;	//August 2016
						string action_funcname;		//June2016
						string srch_criteria;
						string20 srch_fname;
						string20 srch_mname;
						string20 srch_lname;
						string srch_fullname;
						string srch_busname;
						string64 srch_address;
						string8 srch_address_sec_range;
						string28 srch_city;
						string2 srch_state;
						string5 srch_zip;
						string10 srch_ssn;
						integer4 srch_dob;
						string10 srch_phone;
						unsigned6 srch_uid;
						string srch_tag;
						string srch_vin;
						string name_clnr_string;
						string addr_clnr_string;
						integer4 age_lower;
						integer4 age_upper;
						string10 srch_class;
						string srch_dataset;
						string source_value;
						unsigned6 did;
						string src;
						unsigned3 dt_last_seen;
						unsigned3 dt_vendor_last_reported;
						string1 valid_dob;
						unsigned6 hhid;
						string18 county_name;
						string120 listed_name;
						string10 listed_phone;
						unsigned4 dod;
						string1 death_code;
						unsigned4 lookup_did;
						string tag_num;
						string vin_num;
						string veh_reg_num;
						string dl_state;
						string dl_num;
						string doc_num;
						unsigned6 result_rid;
						unsigned6 rid;
						unsigned8 persistent_record_id;
						unsigned8 rawaid;
						unsigned3 dt_first_seen;
						unsigned3 dt_vendor_first_reported;
						unsigned3 dt_nonglb_last_seen;
						string1 rec_type;
						qstring18 vendor_id;
						string1 tnt;
						string1 valid_ssn;
						qstring9 ssn;
						integer4 dob;
						qstring20 fname;
						qstring20 mname;
						qstring20 lname;
						qstring5 name_suffix;
						qstring10 prim_range;
						string2 predir;
						qstring28 prim_name;
						qstring4 suffix;
						string2 postdir;
						qstring10 unit_desig;
						qstring8 sec_range;
						qstring25 city_name;
						string2 st;
						qstring5 zip;
						qstring4 zip4;

						string8 dod_from_lndmf;	//August 2016
						string2 src_from_lndmf;	//August 2016
						string  rec_src_from_lndmf;	//August 2016
						
						boolean has_ssn;
						boolean has_dob;
						boolean has_dl;
						boolean has_dod;	//August 2016
					END;
					
//---------------------------------------------------
				
			EXPORT	Report_format := 
					RECORD
					 string sole_source := '';
						string sole_source_category := '';
						string source_cd := '';
						unsigned6 LexID := 0;
						string did_segment := '';
						string orig_lexid;
						string timestamp;
						string time;
						string data_src;
						string action;
						string dppa;
						string glba;
						string reference;
						string ip_address;
						string ip_location;
						string billgroup;
						string webid;
						string lexisid;
						string password;
						string lib;
						string file;
						string document_num;
						string database;
						string ansr_count;
						string permission_5a;
						string orig_search_terms;
						string edited_search_terms;
						
						integer8 orig_rid;
						integer8 append_row_id;
//						string action_dmf_value;	//August 2016
//						string action_funcname;		//August 2016

						string10 srch_class;
						string srch_dataset;
						string source_value;
						unsigned6 did;
						unsigned6 rid;
						unsigned6 hhid;
						string src;
						unsigned3 dt_first_seen;
						unsigned3 dt_last_seen;
						unsigned3 dt_vendor_last_reported;
						unsigned3 dt_vendor_first_reported;
						string1 valid_dob;
						unsigned4 dod;
						string1 death_code;
						string1 rec_type;
						qstring18 vendor_id;
						string1 valid_ssn;
						qstring9 ssn;
						integer4 dob;
						qstring20 fname;
						qstring20 mname;
						qstring20 lname;
						qstring5 name_suffix;
						qstring10 prim_range;
						string2 predir;
						qstring28 prim_name;
						qstring4 suffix;
						string2 postdir;
						qstring10 unit_desig;
						qstring8 sec_range;
						qstring25 city_name;
						string2 st;
						qstring5 zip;
						qstring4 zip4;
						
//						string8 dod_from_lndmf;		//August 2016
					END;
			END;
