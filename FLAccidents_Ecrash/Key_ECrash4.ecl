Import Data_Services, doxie,FLAccidents;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
flc4 := FLAccidents.flc4_Keybuild;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string22  vehicle_id_nbr,
	string4   vehicle_year,
	string4   vehicle_make,
	string20  make_description,
	string20  model_description,
	string25 vehicle_incident_city;
	string2 vehicle_incident_st;
	string15  point_of_impact,
	string40 carrier_name;
	string5	client_type_id;
 	string12 did,
	unsigned1 did_score,
	string1   rec_type_4,
	string40  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  driver_full_name,
	string16  filler2, 
	string1   driver_name_suffix,
	string150  driver_st_city,
	string18  filler3,
	string2   driver_resident_state,
	string9   driver_zip,
	string8   driver_dob,
	string1   driver_dl_force_asterisk,
	string15  driver_dl_nbr,
	string2   driver_lic_st,
	string1   driver_lic_type,
	string1   driver_bac_test_type,
	string1   driver_bac_force_code,
	string2   driver_bac_test_results,
	string2   filler4,
	string1   driver_alco_drug_code,
	string1   driver_physical_defects,
	string1   driver_residence,
	string1   driver_race,
	string1   driver_sex,
	string1   driver_injury_severity,
	string1   first_driver_safety,
	string1   second_driver_safety,
	string1   driver_eject_code,
	string1   recommand_reexam,
	string10  driver_phone_nbr,
	string2   first_contrib_cause,
	string2   second_contrib_cause,
	string2   third_contrib_cause,
	string8   first_offense_charged,
	string2   first_frdl_sys_charge_code,
	string8   second_offense_charged,
	string2   second_frdl_sys_charge_code,
	string8   third_offense_charged,
	string2   third_frdl_sys_charge_code,
	string7   first_citation_nbr,
	string7   second_citation_nbr,
	string7   third_citation_nbr,
	string2   driver_fr_injury_cap_code,
	string1   dl_nbr_good_bad,
	string8   fourth_offense_charged,
	string2   fourth_frdl_sys_charge_code,
	string8   fifth_offense_charged,
	string2   fifth_frdl_sys_charge_code,
	string8   sixth_offense_charged,
	string2   sixth_frdl_sys_charge_code,
	string8   seveth_offense_charged,
	string2   seveth_frdl_sys_charge_code,
	string8   eighth_offense_charged,
	string2   eighth_frdl_sys_charge_code,
	string7   fourth_citation_nbr,
	string7   fifth_citation_nbr,
	string7   sixth_citation_nbr,
	string7   seventh_citation_nbr,
	string7   eighth_citation_nbr,
	string1   req_endorsement,
	string25  oos_dl_nbr,
	string51  filler5,//claim_nbr
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  p_city_name,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
	string4   cart,
	string1   cr_sort_sz,
	string4   lot,
	string1   lot_order,
	string2   dpbc,
	string1   chk_digit,
	string2   rec_type,
	string2   ace_fips_st,
	string3   county,
	string10  geo_lat,
	string11  geo_long,
	string4   msa,
	string7   geo_blk,
	string1   geo_match,
	string4   err_stat,
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   suffix,
	string3   score,
	string25  cname,
	string40  orig_accnbr, 
	string25 driver_race_desc,
  string8 driver_sex_desc,
  string40 driver_residence_desc ,
	string41  ins_company_name:= '';	
	string25  ins_policy_nbr:='';	
/*string30 Policy_num;	   
  string8 Policy_Effective_Date;	   
	string8 Policy_Expiration_Date;	
	string9 inquiry_ssn,
	string8 inquiry_dob,
	string20 inquiry_mname,
	string5 inquiry_zip5,
	string4 inquiry_zip4*/
  end;
