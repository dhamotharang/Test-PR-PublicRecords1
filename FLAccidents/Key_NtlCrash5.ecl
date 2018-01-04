import doxie, data_services;

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
	string10  accident_nbr,
	string2   section_nbr,
	string2   passenger_nbr,
	string25  passenger_full_name,
	string16  filler1,
	string1   passenger_name_suffix,
	string40  passenger_st_city,
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
  end;
xpnd_layout xpndrecs(flc5 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self 								:= L;
end;

pflc5:= project(flc5,xpndrecs(left));

//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.


export key_Ntlcrash5 := index(pflc5,
                              {unsigned6 l_acc_nbr := (integer)accident_nbr},
                              {pflc5},
                              data_services.data_location.prefix() + 'thor_data400::key::ntlcrash5_' + doxie.Version_SuperKey);