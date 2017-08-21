import demo_data;
import corrections;

file_in:= dataset('~thor::base::demo_data_file_offenders_keybuilding_prodcopy', corrections.layout_offender,flat);


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
self.dob_alias	:= '';
self.fbi_num	:= '';

self.street_address_1 := trim(clean_addr[1..8])+ ' '+ TRIM(clean_addr[10..38],LEFT,RIGHT);
self.street_address_2 := l.v_city_name + ', '+clean_addr[115..116];
self.street_address_3 := '';
self.street_address_4 := '';
self.street_address_5 := '';
 
/*---------------------------------- JAYANTS ADDITIONS ----------------- */
self.case_num   := fn_scramblePII('SCR_SECOND',L.case_num);//scramble 2nd number in casenum
self.case_date	:= fn_scramblePII('DOB',l.case_date);
self.id_num  := fn_scramblePII('CHARS',l.id_num);
self.doc_num  := fn_scramblePII('CHARS',l.doc_num);
self.pty_nm	:= trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname);
//----------------------------------------------------------------------
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_offenders_keybuilding  := dedup(sort(scrambled1,record),all);

