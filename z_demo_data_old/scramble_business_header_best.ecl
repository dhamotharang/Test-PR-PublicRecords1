import demo_data;
import business_header;

file_in:= dataset('~thor::base::demo_data_file_business_header_best_prodcopy', business_header.Layout_BH_best,flat);
//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
string5 szip;
string4 szip4;
string12 sfein;
string10 sphone;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self.szip := (string) l.zip;
self.szip4 := (string) l.zip4;
self.sfein := (string) l.fein;
self.sphone := (string) l.phone;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, sphone,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  true, sfein,	//SSN field name
		  false, did,  		// DID field name
		  true, bdid,		// BDID field name
		  false, cont_fname,
		  false, cont_mname,
		  false, cont_lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, company_name, // businessName Field
		  //
		  true, street,
		  true, city,
		  true, state,
		  true, szip,
		  true, szip4,
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
file_in to_wrap_up(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.street, L.city+' '+L.szip+' '+L.szip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.fein := (integer) l.sfein;
self.zip := (integer) l.szip;
self.zip4 := (integer) l.szip4;
self.phone := (integer) l.sphone;
self := l;
end;

scrambled := project(scrambled_file, to_wrap_up(left));

export scramble_business_header_best := dedup(sort(scrambled,record),all);




