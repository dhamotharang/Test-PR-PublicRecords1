IMPORT PRTE2_Email_Data, email_data;

EXPORT Layouts := MODULE

shared layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
end;

shared layout_clean182 := RECORD
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

shared incoming_base := record
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

		EXPORT incoming_boca := record
				incoming_base;
				string9   link_ssn;				//*future use for did process
				string8   link_dob;				//*future use for did process
				string10 	cust_name;
				string10 	bug_name;
		END;		
		   
		EXPORT incoming_alpha := record
			 Email_Data.Layout_Email.Scrubs_bits_base - [scrubsbits1];
			 
		END;
	
		EXPORT base := record
				Email_Data.Layout_Email.Scrubs_bits_base - [scrubsbits1];
				string9 	link_ssn;				//*future use for did process
				string8 	link_dob;				//*future use for did process
				string10 cust_name;
				string10 bug_name;
				string10	date_aging_ind;
		END;
		
		// The build process uses this layout in preparation
		EXPORT keyRec := record
	    Email_Data.Layout_Email.Keys;
		END;

		// The build process uses this layout in preparation
		EXPORT Autokey_layout := RECORD
			Email_Data.Layout_email.Autokey_layout;
		END;
END;