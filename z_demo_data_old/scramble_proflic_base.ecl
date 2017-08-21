import demo_data;
import prof_licensev2;

file_in:= dataset('~thor::base::demo_data_file_proflic_base_prodcopy',Prof_LicenseV2.layouts_ProfLic.Layout_Base_with_tiers,flat);

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
		  true,phone,
		  false,dl_number ,   // dl_number field name
		
		  true,dob,		// DOB field name
		  true,best_ssn, 		//SSN field name
		  true,did,  		// DID field name
		  true,bdid,		// BDID field name
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
/*-----------------------  JAYANTS ADDED FUNCTION FOR LICENSES  ----------------------------  */
string scr_LicenseNbr(string lic) := FUNCTION
//license numbers are hyphenated numbers -- optionally e.g 123345 or 12345-89900
//we will split and scramble both separately
hyphenpos:=StringLib.StringFind(lic,'-',1) ;
l_part := IF(hyphenpos > 0, lic[1..hyphenpos-1],lic);
r_part := IF(hyphenpos > 0, lic[hyphenpos+1..length(lic)],'');
scr_lic:= (string)hash(l_part)[1..8]+IF(hyphenpos >0, '-'+(string)hash(r_part)[1..6],'');
return if(lic<>'',scr_lic,'');
END;
//----------------------------------------------------------------------
recordof(file_in) reformat(scrambled_file L):= TRANSFORM
scrambled_company_name := if(l.company_name<>'', demo_data_scrambler.fn_scrambleBizName(l.company_name),'');
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.orig_name := '';
self.orig_addr_1 := '';
self.orig_addr_2 := '';
self.orig_addr_3 := '';
self.orig_addr_4 := '';
self.orig_city := '';
self.company_name := if (scrambled_company_name<>'',scrambled_company_name,'');

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
/*-----------------------  JAYANTS CHANGES  ----------------------------  */
self.license_number:=scr_licenseNbr(L.license_number);
self.orig_license_number:=scr_licenseNbr(L.orig_license_number);
self.previous_license_number:=scr_licenseNbr(L.previous_license_number);
self.issue_date := fn_scramblePII('DOB',L.issue_date);
self.expiration_date := fn_scramblePII('DOB',L.expiration_date);


/*---------------------------------------------------------------------   */
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_proflic_base := dedup(sort(scrambled1,record),all);