xpnd_layout xpndrecs(flc4 L,FLAccidents.Key_FlCrash0 R) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.vehicle_id_nbr					:= '';
self.vehicle_year					:= '';
self.vehicle_make					:= '';
self.make_description				:= '';
self.model_description				:= '';
self.vehicle_incident_city			:= stringlib.stringtouppercase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
self.vehicle_incident_st			:= 'FL';
self.point_of_impact				:= '';
self.carrier_name					:= '';
self.client_type_id					:= '';
self.accident_nbr := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');  
self.orig_accnbr := l.accident_nbr; 
tdriver_dob := TRIM(l.driver_dob, LEFT, RIGHT);
self.driver_dob  := TRIM(TRIM(tdriver_dob[1..4], LEFT, RIGHT) + TRIM(tdriver_dob[5..8], LEFT, RIGHT), LEFT, RIGHT);
self.driver_race_desc :='';
self.driver_sex_desc :='';
self.driver_residence_desc  :='';
self 								:= L;
end;

pflc4 := join(distribute(flc4,hash(accident_nbr))
			  ,distribute(pull(FLAccidents.Key_FlCrash0),hash(accident_nbr))
			  ,left.accident_nbr = right.accident_nbr,
			   xpndrecs(left,right),left outer,local);


/////////////////////////////////////////////////////////////////
//Slim National file 
///////////////////////////////////////////////////////////////// 
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

pflc4 slimrec(ntlFile L) := transform
self.did					:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.rec_type_4 			:= '4';
t_accident_nbr 			:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
t_scrub := stringlib.StringFilter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.orig_accnbr := t_accident_nbr; 
//------------------------------------
//used for mobileTrac
self.vehicle_id_nbr					:= if(L.vehVin !=''
										,L.vehVin
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.vin,''));
self.vehicle_year					:=if(L.vehYear !=''
										,L.vehYear
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.year,''));	
self.vehicle_make					:=if(L.vehmake !=''
										,L.vehMake
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.make,''));
self.make_description				:= if(L.make_description != '',L.make_description,L.vehMake);
self.model_description				:= if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city	        := L.inc_city;
self.vehicle_incident_st			:= L.state_abbr;
self.point_of_impact				:= L.impact_location;
//------------------------------------
self.section_nbr			:=  L.vehicle_nbr;
self.driver_full_name       := map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_1
										  ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_2
										  ,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => L.LAST_NAME  +' '+L.FIRST_NAME+' '+L.MIDDLE_NAME_3
										  ,'');
self.driver_st_city			:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.city,'');
									
self.driver_resident_state 	:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.state,'');
self.driver_zip  			:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.zip5,'');
self.driver_dob    			:= TRIM(L.dob, LEFT, RIGHT);
self.driver_dl_nbr			:= if(L.pty_drivers_license !=''
										,L.pty_drivers_license
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
self.driver_lic_st			:= if(L.pty_drivers_license_st !=''
										,L.pty_drivers_license_st
										,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license_st,''));
self.driver_sex				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
self.addr_suffix 			:= L.suffix;
self.ace_fips_st			:= L.county_code[1..2];
self.county					:= L.county_code[3..5];
self.zip					:= L.zip5;
self.score 					:= L.name_score;
self.suffix 				:= L.name_suffix;
self.cname					:= stringlib.stringtouppercase(L.business_name);
self.carrier_name					:= L.LEGAL_NAME;
self.ins_company_name				:= L.LEGAL_NAME;
self.ins_policy_nbr					:= L.POLICY_NBR;
self						:= L;
self 						:= [];
end;

pntl := project(ntlFile(stringlib.stringtouppercase(party_type) in ['DRIVER', 'VEHICLE DRIVER']),slimrec(left));

/////////////////////////////////////////////////////////////////
//Slim National inquiry file 
///////////////////////////////////////////////////////////////// 
inqFile := FLAccidents_Ecrash.File_CRU_inquiries;

