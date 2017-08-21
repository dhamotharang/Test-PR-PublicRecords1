import demo_data;
import vehiclev2;

file_in:= dataset('~thor::base::demo_data_file_vehiclev2_party_prodcopy',vehiclev2.Layout_Base_Party,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;

//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.append_clean_address.prim_range+' '+(string30)L.append_clean_address.prim_name+' '+(string3)L.append_clean_address.addr_suffix;

self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      		// data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  true,Append_DL_Number ,   // dl_number field name
		  true,append_dob,		// DOB field name
		  true,append_ssn,	//SSN field name
		  true,append_did,  		// DID field name
		  true,append_bdid,		// BDID field name
		  true,Append_Clean_Name.fname,
		  true,Append_Clean_Name.mname,
		  true,Append_Clean_Name.lname,
		  false,append_clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,append_clean_address.v_city_name,
		  true,append_clean_address.st,
		  true,append_clean_address.zip5,
		  true,append_clean_address.zip4,
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
scrambled_cname := if(l.append_clean_cname<>'',demo_data_scrambler.fn_scrambleBizNameV2(l.append_clean_cname),'');
clean_addr := fn.cleanAddress(L.street, L.append_clean_address.v_city_name+' '+L.append_clean_address.zip5+' '+L.append_clean_address.zip4);
self.append_clean_address.prim_range := clean_addr[1..8];
self.append_clean_address.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
//
self.reg_first_date := fn_scramblePII('DOB',L.reg_first_date);
self.reg_earliest_effective_date := fn_scramblePII('DOB',L.reg_earliest_effective_date);
self.reg_latest_effective_date := fn_scramblePII('DOB',L.reg_latest_effective_date);
self.reg_latest_expiration_date := fn_scramblePII('DOB',L.reg_latest_expiration_date);
self.reg_decal_number := fn_scramblePII('NUMBER',(STRING8)L.reg_decal_number);
//
self.reg_true_license_plate := fn_scramblePII('PLATE',(STRING6)L.reg_true_license_plate);
self.reg_license_plate := fn_scramblePII('PLATE',(STRING6)L.reg_license_plate);
self.reg_previous_license_plate := fn_scramblePII('PLATE',(STRING6)L.reg_previous_license_plate);
//
self.ttl_number := fn_scramblePII('NUMBER',(STRING8)L.ttl_number);
self.ttl_earliest_issue_date := fn_scramblePII('DOB',L.ttl_earliest_issue_date);
self.ttl_latest_issue_date := fn_scramblePII('DOB',L.ttl_latest_issue_date);

self.orig_name := if(scrambled_cname='',trim(l.append_clean_name.fname)+' '+trim(l.append_clean_name.mname)+' '+trim(l.append_clean_name.lname),scrambled_cname);
self.orig_address := trim(clean_addr[1..8])+' '+trim(clean_addr[10..38],LEFT,RIGHT);
self.orig_city := l.append_clean_address.v_city_name;
self.append_clean_cname := scrambled_cname;

self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_vehiclev2_party := dedup(sort(scrambled1(source_code='AE'),record),all);