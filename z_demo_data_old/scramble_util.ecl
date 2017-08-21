import demo_data;
import utilfile;
//file_in:=demo_data.base_files.file_util;

file_in:= dataset('~thor::base::demo_data_file_util_prodcopy',utilfile.Layout_DID_Out ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//string5  address_zip5;
//string4  address_zip4;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
//self.address_zip5   := l.address_zip[1..5];
//self.address_zip4   := l.address_zip[7..10];
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

//output(file_in);// for comparison 


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,phone,
		  true,drivers_license ,  			// dl_number field name
		
		  false, dob,			// DOB field name
		  true,ssn, 		//SSN field name
		  true,did,  			// DID field name
		  false,param_BDID ,// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businesName Field
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
clean_addr := fn.cleanAddress(L.street, L.address_city+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.address_zip := l.zip+'-'+l.zip4;
self.p_city_name := l.v_city_name;
self.orig_lname := l.lname;
self.orig_fname := l.fname;
self.orig_mname := l.mname;
self.address_street := clean_addr[1..8];
self.address_street_Name := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.address_city := l.v_city_name;
self:=l;
END;



export scramble_util := dedup(sort(project(scrambled_file,reformat(LEFT)),record),all);
