IMPORT PRTE2_Marriage_Divorce, marriage_divorce_v2;

EXPORT Layouts := MODULE

	EXPORT Main_in := RECORD
		 UNSIGNED3 dt_first_seen;
		 UNSIGNED3 dt_last_seen;
		 UNSIGNED3 dt_vendor_first_reported;
     UNSIGNED3 dt_vendor_last_reported;
     UNSIGNED6 record_id;  //unique record identifier that'll be used to link main and search files
 
		//current values are "3" for marriages and "7" for divorces
		//Additions:
		//"0" for unknown
		//"1" for annulment
		//-> we want to expand to include dissolutions, etc
		STRING1   filing_type;
		STRING25  filing_subtype;
		STRING5   vendor;
		STRING25  source_file;
		STRING8   process_date;
		STRING2   state_origin;
		UNSIGNED6	party1_did;
		//Same sex marriages in production reveal we can't assume Husband/Spouse relations
		STRING1   party1_type; //"G" for Groom, "H" for Husband, "S" for Spouse, "W" for Wife, etc
		STRING1   party1_name_format; //"L" for last name first, "F" for first name first
		STRING70  party1_name;
		STRING70  party1_alias;
		STRING8   party1_dob;
		STRING9		party1_ssn;
		STRING2   party1_birth_state;
		STRING3   party1_age;
		STRING30  party1_race;
		STRING50  party1_addr1;
		STRING25  party1_city_name;
		STRING2		party1_state;
		STRING10	party1_zip;
		STRING35  party1_county;
		STRING20  party1_previous_marital_status;
		STRING20  party1_how_marriage_ended;
		STRING2   party1_times_married;
		STRING8   party1_last_marriage_end_dt;
		UNSIGNED6	party2_did;
		STRING1   party2_type;
		STRING1   party2_name_format;
		STRING70  party2_name;
		STRING70  party2_alias;
		STRING8   party2_dob;
		STRING9		party2_ssn;
		STRING2   party2_birth_state;
		STRING3   party2_age;
		STRING30  party2_race;
		STRING50  party2_addr1;
		STRING25  party2_city_name;
		STRING2		party2_state;
		STRING10	party2_zip;
		STRING35  party2_county;
		STRING20  party2_previous_marital_status;
		STRING20  party2_how_marriage_ended;
		STRING2   party2_times_married;
		STRING8   party2_last_marriage_end_dt;
		
		//New fields added to handle second party alias with different DID
		UNSIGNED6	party2a_did;
		//Same sex marriages in production reveal we can't assume Husband/Spouse relations
		STRING1   party2a_type; //"G" for Groom, "H" for Husband, "S" for Spouse, "W" for Wife, etc
		STRING1   party2a_name_format;
		STRING70  party2a_name;
		STRING70  party2a_alias;
		STRING8   party2a_dob;
		STRING2   party2a_birth_state;
		STRING3   party2a_age;
		STRING30  party2a_race;
		STRING50  party2a_addr1;
		STRING25  party2a_city_name;
		STRING2		party2a_state;
		STRING10	party2a_zip;
		STRING35  party2a_county;
		STRING20  party2a_previous_marital_status;
		STRING20  party2a_how_marriage_ended;
		STRING2   party2a_times_married;
		STRING8   party2a_last_marriage_end_dt;
	//
		STRING2   number_of_children;
		STRING8   marriage_filing_dt;
		STRING8   marriage_dt;
		STRING30  marriage_city;
		STRING35  marriage_county;
		STRING10  place_of_marriage;
		STRING10  type_of_ceremony;
		STRING25  marriage_filing_number;
		STRING30  marriage_docket_volume;
		STRING8   divorce_filing_dt;
		STRING8   divorce_dt;
		STRING30  divorce_docket_volume;
		STRING25  divorce_filing_number;
		STRING30  divorce_city;
		STRING35  divorce_county;
		STRING50  grounds_for_divorce;
		STRING1   marriage_duration_cd;
		STRING3   marriage_duration;
		UNSIGNED8 persistent_record_id := 0;
		STRING20	cust_name;
		STRING10	bug_num;
		STRING8		link_party1_dob;
		STRING9		link_party1_ssn;
		STRING8		link_party2_dob;
		STRING9		link_party2_ssn;
	END;
	
	EXPORT Main_Base_out := RECORD //includes DI added fields(cust_name, bug_num)
		marriage_divorce_v2.layout_mar_div_base;
		STRING20	cust_name;
		STRING10	bug_num;
		STRING8		link_party1_dob;
		STRING9		link_party1_ssn;
		STRING8		link_party2_dob;
		STRING9		link_party2_ssn;
	END;
	
	EXPORT Main_Base := RECORD
		marriage_divorce_v2.layout_mar_div_base;
	END;
	
	EXPORT Search_Base := RECORD
		marriage_divorce_v2.layout_mar_div_search;
	END;
	
	EXPORT Search_Base_ext := RECORD
		Search_Base;
		STRING20	cust_name;
		STRING10	bug_num;
		STRING8		link_dob;
		STRING9		link_ssn;
	END;	
	
	
END;
		