import demo_data;
import paw;

file_in:= demo_data_scrambler.scramble_paw1;

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.company_prim_range+' '+(string30)L.company_prim_name+' '+(string3)L.company_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in,      // data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  true, company_phone,
		  false, x_DL_Number,   // dl_number field name
		  false, x_dob,		// DOB field name
		  true, company_fein,	//SSN field name
		  false, x_did,  		// DID field name
		  true, bdid,		// BDID field name
		  false, fname,
		  false, mname,
		  false, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, company_name, // businessName Field
		  //
		  true, street,
		  true, company_city,
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

//****     REFORMAT SOME FIELDS BACK INTO THE ORIGINAL FILE
recordof(file_in) reformat(scrambled_file L):= TRANSFORM
clean_addr := fn.cleanAddress(L.street, L.company_city+' '+L.company_zip+' '+L.company_zip4);
self.company_prim_range := clean_addr[1..8];
self.company_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self:=l;
END;

scrambled2 := project(scrambled_file,reformat(LEFT)); 

export scramble_paw2  := dedup(sort(scrambled2,record),all) ;



