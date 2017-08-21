import demo_data;
import corp2;

file_in:= dataset('~thor::base::demo_data_file_contdata_prodcopy',Corp2.Layout_Corporate_Direct_cont_Base ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.cont_prim_range+' '+(string30)L.cont_prim_name+' '+(string3)L.cont_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, cont_phone10,
		  false, x_DL_Number,   // dl_number field name
		  true, cont_dob,		// DOB field name
		  true, cont_ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, cont_fname,
		  true, cont_mname,
		  true, cont_lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, param_bizName, // businessName Field
		  //
		  true, street,
		  true, cont_v_city_name,
		  true, cont_state,
		  true, cont_zip5,
		  true, cont_zip4,
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
clean_addr := fn.cleanAddress(L.street, L.cont_v_city_name+' '+L.cont_zip5+' '+L.cont_zip4);
self.cont_prim_range := clean_addr[1..8];
self.cont_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.cont_p_city_name  := l.cont_v_city_name;
/*---------------------------- JAYANTS CHANGES ------------------------*/
self.corp_process_date := fn_scramblePII('DOB',L.corp_process_date);
self.corp_orig_sos_charter_nbr := fn_scramblePII('SCR_SECOND',L.corp_orig_SOS_charter_nbr);
self.corp_sos_charter_nbr := fn_scramblePII('SCR_SECOND',L.corp_SOS_charter_nbr);
self.corp_phone_number := fn_scramblePII('phone',L.corp_phone_number);
//-----------------------------------------------------------------------
self.cont_name := trim(l.cont_fname)+' '+trim(l.cont_mname)+' '+trim(l.cont_lname);
self.cont_address_line1 := trim(clean_addr[1..8])+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.cont_address_line2 := trim(l.cont_v_city_name)+', '+l.cont_state +' '+l.cont_zip5;
self.cont_address_line3 := '';
self.cont_address_line4 := '';
self.cont_address_line5 := '';
self.cont_address_line6 := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_contdata  := dedup(sort(scrambled1,record),all) : persist('thor::persist::scramble_contdata');

