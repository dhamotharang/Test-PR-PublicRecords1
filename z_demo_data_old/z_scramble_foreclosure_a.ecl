import demo_data;
import property;

file_in:= dataset('~thor::base::demo_data_file_foreclosure_prodcopy',property.Layout_Fares_Foreclosure,flat);


//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;
mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.situs1_prim_range+' '+(string30)L.situs1_prim_name+' '+(string3)L.situs1_addr_suffix;
self:=l;
END;
mod_file_in:=PROJECT(file_in,addCleanName(Left));
mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in,      		// data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  true,name1_ssn, 		//SSN field name
		  true,name1_did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,name1_first,
		  true,name1_middle,
		  true,name1_last,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,situs1_v_city_name,
		  true,situs1_st,
		  true,situs1_zip,
		  true,situs1_zip4,
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
clean_addr := fn.cleanAddress(L.street, L.situs1_v_city_name+' '+L.situs1_zip+' '+L.situs1_zip4);
self.situs1_prim_range := clean_addr[1..8];
self.situs1_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.situs1_p_city_name  := l.situs1_v_city_name;
self:=l;
END;
export scramble_foreclosure_a := dedup(sort(project(scrambled_file,reformat(LEFT)),record),all);	// : persist('thor::persist::scramble_foreclosure_a');


