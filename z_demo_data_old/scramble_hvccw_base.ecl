import demo_data;
import emerges;

// probably an input file named as "base" argh - ignore for now

file_in:= dataset('~thor::base::demo_data_file_hvccw_base_prodcopy', emerges.layout_emerge_in ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
//self.mail_street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  true,dob_str_in,		// DOB field name
		  true,best_ssn, 		//SSN field name
		  true,did_out,  		// DID field name
		  false,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,city_name,
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
clean_addr := fn.cleanAddress(L.street, L.city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.city_name;
self.mail_prim_range := '';
self.mail_predir    := '';
self.mail_postdir    := '';
self.mail_prim_name  := '';
self.mail_sec_range  := '';
self.mail_unit_desig := '';
self.mail_addr_suffix 	:= '';
self.mail_p_city_name := '';
self.mail_v_city_name := '';
self.mail_st := '';
self.mail_zip := '';
self.mail_ace_zip := '';
self.mail_zip4 := '';
self.work_phone := '';
self.lname_in := l.lname;
self.fname_in := l.fname;
self.mname_in := l.mname;
self.maiden_prior := '';
self.regdate_in := fn_scramblePII('DOB',L.regdate_in);
self.datelicense_in := fn_scramblePII('DOB',L.datelicense_in);
self.lastdayvote_in := fn_scramblePII('DOB',L.lastdayvote_in);
self.regexpdate_in := fn_scramblePII('DOB',L.regexpdate_in);
self.ccwregdate_in := fn_scramblePII('DOB',L.ccwregdate_in);
self.ccwexpdate_in := fn_scramblePII('DOB',L.ccwexpdate_in);
self.dateofcontr_in := fn_scramblePII('DOB',L.dateofcontr_in);
self.resaddr1 := '';
self.resaddr2 := '';
self.res_city := '';
self.mail_addr1 := '';
self.mail_addr2 := '';
self.mail_city := '';

/*---------------------------------  JAYANTS CHANGES -------------------  */
self.huntfishperm := if(L.huntfishperm <> '', (string)hash(L.huntfishperm)[1..6],'');
self.dob_str  := fn_scramblePII('DOB',L.dob_str);
self.lastdayvote := fn_scramblePII('DOB',L.lastdayvote);
self.datelicense := fn_scramblePII('DOB',L.datelicense);
self.regdate := fn_scramblePII('DOB',L.regdate);
self.regexpdate := fn_scramblePII('DOB',L.regexpdate);
self.ccwregdate  := fn_scramblePII('DOB',l.ccwregdate);
self.ccwexpdate  := fn_scramblePII('DOB',l.ccwexpdate);
self.dateofcontr := fn_scramblePII('DOB',l.dateofcontr);

//----------------------------------------------------------------------
self:=l;
END;

scrambled1 := dedup(sort(project(scrambled_file,reformat(left)),record),all);

export scramble_hvccw_base := scrambled1;