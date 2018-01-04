import doxie, data_services;

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
	string10  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  pedest_full_name,
	string16  filler2,
	string1   ped_name_suffix,
	string40  ped_st_city,
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
  end;
xpnd_layout xpndrecs(flc6 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self 								:= L;
end;

pflc6:= project(flc6,xpndrecs(left));
//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.


export key_Ntlcrash6 := index(pflc6,
                              {unsigned6 l_acc_nbr := (integer)accident_nbr},
                              {pflc6},
                              data_services.data_location.prefix() + 'thor_data400::key::ntlcrash6_' + doxie.Version_SuperKey);