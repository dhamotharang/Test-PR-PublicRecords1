import demo_data;
import header;

file_in:= dataset('~thor::base::demo_data_file_did_death_masterv2_prodcopy',header.Layout_Did_Death_MasterV2 ,flat);


//Lets add clean Name field 
mod_file_rec:=RECORD
recordof(file_in);
String73 clean_name;
string v_city_name;
END;

mod_file_rec addCleanName(file_in L):= transform
self.clean_name:=fn.cleanName(L.fname+' '+L.mname+' '+L.lname);
self.v_city_name:='';
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));
//

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,param_phone,
		  false,gi_dl_num ,  			// dl_number field name
		  true, dob8,			// DOB field name
		  true,ssn, 		//SSN field name
		  true,did,  			// DID field name
		  false,param_BDID ,// BDID field name
		  false,fname,
		  false,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businesName Field
		  //
		  false,param_street,
		  true,v_city_name,
		  false,param_st,
		  false,param_zip5,
		  false,param_zip4,
		  false,dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);


recordof(file_in) reformat(scrambled_file L):= TRANSFORM
self.state_death_id := 'X'+stringlib.stringfindreplace(stringlib.stringfindreplace(l.state_death_id,'1','3'),'4','5');
self.dod8 := demo_data_scrambler.fn_scramblePII('DOB',l.dod8);
self:=l;
END;

export scramble_death_masterv2 := dedup(sort(project(scrambled_file,reformat(LEFT)),record),all);