pflc4 slimrec3(inqFile L) := transform
self.report_code					:= 'I'+ L.report_code;
self.report_category				:= L.report_category;
self.report_code_desc				:= L.report_code_desc;
self.did					    := if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.rec_type_4 			:= '4';
t_accident_nbr := if(L.vehicle_incident_id[1..3] = 'OID',
													(string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													(string40)((unsigned6)L.vehicle_incident_id+10000000000));

t_scrub := stringlib.StringFilter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
self.orig_accnbr := t_accident_nbr; 
self.vehicle_id_nbr		:= L.Vin;
self.vehicle_year			:= L.Year;
self.vehicle_make			:= L.make;
self.make_description				:= if(L.make_description != '',L.make_description,L.Make);
self.model_description			:= if(L.model_description != '',L.model_description,L.Model);
self.vehicle_incident_city	:= '';
self.vehicle_incident_st		:= '';
self.point_of_impact				:= '';
//------------------------------------
self.section_nbr			      := L.vehicle_nbr;
self.driver_full_name       := L.LAST_NAME_1  +' '+L.FIRST_NAME_1+' '+L.MIDDLE_NAME_1;
self.driver_st_city			    := L.city;
									
self.driver_resident_state 	:= L.state;
self.driver_zip  			  := L.zip5;
self.driver_dob    			:= TRIM(L.dob_1, LEFT, RIGHT);
self.driver_dl_nbr			:= L.drivers_license;
self.driver_lic_st			:= L.drivers_license_st;
self.driver_sex				:= L.gender_1[1];
self.addr_suffix 			:= L.suffix;
self.ace_fips_st			:= L.county_code[1..2];
self.county					  := L.county_code[3..5];
self.zip					    := L.zip5;
self.score 					  := L.name_score;
self.suffix 				  := L.name_suffix;
self.cname					  := '';
self.filler5 					:= L.claim_nbr;
self.carrier_name     := L.legal_name;
self.ins_company_name				:= L.LEGAL_NAME;
self.ins_policy_nbr					:= '';
self						:= L;
self 						:= [];
end;

pinq := project(inqFile,slimrec3(left));

// ecrash 
ecrashFile := FLAccidents_Ecrash.BaseFile(stringlib.stringtouppercase(person_type) in ['VEHICLE DRIVER', 'DRIVER']); 

pflc4 slimecrash(ecrashFile L, unsigned1 cnt) := transform

self.vehicle_id_nbr  := if(L.Other_Unit_VIN !='',choose(cnt,L.vin,L.Other_Unit_VIN),L.vin);
year					              := trim(if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														if(L.model_year != '',L.model_year,L.model_yr)),left,right);																														
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
self.vehicle_make					  := if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.make_description				:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.model_description			:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_description != '',L.model_description,L.model),
																														if(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														if(L.model_description != '',L.model_description,L.model));
self.vehicle_incident_city	:= stringlib.stringtouppercase(L.Crash_City);
self.vehicle_incident_st		:= stringlib.stringtouppercase(L.Loss_State_Abbr);

self.point_of_impact := l.impact_area1 ; 
self.carrier_name     := L.Insurance_Company;
self.ins_company_name				:= L.Insurance_Company;
self.ins_policy_nbr := L.Insurance_Policy_Number;   
self.client_type_id := ''; 
self.rec_type_4 := '4'; 
t_accident_nbr 			:= if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := stringlib.StringFilter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.orig_accnbr := t_accident_nbr;
self.section_nbr := l.vehicle_unit_number; 
self.driver_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right); 
self.driver_name_suffix := if(l.name_suffx ='N', '',l.name_suffx) ;  
self.driver_st_city := trim(l.address,left,right) +' '+trim( l.city,left,right); 
self.driver_resident_state := l.state ;
self.driver_zip := l.zip_code; 
self.driver_dob := TRIM(l.date_of_birth, LEFT, RIGHT);
self.driver_dl_force_asterisk := ''; 
self.driver_dl_nbr := l.drivers_license_number;
self.driver_lic_st := L.drivers_license_jurisdiction; 
self.driver_lic_type :=''; 
self.driver_bac_test_type :=''; 
self.driver_bac_force_code :=''; 
self.driver_bac_test_results :=''; 
self.driver_alco_drug_code :=''; 
self.driver_physical_defects :=''; 
self.driver_residence :='';
self.driver_race :=''; 
self.driver_sex := '';
self.driver_race_desc := l.race; 
self.driver_sex_desc  := l.sex;
self.driver_residence_desc := l.driver_residence; 

