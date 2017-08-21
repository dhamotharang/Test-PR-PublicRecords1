import demo_data;
import corp2;

file_in:= demo_data_scrambler.scramble_contdata;

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.corp_addr1_prim_range+' '+(string30)L.corp_addr1_prim_name+' '+(string3)L.corp_addr1_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false, cont_phone10,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  false, bdid,		// BDID field name
		  false, cont_fname,
		  false, cont_mname,
		  false, cont_lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, corp_legal_name, // businessName Field
		  //
		  true, street,
		  true, corp_addr1_v_city_name,
		  true, corp_addr1_state,
		  true, corp_addr1_zip5,
		  true, corp_addr1_zip4,
		  false, dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);

//****     REFORMAT SOME FIELDS BACK INTO THE ORIGINAL FILE
recordof(file_in) reformat(scrambled_file L):= TRANSFORM
clean_addr := fn.cleanAddress(L.street, L.corp_addr1_v_city_name+' '+L.corp_addr1_zip5+' '+L.corp_addr1_zip4);
self.corp_addr1_prim_range := clean_addr[1..8];
self.corp_addr1_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.corp_addr1_p_city_name  := l.corp_addr1_v_city_name;
self.corp_address1_line1 := trim(clean_addr[1..8])+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.corp_address1_line2 := trim(l.corp_addr1_v_city_name)+', '+l.corp_addr1_state +' '+l.corp_addr1_zip5;
self.corp_address1_line3 := '';
self.corp_address1_line4 := '';
self.corp_address1_line5 := '';
self.corp_address1_line6 := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_contdata2  := dedup(sort(scrambled1,record),all);

