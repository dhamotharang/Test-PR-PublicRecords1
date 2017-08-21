
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_5610_prodcopy',ebr.layout_5610_demographic_data_Base,flat);
//
mod_file_rec := record
recordof(file_in);
string streetx := '';
string city := '';
string st := '';
string zip :='';
string zip4 := '';
string20 fname := ''; // l.clean_officer_name.fname;
string20 mname := '';	//l.clean_officer_name.mname;
string20 lname := '';	//l.clean_officer_name.lname;
end;

mod_file_rec adddummy(file_in L):= transform
self.fname := l.clean_officer_name.fname;
self.mname := l.clean_officer_name.mname;
self.lname := l.clean_officer_name.lname;
self:=l;
END;
mod_file_in := project(file_in,adddummy(left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true, corp_phone,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, ssn,	//SSN field name
		  true, did,  		// DID field name
		  true, bdid,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, corp_name, // businessName Field
		  //
		  true, streetx,
		  true, city,
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

file_in to_finish(scrambled_file l) := transform
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self.ssn := 0;
self.corp_name := '';
self.corp_phone := '';
self.corp_city := '';
self.clean_officer_name.fname := l.fname;
self.clean_officer_name.mname	:= l.mname;
self.clean_officer_name.lname := l.lname;
self.OFFICER_FIRST_NAME := l.fname;
self.OFFICER_M_I := l.mname;
self.OFFICER_LAST_NAME := l.lname;
self := l;
end;

scrambled := project(scrambled_file, to_finish(left));

export scramble_ebr_5610  := scrambled; 