self.driver_injury_severity :='';
self.first_driver_safety :='';
self.second_driver_safety:='';
self.driver_eject_code:='';
self.recommand_reexam:='';
self.driver_phone_nbr:='';
self.first_contrib_cause:='';
self.second_contrib_cause:='';
self.third_contrib_cause:='';
self.first_offense_charged:='';
self.first_frdl_sys_charge_code :='';
self.second_offense_charged :=''; 
self.second_frdl_sys_charge_code:=''; 
self.third_offense_charged :='';
self.third_frdl_sys_charge_code :='';
self.first_citation_nbr := l.citation_number1;
self.second_citation_nbr := l.citation_number2;
self.third_citation_nbr := '';
self.driver_fr_injury_cap_code :='';
self.dl_nbr_good_bad :='';
self.fourth_offense_charged :='';
self.fourth_frdl_sys_charge_code :='';
self.fifth_offense_charged :='';
self.fifth_frdl_sys_charge_code :='';
self.sixth_offense_charged :=''; 
self.sixth_frdl_sys_charge_code:=''; 
self.seveth_offense_charged:=''; 
self.seveth_frdl_sys_charge_code:=''; 
self.eighth_offense_charged:=''; 
self.eighth_frdl_sys_charge_code:=''; 
self.fourth_citation_nbr:=''; 
self.fifth_citation_nbr:='';
self.sixth_citation_nbr:='';
self.seventh_citation_nbr:='';
self.eighth_citation_nbr:='';
self.req_endorsement :=''; 
self.oos_dl_nbr:=''; 
self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.suffix 						:= L.suffix;  
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.cname              := l.cname; 

self := l; 
self := [];
end; 

pecrash := normalize(ecrashFile,2,slimecrash(left,counter));

//iyetek 

/*iyetekFile := FLAccidents_Ecrash.BaseFile_Iyetek(stringlib.stringtouppercase(person_type) in ['VEHICLE DRIVER', 'DRIVER']); 

pflc4 slimiyetek(iyetekFile L) := transform


self.vehicle_incident_city	:= stringlib.stringtouppercase(L.Crash_City);
self.vehicle_incident_st		:= stringlib.stringtouppercase(L.Loss_State_Abbr);
self.section_nbr := l.vehicle_unit_number; 
self.point_of_impact := l.impact_area1 ; 
self.carrier_name     := L.Insurance_Company;
self.ins_company_name				:= L.Insurance_Company;
self.ins_policy_nbr := L.Insurance_Policy_Number;  
self.client_type_id := ''; 
self.rec_type_4 := '4'; 
t_scrub := stringlib.StringFilter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number;
self.driver_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right); 
self.driver_st_city := trim(l.address,left,right) +' '+ trim(l.city,left,right); 
self.driver_resident_state := l.state ;
self.driver_zip := l.zip; 
self.driver_dob := l.date_of_birth;
self.driver_dl_nbr := l.drivers_license_number;
self.driver_lic_st := L.driver_license_jurisdiction; 
self.first_citation_nbr := l.citation_number1;
self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.cname							:= l.cname;
self.vehicle_id_nbr			:= L.vin;
year					              := trim(if(L.model_year != '',L.model_year,L.model_yr),left,right);				
																										
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
																	 
self.vehicle_make					  := if(L.make_description != '',L.make_description,L.make);
self := l; 
self := []; 
end; 

piyetek := project ( iyetekFile , slimiyetek(left)); 
*/

allrecs := dedup(pflc4+pntl+pinq+pecrash,record,all)
					 : persist('~thor_data400::persist::ecrash4');
					 
														
export Key_ECrash4 := index(allrecs
                            ,{string40 l_acc_nbr := accident_nbr}
							,{allrecs}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash4_' + doxie.Version_SuperKey);
						 	 
							