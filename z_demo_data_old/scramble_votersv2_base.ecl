import demo_data;
import votersv2;

file_in:= dataset('~thor::base::demo_data_file_votersv2_base_prodcopy',votersV2.Layouts_Voters.Layout_Voters_Base,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self.mail_street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,phone,
		  false,dl_number ,   // dl_number field name
		
		  true,dob,		// DOB field name
		  true,ssn, 		//SSN field name
		  true,did,  		// DID field name
		  false,bdid,		// BDID field name
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
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
self.last_name := l.lname;
self.middle_name := l.mname;
self.first_name := l.fname;
self.maiden_prior := '';
self.clean_maiden_pri := '';
self.maiden_name := '';
self.motorVoterId := demo_data_scrambler.fn_scramblepii('NUMBER',l.motorvoterid);
self.source_voterid := demo_data_scrambler.fn_scramblepii('NUMBER',l.source_voterid);
self.regsource:= demo_data_scrambler.fn_scramblepii('DOB',l.regsource);
self.regdate:= demo_data_scrambler.fn_scramblepii('DOB',l.regdate);
self.lastdatevote:= demo_data_scrambler.fn_scramblepii('DOB',l.lastdatevote);
self.res_addr1 := '';
self.res_addr2 := '';
self.res_city := '';
self.mail_addr1 := '';
self.mail_addr2 := '';
self.mail_city := '';
self:=l;
END;

scrambled1 := dedup(sort(project(scrambled_file,reformat(LEFT)),record),all);

export scramble_votersv2_base := scrambled1;

