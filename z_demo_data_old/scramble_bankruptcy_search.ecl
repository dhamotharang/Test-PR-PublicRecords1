import demo_data;
import bankruptcyv2,_control;

fver := '20081113';

//file_in:= dataset('~thor::base::demo_data_file_bankruptcy_search_prodcopy',bankruptcyv2.layout_bankruptcy_search,flat);
file_in:= dataset('~foreign::'+_control.IPAddress.prod_thor_dali+'::'+'thor_200::base::demo_data_file_bankrtuptcy_search'+fver, bankruptcyv2.layout_bankruptcy_search ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, phone,
		  false, x_DL_Number,   // dl_number field name
		  false, dob,		// DOB field name
		  true, app_ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, cname, // businessName Field
		  //
		  true, street,
		  true, v_city_name,
		  true, st,
		  true, zip,
		  true, zip4,
		  false, dr_clean_address,// cleanAddress fieldname
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
scrambled_cname := stringlib.stringfindreplace(if(l.cname<>'',demo_data_scrambler.fn_scrambleBizNameV2(l.cname),''),' AT',' AND ASSOCIATES'); 
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
//
self.app_tax_id := demo_data_scrambler.fn_scramblePII('SSN',l.app_tax_id);
self.tax_id := demo_data_scrambler.fn_scramblePII('SSN',l.tax_id);
self.ssn := demo_data_scrambler.fn_scramblePII('SSN',l.ssn);
self.case_number := demo_data_scrambler.fn_scramblePII('CHARS',l.case_number);
self.orig_case_number := demo_data_scrambler.fn_scramblePII('CHARS',l.orig_case_number);
//
self.orig_fname:= l.fname;
self.orig_mname := l.mname;
self.orig_lname := l.lname;
self.orig_name_suffix := l.name_suffix;
//
self.orig_company := scrambled_cname;
self.cname := scrambled_cname;
self.orig_name := if(l.cname<>'',trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname),''); 
//
self.orig_addr1 := trim( clean_addr[1..8],left,right)+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.orig_addr2 := '';
self.orig_city := l.v_city_name;
self.orig_st := l.st; 
self.orig_zip5 := l.zip; 
self.orig_zip4 := '';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_bankruptcy_search := dedup(sort(scrambled1,record),all);
