//export scramble_fl_crash_did := 'todo';

import flaccidents;

file_in:= dataset('~thor::base::demo_data_file_fL_crash4_prodcopy',flaccidents.Layout_FLCrash4_Base,flat);

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
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,driver_phone_nbr,
		  true,driver_dl_nbr ,   // dl_number field name
		
		  false,dobs,		// DOB field name
		  false,ssn, //SSN field name
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
self.p_city_name  := l.v_city_name;
self.accident_nbr := demo_data_scrambler.fn_scramblePII('NUMBER',l.accident_nbr);
self.driver_full_name :=  trim(l.fname)+' '+trim(l.mname)+ ' '+ trim(l.lname);
self.driver_st_city := trim(clean_addr[1..8],left,right)+' '+ TRIM(clean_addr[10..38],LEFT,RIGHT)+', '+l.v_city_name;
self.driver_zip := l.zip;
self.oos_dl_nbr := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));
export scramble_fl_crash4 := scrambled1;

