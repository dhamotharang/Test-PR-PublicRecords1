import demo_data;
import corp2;

file_in:= dataset('~thor::base::demo_data_file_corpdata_prodcopy',Corp2.Layout_Corporate_Direct_Corp_Base ,flat);
//

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.corp_addr1_prim_range+' '+(string30)L.corp_addr1_prim_name+' '+(string3)L.corp_addr1_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, corp_phone10,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  true, bdid,		// BDID field name
		  false, cont_fname,
		  false, cont_mname,
		  false, cont_lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, corp_legal_name, // businessName Field
		  //
		  true, street,
		  true, corp_addr1_v_city_name,
		  true, corp_addr1_state,
		  true, corp_addr1_zip5,
		  true, corp_addr1_zip4,
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
file_in to_fix_bdids(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.street, L.corp_addr1_v_city_name+' '+L.corp_addr1_zip5+' '+L.corp_addr1_zip4);
self.corp_addr1_prim_range := clean_addr[1..8];
self.corp_addr1_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.corp_addr1_p_city_name  := l.corp_addr1_v_city_name;
self.corp_address1_line1 := trim(clean_addr[1..8])+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.corp_address1_line2 := trim(l.corp_addr1_v_city_name)+' '+ l.corp_addr1_state;
self.corp_address1_line3 := '';
self.corp_address1_line4 := '';
self.corp_address1_line5 := '';
self.corp_address1_line6 := '';
//
self.corp_addr2_prim_range := '';
self.corp_addr2_prim_name := '';
self.corp_addr2_p_city_name := '';
self.corp_addr2_v_city_name := '';
self.corp_addr2_state := '';
self.corp_addr2_zip5 := '';
self.corp_addr2_zip4 := '';
//
self.corp_address2_line1 := '';
self.corp_address2_line2 := '';
self.corp_address2_line3 := '';
self.corp_address2_line4 := '';
self.corp_address2_line5 := '';
self.corp_address2_line6 := '';
//
self.corp_phone10:='';
//
//self.bdid := IF(l.bdid <> 0,(integer)fn_scramblePII('DID',(string)l.bdid),0);
/*-------------------------- JAYANT ADDITIONS ------------------------- */
self.corp_orig_sos_charter_nbr:=fn_scramblePII('SCR_SECOND',L.CORP_orig_sos_charter_nbr);
self.corp_sos_charter_nbr:=fn_scramblePII('SCR_SECOND',L.CoRP_sos_charter_nbr);
self.corp_status_date := fn_scramblePII('DOB',L.corp_status_date);
self.corp_inc_date := fn_scramblePII('DOB',L.corp_inc_date);
self.corp_forgn_date := fn_scramblePII('DOB',L.corp_forgn_date);
self.corp_forgn_fed_tax_id := fn_scramblePII('NUMBER',(string8)L.corp_forgn_fed_tax_id);
self.corp_forgn_state_tax_id := fn_scramblePII('NUMBER',(string8)L.corp_forgn_state_tax_id);
self.corp_filing_date := fn_scramblePII('DOB',L.corp_filing_date);
self.corp_fed_tax_id := fn_scramblePII('NUMBER',(string8)L.corp_fed_tax_id);
self.corp_state_tax_id := fn_scramblePII('NUMBER',(string8)L.corp_state_tax_id);

//----------------------------------------------------------------------
self := l;
end;

scrambled := project(scrambled_file, to_fix_bdids(left));

export scramble_corpdata  := dedup(sort(scrambled,record),all)  : persist('thor::persist::scramble_corp_data');

