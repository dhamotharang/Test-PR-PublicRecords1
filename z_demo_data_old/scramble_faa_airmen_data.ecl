import demo_data;
import faa;
#option('skipFileFormatCrcCheck', 1);
file_in:= dataset('~thor::base::demo_data_file_faa_airmen_data_prodcopy',faa.layout_airmen_data_out ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 xstreet;
END;

mod_file_rec addCleanName(file_in L):= transform
self.xstreet := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      // data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  false, cont_phone10,
		  false, x_DL_Number,   // dl_number field name
		  false, dob,		// DOB field name
		  true, best_ssn,	//SSN field name
		  true, did_out,  		// DID field name
		  false, bdid_out,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, param_bizName, // businessName Field
		  //
		  true, xstreet,
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
clean_addr := fn.cleanAddress(L.xstreet, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.orig_fname := l.fname;
self.orig_lname := l.lname;
self.street1 := trim(l.prim_range)+' '+TRIM(clean_addr[10..38],LEFT,RIGHT);
self.city := l.v_city_name;
self.state := l.st;
self.zip_code := '';
self.med_date:='072007';
self.med_exp_date:='072008';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));


export scramble_faa_airmen_data  := dedup(sort(scrambled1,record),all);
