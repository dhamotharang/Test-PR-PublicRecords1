import demo_data;
import dnb;

file_in:= dataset('~thor::base::demo_data_file_dnb_contacts_base_prodcopy',dnb.Layout_DNB_Contacts_Base,flat);
//

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 streetx;
END;

mod_file_rec addCleanName(file_in L):= transform
self.streetx := (string8)L.company_prim_range+' '+(string30)L.company_prim_name+' '+(string3)L.company_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, company_phone10,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, company_name, // businessName Field
		  //
		  true, streetx,
		  true, company_v_city_name,
		  true, company_st,
		  true, company_zip,
		  true, company_zip4,
		  false, dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
//
file_in to_finish(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.streetx, L.company_v_city_name+' '+L.company_zip+' '+L.company_zip4);
self.company_prim_range := clean_addr[1..8];
self.company_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.company_p_city_name  := l.company_v_city_name;
//
self.duns_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.duns_number);
self.exec_first_name := l.fname;
self.exec_middle_initial := l.mname;
self.exec_last_name := l.lname;
self.exec_suffix := l.name_suffix;
self := l;
end;

scrambled := project(scrambled_file, to_finish(left));

export scramble_dnb_contacts_base  := dedup(sort(scrambled,record),all); 
