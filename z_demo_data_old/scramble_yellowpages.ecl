
import demo_data;
import yellowpages;

file_in := dataset('~thor::base::demo_data_file_yellow_pages_prodcopy', yellowpages.Layout_YellowPages_base, flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,phone10,
		  false,dl_number ,   // dl_number field name
		  false,dob,		// DOB field name
		  false,ssn, 		//SSN field name
		  false,did,  		// DID field name
		  true,bdid,		// BDID field name
		  true,exec_fname,
		  true,exec_mname,
		  true,exec_lname,
		  false,clean_name,	// cleanName field name
		  //
		  true,business_name, // businesName Field
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
self.orig_phone10 := '';
self.orig_zip := '';
self.orig_street := '';
self.orig_city := '';
self.orig_state := '';
self.pub_date := '01'+l.pub_date[3..6];
self.executive_name := trim(l.exec_fname)+' '+trim(l.exec_mname)+' '+ trim(l.exec_lname);
self.fname := '';
self.title := '';
self.mname := '';
self.lname := '';
self.name_suffix := '';
self.nn_fix_city := l.v_city_name;
self.nn_fix_state := l.st;
self.nn_fix_zip := l.zip;
self.nn_fix_alt_city1 := '';
self.nn_fix_alt_zip1 := '';
self := l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_yellowpages := dedup(sort(scrambled1(business_name<>'' and exec_lname<>''),record),all);
