import demo_data;
import ln_propertyv2;

file_in:= dataset('~thor::base::demo_data_file_ln_propertyv2_file_search_did_prodcopy',LN_PropertyV2.Layout_DID_Out,flat);
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
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, phone_number,
		  false, x_DL_Number,   // dl_number field name
		  false, x_dob,		// DOB field name
		  true, app_ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, param_bizName, // businessName Field
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
scrambled_cname := if(l.cname<>'', demo_data_scrambler.fn_scrambleBizName(l.cname),'');
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.app_tax_id := '';
self.nameasis := if(scrambled_cname='',trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname)+' '+trim(l.name_suffix),scrambled_cname);
self.cname := if(scrambled_cname<>'', scrambled_cname,'');
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_ln_propertyv2_file_search_did := dedup(sort(scrambled1(vendor_source_flag='O'),record),all) : persist('thor::persist::scramble_ln_propertyv2_file_search_did');