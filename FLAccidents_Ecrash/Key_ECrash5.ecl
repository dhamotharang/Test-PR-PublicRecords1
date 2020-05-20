Import Data_Services, doxie, FLAccidents, lib_stringlib, STD;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc5 := FLAccidents.basefile_flcrash5;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
 	string12 did,
	unsigned1 did_score,
	string1   rec_type_5,
	string40  accident_nbr,
	string2   section_nbr,
	string2   passenger_nbr,
	string25  passenger_full_name,
	string16  filler1,
	string1   passenger_name_suffix,
	string150  passenger_st_city,
	string18  filler2,
	string2   passenger_state,
	string9   passenger_zip,
	string2   passenger_age,
	string1   passenger_location,
	string1   passenger_injury_sev,
	string1   first_passenger_safe,
	string1   second_passenger_safe,
	string1   passenger_eject_code,
	string2   passenger_fr_cap_code,
	string266 filler3,
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
  end;
xpnd_layout xpndrecs(flc5 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr := l.accident_nbr; 
self 								:= L;
end;

pflc5:= project(flc5,xpndrecs(left));

//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.
ecrashFile := eCrashBaseAgencyExclusion(STD.Str.ToUpperCase(trim(person_type)) in ['\\PASSENGER',
																																													 '3PASSENGER',
																																													 'ÃƒÂ¢?Ã‚Â¢THEY ENTERED: PASSENGER',
																																													 'BICYCLE',
																																													 'BICYCLIST',
																																													 'BYCICLIST',
																																													 'INJURED PASSENGER',
																																													 'OASSENGER',
																																													 'PAASENGER',
																																													 'PAS',
																																													 'PASEENGER',
																																													 'PASENGER',
																																													 'PASS',
																																													 'PASSANGER',
																																													 'PASSE',
																																													 'PASSEBGER',
																																													 'PASSEDNGER',
																																													 'PASSEENGER',
																																													 'PASSEGER',
																																													 'PASSEGNER',
																																													 'PASSEMGER',
																																													 'PASSENDER',
																																													 'PASSENEGER',
																																													 'PASSENEGR',
																																													 'PASSENER',
																																													 'PASSENGER',
																																													 'PASSENGER',
																																													 'PASSENGER1',
																																													 'PASSENGERA',
																																													 'PASSENGERJENNIFER',
																																													 'PASSENGERS',
																																													 'PASSENGERT',
																																													 'PASSENGFER',
																																													 'PASSENGR',
																																													 'PASSENJGER',
																																													 'PASSENNGER',
																																													 'PASSSENGER']); 

xpnd_layout xpndecrash(ecrashFile L) := transform

self.rec_type_5 := '5';
t_accident_nbr 			:= if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.orig_accnbr := t_accident_nbr;
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.section_nbr := l.vehicle_unit_number; 
self.passenger_nbr      := trim(l.passenger_number,left,right); 
self.passenger_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.passenger_name_suffix := if(trim(l.name_suffx,left,right) ='N','',l.name_suffx);
self.passenger_st_city := trim(l.address,left,right) +' '+ trim(l.city,left,right); 
self.passenger_state := l.state ; 
self.passenger_zip := l.zip_code; 
self.passenger_age := ''; 
self.passenger_location := ''; 
self.passenger_injury_sev := ''; 
self.first_passenger_safe := ''; 
self.second_passenger_safe := ''; 
self.passenger_eject_code := ''; 
self.passenger_fr_cap_code := ''; 
self.addr_suffix 					:= L.addr_suffix ;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.suffix 						:= L.suffix;  
self.cname              := l.cname; 

self 								:= L;
self := []; 
end;

pecrash :=project(ecrashFile, xpndecrash(left)); 

//iyetek 
/*
iyetekFile := FLAccidents_Ecrash.BaseFile_Iyetek (STD.Str.ToUpperCase(trim(person_type)) in ['\\PASSENGER',
'3PASSENGER',
'ÃƒÂ¢?Ã‚Â¢THEY ENTERED: PASSENGER',
'BICYCLE',
'BICYCLIST',
'BYCICLIST',
'INJURED PASSENGER',
'OASSENGER',
'PAASENGER',
'PAS',
'PASEENGER',
'PASENGER',
'PASS',
'PASSANGER',
'PASSE',
'PASSEBGER',
'PASSEDNGER',
'PASSEENGER',
'PASSEGER',
'PASSEGNER',
'PASSEMGER',
'PASSENDER',
'PASSENEGER',
'PASSENEGR',
'PASSENER',
'PASSENGER',
'PASSENGER',
'PASSENGER1',
'PASSENGERA',
'PASSENGERJENNIFER',
'PASSENGERS',
'PASSENGERT',
'PASSENGFER',
'PASSENGR',
'PASSENJGER',
'PASSENNGER',
'PASSSENGER']);  

xpnd_layout xpndiyetek(iyetekFile L) := transform

t_accident_nbr 			    := L.state_report_number;
self.rec_type_5         := '5';
t_scrub := STD.Str.Filter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 
self.section_nbr := l.vehicle_unit_number; 
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.passenger_nbr := ''; 
self.passenger_full_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.passenger_name_suffix := '';
self.passenger_st_city := trim(l.address,left,right)+' ' + trim(l.city,left,right); 
self.passenger_state := l.state ; 
self.passenger_zip := l.zip; 
self.passenger_age := ''; 
self.passenger_location := ''; 
self.passenger_injury_sev := ''; 
self.first_passenger_safe := ''; 
self.second_passenger_safe := ''; 
self.passenger_eject_code := ''; 
self.passenger_fr_cap_code := ''; 
self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.cname							:= l.cname;
self := l; 
self := []; 
end; 

piyetek := project(iyetekFile , xpndiyetek(left)); 
*/
ptotal := dedup(pflc5+pecrash,all); 
export key_Ecrash5 := index(ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							,{ptotal}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash5_' + doxie.Version_SuperKey);