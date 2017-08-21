import demo_data;
import sexoffender;

file_in:= dataset('~thor::base::demo_data_file_so_main_prodcopy',sexoffender.layout_out_main,flat);
//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
//self.mail_street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  true,dob,		// DOB field name
		  true,ssn_appended, 		//SSN field name
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
self.dob_aka	:= '';
self.fbi_number	:= '';
self.ncic_number	:= '';
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
/* -----------------------  Jayant Adds --------------------  */
self.offender_id := fn_scramblePII('NUMBER',(string8)l.offender_id);
self.doc_number:= fn_scramblePII('NUMBER',(string8)l.doc_number);
self.sor_number:= fn_scramblePII('NUMBER',(string8)l.sor_number);
self.orig_veh_plate_1:= fn_scramblePII('PLATE',l.orig_veh_plate_1);
self.orig_veh_plate_2:= fn_scramblePII('PLATE',l.orig_veh_plate_2);
self.reg_date_1 := fn_scramblePII('DOB',l.reg_date_1);
self.reg_date_2 := fn_scramblePII('DOB',l.reg_date_2);
self.reg_date_3 := fn_scramblePII('DOB',l.reg_date_3);
self.name_orig := trim(l.fname)+' '+' '+trim(l.mname)+' '+trim(l.lname)+' '+l.name_suffix;
self.registration_address_1 := trim(clean_addr[1..8]) +' '+trim(TRIM(clean_addr[10..38],LEFT,RIGHT));;
self.registration_address_2 := trim(l.v_city_name)+ ', '+l.st;
self.registration_address_3 := l.zip5;
self.registration_address_4 := '';
self.registration_address_5 := '';
self.employer_address_1 := '';
self.employer_address_2 := '';
self.employer_address_3 := '';
self.employer_address_4 := '';
self.employer_address_5 := '';
self.school_address_1 := '';
self.school_address_2 := '';
self.school_address_3 := '';
self.school_address_4 := '';
self.school_address_5 := '';
/* ---------------------------------------------------------  */
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_so_main := dedup(sort(scrambled1,record),all);
