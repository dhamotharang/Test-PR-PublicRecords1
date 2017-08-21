import demo_data;
import corp2;

file_in:= demo_data_scrambler.scramble_corpdata;
//

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.corp_ra_prim_range+' '+(string30)L.corp_ra_prim_name+' '+(string3)L.corp_ra_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false, corp_phone_number,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  false, bdid,		// BDID field name
		  true, corp_ra_fname1,
		  true, corp_ra_mname1,
		  true, corp_ra_lname1,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, corp_ra_cname1, // businessName Field
		  //
		  true, street,
		  true, corp_ra_v_city_name,
		  true, corp_ra_state,
		  true, corp_ra_zip5,
		  true, corp_ra_zip4,
		  false, dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
//
file_in to_fix_more(scrambled_file l) := transform
scrambled_ra_cname := if(l.corp_ra_cname1<>'',demo_data_scrambler.fn_scrambleBizName(l.corp_ra_cname1),'');
clean_addr := fn.cleanAddress(L.street, L.corp_ra_v_city_name+' '+L.corp_ra_zip5+' '+L.corp_ra_zip4);
self.corp_ra_prim_range := clean_addr[1..8];
self.corp_ra_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.corp_ra_p_city_name := l.corp_ra_v_city_name;
self.corp_ra_fname2 := '';
self.corp_ra_mname2 := '';
self.corp_ra_lname2 := '';
self.corp_ra_name_suffix2 := '';
self.corp_ra_cname1 := scrambled_ra_cname,
self.corp_ra_cname2 := '';
self.corp_ra_name := if(scrambled_ra_cname<>'',scrambled_ra_cname,trim(l.corp_ra_fname1)+' '+trim(l.corp_ra_mname1)+' '+l.corp_ra_lname1);
self.corp_ra_address_line1 := trim(clean_addr[1..8])+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.corp_ra_address_line2 := trim(l.corp_ra_v_city_name)+' '+ l.corp_ra_state;
self.corp_ra_address_line3 := '';
self.corp_ra_address_line4 := '';
self.corp_ra_address_line5 := '';
self.corp_ra_address_line6 := '';
self.corp_ra_phone10:= '';
self := l;
end;

scrambled := project(scrambled_file, to_fix_more(left));

export scramble_corpdata2 := dedup(sort(scrambled,record),all);

