Import Data_Services, doxie,FLAccidents,lib_stringlib;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc6 := FLAccidents.basefile_flcrash6;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string12 did,
	unsigned1 did_score,
	string1   rec_type_6,
	string40  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  pedest_full_name,
	string16  filler2,
	string1   ped_name_suffix,
	string150  ped_st_city,
	string18  filler3,
	string2   ped_state,
	string9   ped_zip,
	string8   ded_dob,
	string1   ped_bac_test_type,
	string1   ped_bac_force_code,
	string2   ped_bac_results,
	string2   filler4,
	string1   ped_alco_drugs,
	string1   ped_physical_defect,
	string1   ped_residence,
	string1   ped_race,
	string1   ped_sex,
	string1   ped_injury_sev,
	string2   ped_first_contrib_cause,
	string2   ped_second_contrib_cause,
	string2   ped_third_contrib_cause,
	string2   ped_action,
	string8   first_offense_charged,
	string2   first_frdl_sys_charge_code,
	string8   second_offense_charged,
	string2   second_frdl_sys_charge_code,
	string8   third_offense_charged,
	string2   third_frdl_sys_charge_code,
	string7   first_citation_nbr,
	string7   second_citation_nbr,
	string7   third_citation_nbr,
	string2   ped_fr_injury_cap,
	string8   fourth_offense_charged,
	string2   fourth_frdl_sys_charge_code,
	string8   fifth_offense_charged,
	string2   fifth_frdl_sys_charge_code,
	string8   sixth_offense_charged,
	string2   sixth_sys_charge_code,
	string8   seventh_offense_charged,
	string2   seventh_sys_charge_code,
	string8   eighth_offense_charged,
	string2   eighth_sys_charge_code,
	string7   fourth_citation_issued,
	string7   fifth_citation_issued,
	string7   sixth_citation_issued,
	string7   seventh_citation_issued,
	string7   eighth_citation_issued,
	string15  ped_dl_nbr,
	string94  filler5,
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
	string40 orig_accnbr,
	string25 ped_race_desc,
  string8 ped_sex_desc,
  end;
xpnd_layout xpndrecs(flc6 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr := l.accident_nbr;
self.ded_dob := l.ded_dob[5..8]+l.ded_dob[1..4] ;
self.ped_race_desc := '';
self.ped_sex_desc := '';
self 								:= L;
end;

pflc6:= project(flc6,xpndrecs(left));

//ecrash 

ecrashFile := FLAccidents_Ecrash.BaseFile (StringLib.StringToUpperCase(trim(person_type)) in ['PEDALCYCLIST',
'PEDESTRIAN',
'PEDETRIAN',
'PEDISTRIAN']); 

xpnd_layout xpndecrash(ecrashFile L) := transform

  self.did							    := if(L.did = 0,'000000000000',intformat(L.did,12,1));
  self.rec_type_6						:= '6';
  t_accident_nbr 			      := if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
  t_scrub                   := stringlib.StringFilter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  self.accident_nbr         := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
  self.orig_accnbr          := t_accident_nbr;
  self.addr_suffix 				  := L.addr_suffix;
  self.ace_fips_st				  := L.county_code[1..2];
  self.county							  := L.county_code[3..5];
  self.zip							    := L.z5;
  self.zip4								  := L.z4;
  self.score 							  := L.name_score;
  self.suffix 						  := L.suffix;  
  self.cname                := l.cname; 
	self.pedest_full_name     := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
	self.ped_name_suffix      := if(trim(l.name_suffx,left,right) in ['N','NUL','NU'], '', l.name_suffx);
	self.ped_st_city          := trim(l.address,left,right)+' '+ trim(l.city,left,right); 
	self.ped_state            := l.state ; 
	self.ped_zip              := l.zip_code; 
	self.ded_dob              := l.date_of_birth; 
  self.ped_race_desc        := l.race;;
  self.ped_sex_desc         := l.sex;
	self.section_nbr          := if(l.vehicle_unit_number='NU','',l.vehicle_unit_number); 
  self                      := l; 
  self                      := []; 
end; 

pecrash := project(ecrashFile,xpndecrash(left));  
/*
// iyetek 
pieyetk := FLAccidents_Ecrash.BaseFile_Iyetek(StringLib.StringToUpperCase(trim(person_type)) in ['PEDALCYCLIST',
'PEDESTRIAN',
'PEDETRIAN',
'PEDISTRIAN']); 

xpnd_layout xpndiyetek(pieyetk L) := transform

self.rec_type_6         := '6';
t_scrub := stringlib.StringFilter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 
self.section_nbr := l.vehicle_unit_number; 
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	

self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.cname							:= l.cname;
  self.pedest_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
	self.ped_name_suffix := '';
	self.ped_st_city := trim(l.address,left,right)+' '+ trim(l.city,left,right); 
	self.ped_state := l.state ; 
	self.ped_zip := l.zip; 
	self.ded_dob  := l.date_of_birth; 
	
self := l; 
self := []; 
end; 

piyetek := project(pieyetk,xpndiyetek(left));  
*/
ptotal := dedup(pflc6+pecrash,all); 
export key_Ecrash6 := index(ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							,{ptotal}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash6_' + doxie.Version_SuperKey);