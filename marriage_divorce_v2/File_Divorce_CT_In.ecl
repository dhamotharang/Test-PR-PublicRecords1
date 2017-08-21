import ut;
ct_div_filter:=dataset('~thor_200::in::mar_div::ct::divorce', marriage_divorce_v2.Layout_Divorce_CT_In, flat,OPT);
 
 new_CT_layout := record
     string5 certnumber ;
		 string15 husbd_CL_name ;
		 string10 husbd_CF_name;
		 string1 husbd_CM_name;
		 string3 husbd_res_state_code;
		 string3 husbd_birth_state;
		 string1 husbd_res_county;
		 string1 husbd_birth_mth;
		 string4 husbd_birth_yr;
		 string1 husbd_race;
		 string2 husbd_age_mar;
     string2 husbd_age_div;
		 string1 husbd_time_married;
		 string1 husbd_prev_mar;
		 string10 wife_CF_name;
		 string3 wife_res_state_code;
		 string3 wife_birth_state;
		 string1 wife_res_county;
		 string1 wife_birth_month;
		 string4 wife_birth_yr;
		 string1 wife_race;
		 string2 wife_age_mar;
     string2 wife_age_div;
		 string1 wife_time_married;
		 string1 wife_prev_mar;
		 string3 marriage_state_code;
		 string4 date_of_marriage_year;
		 string1 date_of_marriage_month;		 
		 string2 living_child_under18;
		 string1 decree_dt_MM;
		 string2 decree_dt_DD;
		 string4 decree_dt_YYYY;
		 string1 type_of_decree;
		 string2 divorce_ground;
		 string6 court_doc_number;
		 string1 court_name;
		 
		 
end;

new_CT_layout Clean_CT(marriage_divorce_v2.Layout_Divorce_CT_In l) := TRANSFORM
Name1 := trim(l.husbd_name_last);
tempName1 := regexreplace('[0-9 !@#$%^&*()_=+{}|<>?,.-]+$',Name1,'');
Name2 := trim(l.husbd_name_first);
tempName2 := regexreplace('[0-9 !@#$%^&*()_=+{}|<>?,.-]+$',Name2,'');
Name3 := trim(l.husbd_name_middle);
tempName3 := regexreplace('[0-9 !@#$%^&*()_=+{}|<>?,.-]+$',Name3,'');
Name4 := trim(l.wife_name_first);
tempName4 := regexreplace('[0-9 !@#$%^&*()_=+{}|<>?,.-]+$',Name4,'');

self.husbd_CL_name := tempName1;
self.husbd_CF_name := tempName2;
self.husbd_CM_name := tempName3;
self.wife_CF_name := tempName4;


self := l;
end;
new_ct_ds:= project(ct_div_filter, Clean_CT(LEFT));



export File_Divorce_CT_In := new_ct_ds( (trim(husbd_CL_name)!='') and (trim(husbd_CF_name)!='') and trim(husbd_CM_name) != '' and trim(wife_CF_name) != ''); 