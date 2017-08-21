import demo_data;
import faa;
#option('skipFileFormatCrcCheck', 1);
file_in:= dataset('~thor::base::demo_data_file_faa_aircraft_registration_prodcopy',{faa.layout_aircraft_registration_out, unsigned8 __fpos } ,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
faa.layout_aircraft_registration_out;
String100 xstreet;
END;

mod_file_rec addCleanName(file_in L):= transform
self.xstreet := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
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
		  true, bdid_out,		// BDID field name
		  true, fname,
		  true, mname,
		  true, lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  false, compname, // businessName Field
		  //
		  true, xstreet,
		  true, v_city_name,
		  true, st,
		  true, zip,
		  true, z4,
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
faa.layout_aircraft_registration_out reformat(scrambled_file L):= TRANSFORM
scrambled_compname := if(l.compname<>'', demo_data_scrambler.fn_scrambleBizName(l.compname),'');
clean_addr := fn.cleanAddress(L.xstreet, L.v_city_name+' '+L.zip+' '+L.z4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
//self.nameasis := '*** orig name, needs scrambling if displayed';
self.n_number :=stringlib.stringreverse(stringlib.stringfilter(l.n_number,'0123456789'))+stringlib.stringreverse(stringlib.stringfilter(l.n_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
self.serial_number := demo_data_scrambler.fn_scramblePII('SCR_FIRST',l.serial_number);
self.cert_issue_date := demo_data_scrambler.fn_scramblePII('DOB',l.cert_issue_date);
self.last_action_date := demo_data_scrambler.fn_scramblePII('DOB',l.last_action_date);
self.compname := if(scrambled_compname<>'', scrambled_compname,'');
self.name := if(scrambled_compname<>'', scrambled_compname,trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname));
self.street := trim(clean_addr[1..8])+' '+ TRIM(clean_addr[10..38],LEFT,RIGHT);
self.city :=l.v_city_name;
self.zip_code := l.zip;

self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_faa_aircraft_registration  := dedup(sort(scrambled1,record),all);

