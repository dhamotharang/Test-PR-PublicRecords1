Import Data_Services, doxie, FLAccidents, lib_stringlib, STD;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc7 := FLAccidents.basefile_flcrash7;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string12  did,
	unsigned1 did_score,
	string12  b_did, 
    unsigned1 b_did_score,
	string1   rec_type_7,
	string40  accident_nbr,
	string2   prop_damage_code,
	string2   prop_damage_nbr,
	string25  prop_damaged,
	string7   prop_damage_amount,
	string25  prop_owner_name,
	string16  filler1,
	string1   prop_owner_suffix,
	string150  prop_owner_st_city,
	string18  filler2,
	string2   prop_owner_state,
	string9   prop_owner_zip,
	string2   fr_fixed_object_cap_code,
	string241 filler3,
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
xpnd_layout xpndrecs(flc7 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr := l.accident_nbr; 
self 								:= L;
end;

pflc7:= project(flc7,xpndrecs(left));

//ecrash 
pecrshFile := eCrashBaseAgencyExclusion( STD.Str.ToUpperCase(trim(person_type)) in ['PROPERTY DAMAGE OWNER','PROPERTY OWNER']); 

xpnd_layout xpndecrash(pecrshFile L) := transform

self.rec_type_7						:= '7';
self.did							:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.b_did							:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.b_did_score      := l.bdid_score ; 
t_accident_nbr 			:= if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.orig_accnbr := t_accident_nbr;
self.prop_damage_nbr := ''; // need to be populated after property damage file added in prod 
self.prop_damaged := l.property_damage_description1;
self.prop_damage_code := ''; 
self.prop_damage_amount := l.property_damage_estimate1;
self.prop_owner_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.prop_owner_suffix := if(trim(l.name_suffx,left,right) = 'N', '', l.name_suffx);
self.prop_owner_st_city := trim(l.address,left,right) + trim(l.city,left,right);
self.prop_owner_state := l.state ; 
self.prop_owner_zip := l.zip_code; 

self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.suffix 						:= L.suffix;  
self.cname              := l.cname; 

self := l; 
self := [];
end; 

pecrash := project(pecrshFile, xpndecrash(left)); 

//iyetek 

/*iyetekFile := FLAccidents_Ecrash.BaseFile_Iyetek( STD.Str.ToUpperCase(trim(person_type)) in ['PROPERTY DAMAGE OWNER','PROPERTY OWNER']); 

xpnd_layout xpndiyetek(iyetekFile L) := transform

self.rec_type_7						:= '7';
self.did							:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.b_did							:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.b_did_score      := l.bdid_score ; 
t_scrub := STD.Str.Filter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 

self.prop_damage_nbr := ''; // need to be populated after property damage file added in prod 
self.prop_damaged := '';
self.prop_damage_code := ''; 
self.prop_damage_amount := ''; 
self.prop_owner_name := trim(l.first_name,left,right)+' '+trim(l.middle_name,left,right) +' '+trim(l.last_name ,left,right);
self.prop_owner_suffix := '';
self.prop_owner_st_city := trim(l.address,left,right) + trim(l.city,left,right);
self.prop_owner_state := l.state ; 
self.prop_owner_zip := l.zip; 

self.addr_suffix 					:= L.addr_suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county							:= L.county_code[3..5];
self.zip							:= L.z5;
self.zip4								:= L.z4;
self.score 							:= L.name_score;
self.cname							:= l.cname;

self := l; 
self :=[]; 
end; 

piyetek := project(iyetekFile, xpndiyetek(left)); */

ptotal := dedup(pflc7+pecrash/*+piyetek*/,all); 
export key_Ecrash7 := index(ptotal,
                            {string40 l_acc_nbr := accident_nbr}
							,{ptotal}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash7_' + doxie.Version_SuperKey);