
import demo_data;
import daybatchpcnsr;

file_in:= dataset('~thor::base::demo_data_file_pcnsr_prodcopy',daybatchpcnsr.Layout_PCNSR,flat);

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
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,phone_fordid,
		  false,dl_number ,   // dl_number field name
		
		  false,dobs,		// DOB field name
		  false,ssn, 		//SSN field name
		  true,did,  		// DID field name
		  true,hhid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,zip,
		  true,zip4,
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.fname_orig := '';
self.mname_orig := '';
self.lname_orig := '';
self.name_suffix_orig := '';
self.title_orig:= '';
self.spouse_fname_orig := '';
self.spouse_mname_orig := '';
self.spouse_lname_orig := '';
self.spouse_name_suffix_orig := '';
self.spouse_title_orig:= '';
self.spouse_date_of_birth:= if(l.spouse_date_of_birth<>'',l.spouse_date_of_birth[1..4]+'01','');
self.date_of_birth:= if(l.date_of_birth<>'',l.date_of_birth[1..4]+'01','');
self.area_code := l.phone_fordid[1..3];
self.phone_number := l.phone_fordid[4..10];
self.phone2_number := demo_data_scrambler.fn_scramblepii('phone',l.phone2_number);
self.spouse_lname := if(l.spouse_lname<>'',l.lname,'');
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));

export scramble_pcnsr := dedup(sort(scrambled1,record),all);
