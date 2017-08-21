import demo_data;
import atf;

file_in := dataset('~thor::base::demo_data_file_atf_firearms_explosives_base_prodcopy',atf.layout_firearms_explosives_out,flat);

mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.premise_prim_range+' '+(string30)L.premise_prim_name+' '+(string3)L.premise_suffix;
//self.mail_street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,voice_phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dobs,				// DOB field name
		  true,best_ssn, 		//SSN field name
		  true,did_out,  		// DID field name
		  true,bdid,				// BDID field name
		  true,license1_fname,
		  true,license1_mname,
		  true,license1_lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,premise_v_city_name,
		  true,premise_st,
		  true,premise_zip,
		  true,premise_zip4,
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
clean_addr := fn.cleanAddress(L.street, L.premise_v_city_name+' '+L.premise_zip+' '+L.premise_zip4);
self.premise_prim_range := clean_addr[1..8];
self.premise_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.premise_p_city_name  := l.premise_v_city_name;
self.license_number	:= demo_data_scrambler.fn_scramblePII('CHARS',l.license_number);
self.Premise_Street := trim(l.premise_prim_range)+' '+trim(l.premise_prim_name);
self.Premise_City	:= l.premise_v_city_name;
self.Premise_State := l.premise_st;
self.Premise_orig_Zip := l.premise_zip;
self.license_Name := trim(l.license1_lname)+', '+trim(l.license1_fname)+' '+trim(l.license1_mname);

self.mail_Street := '';
self.mail_City	:= '';
self.mail_State := '';
self.mail_zip_code := '';
self.mail_prim_range := '';
self.mail_predir    := '';
self.mail_postdir    := '';
self.mail_prim_name  := '';
self.mail_sec_range  := '';
self.mail_unit_desig := '';
self.mail_suffix 	:= '';
self.mail_p_city_name := '';
self.mail_v_city_name := '';
self.mail_st := '';
self.mail_zip := '';
self.mail_zip4 := '';
self.Business_Name := 'FIREARMS ARE US';
self.Business_cname := 'FIREARMS ARE US';
//self.work_phone := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));

export scramble_atf_firearms_explosives_base := dedup(sort(scrambled1,record),all);
