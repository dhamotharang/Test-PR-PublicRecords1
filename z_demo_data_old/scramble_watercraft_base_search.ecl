//export scramble_watercraft_base_search := 'todo';

import watercraft;

file_in:= dataset('~thor::base::demo_data_file_watercraft_base_search_prodcopy', watercraft.Layout_Watercraft_Search_Base ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, phone_1,
		  false, x_DL_Number,   // dl_number field name
		  true, dob,		// DOB field name
		  true, ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, param_bizName, // businessName Field
		  //
		  true, street,
		  true, v_city_name,
		  true, st,
		  true, zip5,
		  true, zip4,
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
scrambled_company_name := if(l.company_name<>'', demo_data_scrambler.fn_scrambleBizName(l.company_name),'');
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip5+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.orig_ssn := '';
self.orig_fein := '';
self.phone_2:= '';
self.fein := '';
self.orig_address_1 := trim(clean_addr[1..8],left,right)+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.orig_address_2 :='';
self.orig_city := l.v_city_name;
self.orig_state := l.st;
self.orig_zip := l.zip5;
self.orig_name_first := '';
self.orig_name_middle:= '';
self.orig_name_last:= '';
self.orig_name_suffix:= '';
self.orig_name := if(scrambled_company_name<>'',scrambled_company_name,trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname));
self.company_name := scrambled_company_name; 
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_watercraft_base_search  := dedup(sort(scrambled1,record),all);



