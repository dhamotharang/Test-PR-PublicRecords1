import demo_data;
import uccv2;

file_in:= dataset('~thor::base::demo_data_file_uccv2_party_base_prodcopy',uccv2.Layout_UCC_Common.layout_party,flat);



//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;

//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;

self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      		// data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,x_dl_Number ,   // dl_number field name
		  false,x_dob,		// DOB field name
		  true,ssn,	//SSN field name
		  true,did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,x_clean_name,	// cleanName field name
		  //
		  false,company_name, // businessName Field
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
scrambled_company_name := if(l.company_name<>'',demo_data_scrambler.fn_scrambleBizName(l.company_name),'');
sbdid := (string) l.bdid;
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip5+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name := l.v_city_name;
self.orig_name := if(scrambled_company_name<>'', scrambled_company_name, trim(l.lname)+', '+trim(l.fname)+' ' + l.mname);
self.duns_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.duns_number,'1','3'),'2','4');
self.hq_duns_number := '';
self.corp_number := '';
self.company_name := if(scrambled_company_name<>'', scrambled_company_name,'');
self.bdid :=  (integer) if(l.bdid<>0, demo_data_scrambler.fn_scramblePII('DID',sbdid),'');
self.Orig_address1:=trim( clean_addr[1..8])+ ' ' + TRIM(clean_addr[10..38],LEFT,RIGHT);
self.Orig_address2:='';
self.Orig_city:=l.v_city_name;
self.Orig_state:=l.st;
self.Orig_zip5:=l.zip5;
self.Orig_zip4:='';
self.orig_lname := l.lname;
self.orig_fname := l.fname;
self.orig_mname := l.mname;
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

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_uccv2_party_base := dedup(sort(scrambled1,record),all);