
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_5000_prodcopy',ebr.Layout_5000_Bank_Details_Base,flat);
//

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 streetx;
END;

mod_file_rec addCleanName(file_in L):= transform
self.streetx := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, telephone,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  true, bdid,		// BDID field name
		  false, ofc1_name_first,
		  false, ofc1_name_middle,
		  false, ofc1_name_last,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, bizname,  // businessName Field
		  //
		  true, streetx,
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
file_in to_finish(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.streetx, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.NAME := 'BIG COMPANY BANK';
self.street_address := trim(clean_addr[1..8])+' '+TRIM(clean_addr[10..38],LEFT,RIGHT)+' '+ l.addr_suffix;
self.city := l.v_city_name;
self.zip_code := '';
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self := l;
end;

scrambled := project(scrambled_file, to_finish(left));

export scramble_ebr_5000  := scrambled; 

