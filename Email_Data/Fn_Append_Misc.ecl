//****************Function to append Misc *************************************

import ut,didville, header_services ;

EXPORT Fn_Append_Misc(dataset(recordof(Layout_Email.Base)) email_in) := function

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
		string1   append_is_tld_state := '0';
		string1   append_is_tld_generic := '0';
		string1   append_is_tld_country := '0';
		string1   append_is_valid_domain_ext := '0';
		string15	email_rec_key;
		string6 email_src;
		string5 rec_src_all;
		string5 email_src_all;
		string5 email_src_num;
		string5 num_email_per_did := '00000';
		string5 num_did_per_email:= '00000';
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
		string15 did;
		string20 did_score;
		string10  did_type := '';
		string1	 is_did_prop := '0';
		string15 hhid := '00000';
		Layout_Clean_Name clean_name;
		Layout_Clean182 clean_address;
		string20 append_rawaid;
		string9 best_ssn;
		string10 best_dob;
		string8		process_date := '';
		string1 activecode;
		string8 date_first_seen;
		string8 date_last_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string1 current_rec;
		string2 eor := '\n\t';
end;


	Email_Data.Layout_Email.base xToEmail_Data(base_sz L):= TRANSFORM
	  self.append_is_tld_state := (boolean) ((unsigned) L.append_is_tld_state) ;
    self.append_is_tld_generic := (boolean)  ((unsigned) L.append_is_tld_generic) ;
    self.append_is_tld_country := (boolean)  ((unsigned)L.append_is_tld_country);
    self.append_is_valid_domain_ext := (boolean)  ((unsigned) L.append_is_valid_domain_ext) ;
		self.email_rec_key := (unsigned6) L.email_rec_key;
		self.rec_src_all := (unsigned2) L.email_src_all ;
		self.email_src_all := (unsigned2)  L.email_src_all ;
		self.email_src_num := (unsigned2)  L.email_src_num ;
		self.num_email_per_did := (unsigned2)  L.email_src_num ;
		self.num_did_per_email := (unsigned2)  L.email_src_num ;		
		self.did := (unsigned6) L.did ;
    self.did_score:= (unsigned8) L.did_score ;
	  self.is_did_prop := (boolean) ((unsigned) L.is_did_prop) ;
	  self.hhid := (unsigned6) L.hhid ;
	  self.append_rawaid:= (unsigned8) L.append_rawaid ;
    self.best_dob:= (unsigned6) L.best_dob ;
	  self.current_rec:= (boolean) ((unsigned) L.current_rec) ;
		self := L ;
	END;  
	
   Suppression_Layout 	:= header_services.Supplemental_Data.layout_in;
   header_services.Supplemental_Data.mac_verify('file_email_sup.txt',  Suppression_Layout, email_sup );
	 email_sup_in := email_sup() ;
	 current_sup 			:= PROJECT(	email_sup_in, header_services.Supplemental_Data.in_to_out(left));
	
   rollup_data := join (email_in, current_sup, 
					 hashmd5(left.clean_email) = right.hval or
					 hashmd5(left.did, left.clean_email)  = right.hval or
					 hashmd5(left.did) = right.hval,
					 transform(LEFT)
	             , LEFT ONLY, ALL) ;
							 
   header_services.Supplemental_Data.mac_verify('file_email_inj.txt',  base_sz, email_service );
	 ds := project(email_service(), xToEmail_Data(LEFT));
	   
	 misc_data := distribute(rollup_data + ds, random()) ;
	 
	 
	
return misc_data ;

END ;