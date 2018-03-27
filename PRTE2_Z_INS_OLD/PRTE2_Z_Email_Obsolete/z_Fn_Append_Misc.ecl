// ????  Not sure if this applies to CT or not

import ut,didville, header_services ;

EXPORT Fn_Append_Misc(dataset(recordof(_layouts.Base)) email_in) := function

			layout_clean_name := RECORD
				 string5 title;
				 string20 fname;
				 string20 mname;
				 string20 lname;
				 string5 name_suffix;
				 string3 name_score;
			end;

			layout_clean182 := RECORD
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
			
			base_sz := record
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
				unsigned6	email_rec_key;
				string6 email_src;
				unsigned2 rec_src_all;
				unsigned2 email_src_all;
				unsigned2 email_src_num;
				unsigned2 num_email_per_did := 0;
				unsigned2 num_did_per_email:= 0;
				string20 orig_pmghousehold_id;
				string50 orig_pmgindividual_id;
				string20 orig_first_name;
				string20 orig_last_name;
				string64 orig_address;
				string25 orig_city;
				string2 orig_state;
				string5 orig_zip;
				string4 orig_zip4;
				string50 orig_email;
				string20 orig_ip;
				string8 orig_login_date := '';
				string25 orig_site;
				string14 orig_e360_id;
				string14 orig_teramedia_id;
				unsigned6 did;
				unsigned8 did_score;
				string10  did_type := '';
				boolean	 is_did_prop := false;
				unsigned6 hhid := 0;
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
		 
			layout_email_hashed := RECORD
				 data16 hash_email ;
				data16 hash_did_email ;
				data16 hash_did ;

			END ;

			_layouts.base xToEmail_Data(base_sz L):= TRANSFORM
				self := L ;
			END;   
			 
			 header_services.Supplemental_Data.mac_verify('file_email_sup.txt',  layout_email_hashed, email_sup );
			 current_sup := email_sup() ;
			
			 rollup_data := join (email_in, current_sup, 
							 hashmd5(left.clean_email) = right.hash_email or
							 hashmd5(left.did, left.clean_email)  = right.hash_did_email or
							 hashmd5(left.did) = right.hash_did,
							 transform(LEFT)
									 , LEFT ONLY, ALL) ;
									 
			 header_services.Supplemental_Data.mac_verify('file_email_inj.txt',  base_sz, email_service );
			 ds := project(email_service(), xToEmail_Data(LEFT));
				 
			 misc_data := rollup_data + ds ;
			
			return misc_data ;

END ;