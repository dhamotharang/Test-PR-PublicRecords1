import demo_data;
import busreg;

file_in:= dataset('~thor::base::demo_data_file_busreg_contact_prodcopy',busreg.Layout_BusReg_Contact,flat);
//

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
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
		  false, cont_dob,		// DOB field name
		  true, ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, name_first,
		  true, name_middle,
		  true, name_last,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, corp_legal_name, // businessName Field
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
//
file_in to_cleanup(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.fein := demo_data_scrambler.fn_scramblepii('SSN',l.fein);
self.name := trim(l.name_first)+' '+trim(l.name_middle)+' '+trim(l.name_last);
self.add := '';
self.csz := '';
self := l;
end;

scrambled := project(scrambled_file, to_cleanup(left));

export scramble_busreg_contact  := dedup(sort(scrambled,record),all); 