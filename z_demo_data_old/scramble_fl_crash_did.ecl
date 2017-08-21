//export scramble_fl_crash_did := 'todo';

import flaccidents;

file_in:= dataset('~thor::base::demo_data_file_fL_crash_did_prodcopy',flaccidents.Layout_FLCrash_Search,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  true,driver_license_nbr,   // dl_number field name
		
		  false,dob,		// DOB field name
		  false,ssn, 		//SSN field name
		  true,did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,zip,
		  true,zip4,
		  false,dr_clean_address,// cleanAddress fieldname
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.accident_nbr := demo_data_scrambler.fn_scramblePII('NUMBER',l.accident_nbr);
self.accident_date := demo_data_scrambler.fn_scramblePII('DOB',l.accident_date);
self.cname := if(l.cname<>'', 'My Company','');
self.vin := '';
self.tag_nbr := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));

export scramble_fl_crash_did := scrambled1;

