
import demo_data;
import driversv2;

file_in:= dataset('~thor::base::demo_data_file_dl_searchv2_prodcopy',DriversV2.Layout_Drivers,flat);
//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
string8 dobs;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
self.dobs := intformat(l.dob,8,0);
//self.mail_street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  true,dl_number ,   // dl_number field name
		
		  true,dobs,		// DOB field name
		  true,ssn, 		//SSN field name
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
		  true,zip5,
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip5+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.dob	:= (integer) l.dobs;
self.name := trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname);
self.addr1 :=  trim(clean_addr[1..8])+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.city :=l.v_city_name;
//self.mail_prim_range := '';
//self.mail_predir    := '';
//self.mail_postdir    := '';
//self.mail_prim_name  := '';
//self.mail_sec_range  := '';
//self.mail_unit_desig := '';
//self.mail_addr_suffix 	:= '';
//self.mail_p_city_name := '';
//self.mail_v_city_name := '';
//self.mail_st := '';
//self.mail_zip := '';
//self.mail_ace_zip := '';
//self.mail_zip4 := '';
//self.work_phone := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));

export scramble_dl_searchv2 := dedup(sort(scrambled1,record),all);


