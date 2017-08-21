import demo_data;
import patriot;

import demo_data;
import patriot;
import globalwatchlists;

file_in := dataset('~thor::base::demo_data_file_globalwatchlists_prodcopy',globalwatchlists.Layout_GlobalWatchLists,flat);


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
		  false,xphone,
		  false,xdl_number ,   // dl_number field name
		
		  false,xdobs,			// DOB field name
		  false,xssn, 		//SSN field name
		  false,xdid,  			// DID field name
		  false,xbdid,				// BDID field name
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
scrambled_cname := if(l.cname<>'', demo_data_scrambler.fn_scrambleBizName(l.cname),'');
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := '';	//	clean_addr[1..8];
self.prim_name  := '';	//	TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := '';	//if(l.v_city_name not in['HAPPYPARK','GREENBEACH','BARVALLEY','MALLLAKE'],l.v_city_name,'');
self.v_city_name  := '';	//if(l.v_city_name not in['HAPPYPARK','GREENBEACH','BARVALLEY','MALLLAKE'],l.v_city_name,'');
self.zip := 		'';	//if(l.zip<>'00000', l.zip,'');
self.addr_suffix := '';
self.predir := '';
self.postdir := '';
self.sec_range := '';
self.unit_desig:= '';
self.st := '';
self.orig_pty_name := trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname);
self.orig_vessel_name := '';
self.addr_1 := '';
self.addr_2 := '';
self.addr_3 := '';
self.addr_4 := '';
self.addr_5 := '';
self.addr_6 := '';
self.addr_7 := '';
self.addr_8 := '';
self.addr_9 := '';
self.addr_10 := '';
self.remarks_1 := if(stringlib.stringcontains(l.remarks_1,'BIRTH',true),'',l.remarks_1);
self.remarks_2 := '';
self.remarks_3 := '';
self.remarks_4 := '';
self.remarks_5 := '';
self.remarks_6 := '';
self.remarks_7 := '';
self.remarks_8 := '';
self.remarks_9 := '';
self.remarks_10 := '';
self.remarks_11 := '';
self.remarks_12 := '';
self.remarks_13 := '';
self.remarks_14 := '';
self.remarks_15 := '';
self.remarks_16 := '';
self.remarks_17 := '';
self.remarks_18 := '';
self.remarks_19 := '';
self.remarks_20 := '';
self.remarks_21 := '';
self.remarks_22 := '';
self.remarks_23 := '';
self.remarks_24 := '';
self.remarks_25 := '';
self.remarks_26 := '';
self.remarks_27 := '';
self.remarks_28 := '';
self.remarks_29 := '';
self.remarks_30 := '';
self.cname := if(scrambled_cname<>'',scrambled_cname,'');
self.first_name := l.fname;
self.last_name := l.lname;
self.address_line_1 := '';
self.address_line_2 := '';
self.address_line_3 := '';
self.address_city := '';
self.address_state_province := '';
self.address_postal_code := '';
self.dob_1 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_1);
self.dob_2 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_2);
self.dob_3 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_3);
self.dob_4 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_4);
self.dob_5 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_5);
self.dob_6 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_6);
self.dob_7 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_7);
self.dob_8 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_8);
self.dob_9 := demo_data_scrambler.fn_scramblePII('DOB',l.dob_9);
self.dob_10:= demo_data_scrambler.fn_scramblePII('DOB',l.dob_10);
self.linked_with_1 := '';
self.linked_with_2 := '';
self.linked_with_3 := '';
self.linked_with_4 := '';
self.linked_with_5 := '';
self.linked_with_6 := '';
self.linked_with_7 := '';
self.linked_with_8 := '';
self.linked_with_9 := '';
self.linked_with_10 := '';
self.ncic := '';
self.remarks := if(l.remarks<>'','General remarks about family tree, nature of offenses, etc.','');
self.entity_id := demo_data_scrambler.fn_scramblePII('CHARS',l.entity_id);
self.call_sign := if(l.call_sign<>'','CALL SIGN','');
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));

export scramble_globalwatchlists  :=dedup(sort(scrambled1,record),all);

