EXPORT Regulatory := module

		export layout_clean_name := RECORD			
				string5 	title;			
				string20 	fname;			
				string20 	mname;			
				string20 	lname;			
				string5 	name_suffix;			
				string3 	name_score;			
		end;
		
		export layout_clean182 := RECORD
				string10 	prim_range;
				string2 	predir;
				string28 	prim_name;
				string4 	addr_suffix;
				string2 	postdir;
				string10 	unit_desig;
				string8 	sec_range;
				string25 	p_city_name;
				string25 	v_city_name;
				string2 	st;
				string5 	zip;
				string4 	zip4;
				string4 	cart;
				string1 	cr_sort_sz;
				string4 	lot;
				string1 	lot_order;
				string2 	dbpc;
				string1 	chk_digit;
				string2 	rec_type;
				string5 	county;
				string10 	geo_lat;
				string11 	geo_long;
				string4 	msa;
				string7 	geo_blk;
				string1 	geo_match;
				string4 	err_stat;
		end;


		export Email_Layout := record
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
				string2 	eor := '\n\t';

		end;

		//comment fields are used in the original version of email_data
		export complex_email_append(base_ds, filename, drop_layout, base_layout) := 
					functionmacro
							base_layout xToEmail_Data(drop_layout L):= 
									TRANSFORM   // transform LZ to Prod V2
											self.append_is_tld_state 		:= (boolean) ((unsigned) L.append_is_tld_state) ;
											self.append_is_tld_generic	:= (boolean) ((unsigned) L.append_is_tld_generic) ;
											self.append_is_tld_country 	:= (boolean) ((unsigned)L.append_is_tld_country);
											self.append_is_valid_domain_ext := (boolean) ((unsigned) L.append_is_valid_domain_ext) ;
											self.email_rec_key 					:= (unsigned6) L.email_rec_key;
											// self.rec_src_all 						:= (unsigned2) L.email_src_all ;
											// self.email_src_all 					:= (unsigned2) L.email_src_all ;
											// self.email_src_num 					:= (unsigned2) L.email_src_num ;
											// self.num_email_per_did 			:= (unsigned2) L.email_src_num ;
											// self.num_did_per_email 			:= (unsigned2) L.email_src_num ;		
											self.did 										:= (unsigned6) L.did ;
											self.did_score							:= (unsigned8) L.did_score ;
											// self.is_did_prop 						:= (boolean) ((unsigned) L.is_did_prop) ;
											self.hhid 									:= (unsigned6) L.hhid ;
											self.append_rawaid					:= (unsigned8) L.append_rawaid ;
											self.clean_dob							:= (unsigned6) L.best_dob ;
											self.current_rec						:= (boolean) ((unsigned) L.current_rec) ;
											// the only source we currently use is currently ET, but as that my change i put in a case statement to 
											// help evaluate possible future source codes
											self.global_sid							:= case(l.email_src,
																										'ET' => 25321,
																										25321);     
											self												:= L ;
											self 												:= [];
									END;  					
			
							Base_File_Append_In := suppress.applyregulatory.getFile(filename, Drop_Layout);  		
							Base_Proj := project(Base_File_Append_in, xToEmail_Data(LEFT));
							
							return (base_ds + base_proj);
					endmacro;		//complex_email_append	


			export complex_email_sup(base_ds, filename, hashfunc1, hashfunc2, hashfunc3) := 
					functionmacro
							import header_services;
							local supLayout := header_services.Supplemental_Data.layout_in;
														
							sup_in := suppress.applyregulatory.getFile(filename, supLayout);
					
							local dSuppressedIn := project(sup_In, header_services.Supplemental_Data.in_to_out(left));
					
							return join (base_ds, dSuppressedIn, 
									hashFunc1(left) = right.hval or
									hashFunc2(left) = right.hval or
									hashFunc3(left) = right.hval
									, transform(LEFT)
											, LEFT ONLY
											, ALL) ;											
					endmacro; // complex_email_sup

			//
			// process EMail information
			//
			export apply_email(ds) := 
					functionmacro
							Import dx_email;
							Email_Hash(recordof(ds) L) 		:= hashmd5(trim(l.clean_email, left, right));
							DID_Hash(recordof(ds) L) 			:= hashmd5(trim((string)l.did, left, right));
							combined_hash(recordof(ds) L) := hashmd5(trim((string)l.did, left, right), trim(l.clean_email, left, right));
					
							ds1 := Email_DataV2.Regulatory.complex_email_sup(ds, 'file_email_sup.txt', email_Hash, did_hash, combined_hash);
							// there is an outstanding question if dx_email.layouts should be used versus Email_DataV2.Layouts.Base_BIP
							return	Email_DataV2.Regulatory.complex_email_append(ds1, 'file_email_inj.txt', email_datav2.Regulatory.Email_Layout, Email_DataV2.Layouts.Base_BIP);					
							
					endmacro; // applyEMail					
end;