file_in := scramble_foreclosure2a;


//Add Fields to conform to Macro Interface Files
mod_file_rec2:=RECORD
recordof(file_in);
String100 street2;
END;
mod_file_rec2 addCleanName2(file_in L):= transform
self.street2 := (string8)L.situs2_prim_range+' '+(string30)L.situs2_prim_name+' '+(string3)L.situs2_addr_suffix;
self:=l;
END;
mod_file_in2:=PROJECT(file_in,addCleanName2(Left));
mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in2,      		// data set to be scrambled
      scrambled_file2, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  false,name2_ssn, 		//SSN field name
		  false,name2_did,  		// DID field name
		  false,name2_bdid,		// BDID field name
		  false,name2_first,
		  false,name2_middle,
		  false,name2_last,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street2,
		  true,situs2_v_city_name,
		  true,situs2_st,
		  true,situs2_zip,
		  true,situs2_zip4,
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
//
recordof(file_in) reformat2(scrambled_file2 L):= TRANSFORM
clean_addr := fn.cleanAddress(L.street2, L.situs2_v_city_name+' '+L.situs2_zip+' '+L.situs2_zip4);
self.situs2_prim_range := clean_addr[1..8];
self.situs2_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.situs2_p_city_name  := l.situs2_v_city_name;
self.situs_address_indicator_2 := '';
self.situs_house_number_prefix_2 :='';
self.situs_house_number_2 := clean_addr[1..8];
self.situs_house_number_suffix_2 := '';
self.situs_street_name_2 :=TRIM(clean_addr[10..38],LEFT,RIGHT);
self.situs_mode_2 := '';
self.situs_direction_2 := '';
self.apartment_unit_2 := l.apartment_unit_2;
self.property_city_2 := l.situs2_v_city_name;
self.property_state_2 := l.situs2_st;
self.property_address_zip_code_2:= l.situs2_zip4;
self.full_site_address_unparsed_2 := trim(clean_addr[1..8])+  ' ' + TRIM(clean_addr[10..38],LEFT,RIGHT);
self:=l;
END;

export scramble_foreclosure2b := project(scrambled_file2,reformat2(LEFT));



