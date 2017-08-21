import demo_data;
import gong;

//file_in:=demo_data.base_files.file_gongbase;
file_in:= dataset('~thor::base::demo_data_file_gongbase_prodcopy',Gong.layout_gong ,flat);

//Lets add standard clean Name and clean address fields 
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));
//
//output(file_in);// for comparison 

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,phoneno,
		  false,gi_dl_num ,  			// dl_number field name
		  false, dob8,			// DOB field name
		  false,ssn, 		//SSN field name
		  false,did,  			// DID field name
		  false,param_BDID ,// BDID field name
		  true,name_first,
		  true,name_middle,
		  true,name_last,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businesName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,z5,
		  true,z4,
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
scrambled_company_name  := if(l.company_name<>'',demo_data_scrambler.fn_scrambleBizName(l.company_name),'');
//
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.z5+' '+L.z4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name := L.v_city_name;
self.company_name := if(scrambled_company_name<>'', scrambled_company_name, trim(l.name_last)+' '+trim(l.name_first)+' '+trim(l.name_middle));
self:=l;
END;


//
export scramble_gong := dedup(sort(project(scrambled_file(phoneno<>''), reformat(LEFT)),record),all);