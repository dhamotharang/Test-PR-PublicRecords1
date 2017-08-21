import _control,civil_court;

file_in_all := dataset('~thor::base::demo_data_file_civil_party_prodcopy',civil_court.Layout_Roxie_Party,flat);

file_in := file_in_all(case_title='' and state_origin='MI');

rs(string sval) := function
sep := if(sval<>'','/','');
return sep;
end;

mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;
mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range1+' '+(string30)L.prim_name1+' '+(string3)L.addr_suffix1;
self:=l;
END;
mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in,      		// data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  false,app_ssn, //SSN field name
		  false,did,  		// DID field name
		  false,bdid,		// BDID field name
		  false,fname,
		  false,mname,
		  false,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,v_city_name1,
		  true,st1,
		  true,zip1,
		  true,zip41,
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name1+' '+L.zip1+' '+L.zip41);
// clean_cityname := if(l.v_city_name1<>'HAPPYPARK',l.v_city_name1,'');
// clean_zip := if(l.zip1='00000','',l.zip1);
clean_cityname := l.v_city_name1;
clean_zip			:= l.zip1;

scrambled_e1_lname1	:= if(l.e1_lname1<>'',demo_data_scrambler.fn_scrambleLastName(l.e1_lname1),'');
scrambled_e1_lname2	:= if(l.e1_lname2<>'',demo_data_scrambler.fn_scrambleLastName(l.e1_lname2),'');
scrambled_e1_lname3  := if(l.e1_lname3<>'',demo_data_scrambler.fn_scrambleLastName(l.e1_lname3),'');
scrambled_e1_lname4	:= if(l.e1_lname4<>'',demo_data_scrambler.fn_scrambleLastName(l.e1_lname4),'');
scrambled_e1_lname5	:= if(l.e1_lname5<>'',demo_data_scrambler.fn_scrambleLastName(l.e1_lname5),'');
//
scrambled_e1_pname1	:= trim(l.e1_fname1)+' '+trim(l.e1_mname1)+' '+trim(scrambled_e1_lname1);
scrambled_e1_pname2	:= trim(l.e1_fname2)+' '+trim(l.e1_mname2)+' '+trim(scrambled_e1_lname2);
scrambled_e1_pname3	:= trim(l.e1_fname3)+' '+trim(l.e1_mname3)+' '+trim(scrambled_e1_lname3);
scrambled_e1_pname4	:= trim(l.e1_fname4)+' '+trim(l.e1_mname4)+' '+trim(scrambled_e1_lname4);
scrambled_e1_pname5	:= trim(l.e1_fname5)+' '+trim(l.e1_mname5)+' '+trim(scrambled_e1_lname5);
//
scrambled_e1_cname1 := if(l.e1_cname1<>'',demo_data_scrambler.fn_scrambleBizName(l.e1_cname1),'');
scrambled_e1_cname2 := if(l.e1_cname2<>'',demo_data_scrambler.fn_scrambleBizName(l.e1_cname2),'');
scrambled_e1_cname3 := if(l.e1_cname3<>'',demo_data_scrambler.fn_scrambleBizName(l.e1_cname3),'');
scrambled_e1_cname4 := if(l.e1_cname4<>'',demo_data_scrambler.fn_scrambleBizName(l.e1_cname4),'');
scrambled_e1_cname5 := if(l.e1_cname5<>'',demo_data_scrambler.fn_scrambleBizName(l.e1_cname5),'');
//

