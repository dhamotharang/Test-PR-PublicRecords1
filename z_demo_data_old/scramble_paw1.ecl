import demo_data;
import paw;

file_in:= dataset('~thor::base::demo_data_file_paw_prodcopy',paw.layout.Employment_Out ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in,      // data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  true, phone,
		  false, x_DL_Number,   // dl_number field name
		  false, x_dob,		// DOB field name
		  true, ssn,	//SSN field name
		  true, did,  		// DID field name
		  false, x_bdid,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, param_bizName, // businessName Field
		  //
		  true, street,
		  true, city,
		  true, st,
		  true, zip,
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
clean_addr := fn.cleanAddress(L.street, L.city+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.email_address := if(l.email_address<>'','my_email@my_domain.com','');
self.dt_first_seen := demo_data_scrambler.fn_scramblePII('DOB',l.dt_first_seen);
self.dt_last_seen := demo_data_scrambler.fn_scramblePII('DOB',l.dt_last_seen);
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT)) : persist('~thor::persist::scramble_paw1');

export scramble_paw1  := dedup(sort(scrambled1,record),all) ;

/*
			UNSIGNED6 bdid;
		
		  STRING120 company_name;
			
			STRING10  company_prim_range;
			STRING2   company_predir;
			STRING28  company_prim_name;
			STRING4   company_addr_suffix;
			STRING2   company_postdir;
			STRING5   company_unit_desig;
			STRING8   company_sec_range;
			STRING25  company_city;
			STRING2   company_state;
			STRING5   company_zip;
			STRING4   company_zip4;
			STRING35  company_title;
			STRING35  company_department;
			
			STRING10  company_phone;
			STRING9   company_fein;
	
*/