scrambled_e2_lname1	:= if(l.e2_lname1<>'',demo_data_scrambler.fn_scrambleLastName(l.e2_lname1),'');
scrambled_e2_lname2	:= if(l.e2_lname2<>'',demo_data_scrambler.fn_scrambleLastName(l.e2_lname2),'');
scrambled_e2_lname3  := if(l.e2_lname3<>'',demo_data_scrambler.fn_scrambleLastName(l.e2_lname3),'');
scrambled_e2_lname4	:= if(l.e2_lname4<>'',demo_data_scrambler.fn_scrambleLastName(l.e2_lname4),'');
scrambled_e2_lname5	:= if(l.e2_lname5<>'',demo_data_scrambler.fn_scrambleLastName(l.e2_lname5),'');
//
scrambled_e2_pname1	:= trim(l.e2_fname1)+' '+trim(l.e2_mname1)+' '+trim(scrambled_e2_lname1);
scrambled_e2_pname2	:= trim(l.e2_fname2)+' '+trim(l.e2_mname2)+' '+trim(scrambled_e2_lname2);
scrambled_e2_pname3	:= trim(l.e2_fname3)+' '+trim(l.e2_mname3)+' '+trim(scrambled_e2_lname3);
scrambled_e2_pname4	:= trim(l.e2_fname4)+' '+trim(l.e2_mname4)+' '+trim(scrambled_e2_lname4);
scrambled_e2_pname5	:= trim(l.e2_fname5)+' '+trim(l.e2_mname5)+' '+trim(scrambled_e2_lname5);
//
scrambled_e2_cname1 := if(l.e2_cname1<>'',demo_data_scrambler.fn_scrambleBizName(l.e2_cname1),'');
scrambled_e2_cname2 := if(l.e2_cname2<>'',demo_data_scrambler.fn_scrambleBizName(l.e2_cname2),'');
scrambled_e2_cname3 := if(l.e2_cname3<>'',demo_data_scrambler.fn_scrambleBizName(l.e2_cname3),'');
scrambled_e2_cname4 := if(l.e2_cname4<>'',demo_data_scrambler.fn_scrambleBizName(l.e2_cname4),'');
scrambled_e2_cname5 := if(l.e2_cname5<>'',demo_data_scrambler.fn_scrambleBizName(l.e2_cname5),'');
//
self.case_number := 'X'+stringlib.stringfindreplace(l.case_number[2..],'1','2');
self.case_title := '';
//
self.e1_lname1 := scrambled_e1_lname1;
self.e1_lname2 := scrambled_e1_lname2;
self.e1_lname3 := scrambled_e1_lname3;
self.e1_lname4 := scrambled_e1_lname4;
self.e1_lname5 := scrambled_e1_lname5;
//
self.e1_cname1 := scrambled_e1_cname1;
self.e1_cname2 := scrambled_e1_cname2;
self.e1_cname3 := scrambled_e1_cname3;
self.e1_cname4 := scrambled_e1_cname4;
self.e1_cname5 := scrambled_e1_cname5;
//
self.e2_lname1 := scrambled_e2_lname1;
self.e2_lname2 := scrambled_e2_lname2;
self.e2_lname3 := scrambled_e2_lname3;
self.e2_lname4 := scrambled_e2_lname4;
self.e2_lname5 := scrambled_e2_lname5;
//
self.e2_cname1 := scrambled_e2_cname1;
self.e2_cname2 := scrambled_e2_cname2;
self.e2_cname3 := scrambled_e2_cname3;
self.e2_cname4 := scrambled_e2_cname4;
self.e2_cname5 := scrambled_e2_cname5;

self.entity_1_address_1:=trim(clean_addr[1..8]) +' '+ TRIM(clean_addr[10..38],LEFT,RIGHT);
self.entity_1_address_2:='';
self.entity_1_address_3:= trim(clean_cityname)+' '+l.st1+' '+clean_zip;
self.entity_1_address_4:= '';
self.v_city_name1 := clean_cityname;
self.p_city_name1 := clean_cityname;
self.zip1 := clean_zip;
self.prim_name1 := clean_addr[10..38];
//
self.entity_2_address_1 := '';
self.entity_2_address_2 := '';
self.entity_2_address_3 := '';
self.entity_2_address_4 := '';
//
self.prim_range2 := '';
self.predir2:= '';
self.prim_name2:= '';
self.addr_suffix2:= '';
self.postdir2:= '';
self.unit_desig2:= '';
self.sec_range2:= '';
self.p_city_name2:= '';
self.v_city_name2:= '';
self.st2:= '';
self.zip2:= '';
//
self.entity_1:= trim(trim(scrambled_e1_cname1)+rs(scrambled_e1_cname2)+trim(scrambled_e1_cname2)+rs(scrambled_e1_cname3)+trim(scrambled_e1_cname3)+rs(scrambled_e1_cname4)+trim(scrambled_e1_cname4)+rs(scrambled_e1_cname5)+trim(scrambled_e1_cname5)+
                     trim(scrambled_e1_pname1)+rs(scrambled_e1_pname2)+trim(scrambled_e1_pname2)+rs(scrambled_e1_pname3)+trim(scrambled_e1_pname3)+rs(scrambled_e1_pname4)+trim(scrambled_e1_pname4)+rs(scrambled_e1_pname5)+trim(scrambled_e1_pname5));
self.entity_1_dob := demo_data_scrambler.fn_scramblePII('DOB',l.entity_1_dob);
//
self.primary_entity_2
								  := trim(trim(scrambled_e2_cname2)+rs(scrambled_e2_cname2)+trim(scrambled_e2_cname2)+rs(scrambled_e2_cname3)+trim(scrambled_e2_cname3)+rs(scrambled_e2_cname4)+trim(scrambled_e2_cname4)+rs(scrambled_e2_cname5)+trim(scrambled_e2_cname5)+
                          trim(scrambled_e2_pname2)+rs(scrambled_e2_pname2)+trim(scrambled_e2_pname2)+rs(scrambled_e2_pname3)+trim(scrambled_e2_pname3)+rs(scrambled_e2_pname4)+trim(scrambled_e2_pname4)+rs(scrambled_e2_pname5)+trim(scrambled_e2_pname5));
self.entity_2_dob := demo_data_scrambler.fn_scramblePII('DOB',l.entity_2_dob);
//
self:=l;
END;

export scramble_civil_party :=  dedup(sort(project(scrambled_file,reformat(LEFT)),record),all);

