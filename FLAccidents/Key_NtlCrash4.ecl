/*2010-12-01T21:01:25Z (t gibson)

*/
import doxie;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
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
	string10  accident_nbr,
	string2   section_nbr,
	string2   filler1,
	string25  driver_full_name,
	string16  filler2,
	string1   driver_name_suffix,
	string40  driver_st_city,
	string18  filler3,
	string2   driver_resident_state,
	string9   driver_zip,
	string8   driver_dob,
	string8   driver_ssn,
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
	string51  filler5,
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
	string30 Policy_num;	   
  string8 Policy_Effective_Date;	   
	string8 Policy_Expiration_Date;	
	string9 inquiry_ssn,
	string8 inquiry_dob,
	string20 inquiry_mname,
	string5 inquiry_zip5,
	string4 inquiry_zip4,
  end;
xpnd_layout xpndrecs(flc4 L,FLAccidents.Key_FlCrash0 R) := transform
self.report_code						:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.vehicle_id_nbr					:= '';
self.vehicle_year						:= '';
self.vehicle_make						:= '';
self.make_description				:= '';
self.model_description			:= '';
self.vehicle_incident_city	:= stringlib.stringtouppercase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
self.vehicle_incident_st		:= 'FL';
self.point_of_impact				:= '';
self.carrier_name						:= '';
self.client_type_id					:= '';
self.driver_ssn							:= '';
self.Policy_num						  := '';	   
self.Policy_Effective_Date  := '';	   
self.Policy_Expiration_Date := '';
self.inquiry_ssn						:= '';
self.inquiry_dob						:= '';
self.inquiry_mname					:= '';
self.inquiry_zip5 					:= '';
self.inquiry_zip4 					:= '';
self 												:= L;
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
self.did									:= if(L.did = 0,'000000000000',intformat(L.did,12,1));
self.rec_type_4 					:= '4';
self.accident_nbr 				:= (string10)((unsigned6)L.vehicle_incident_id+1000000000);
//------------------------------------
//used for mobileTrac
self.vehicle_id_nbr				:= L.vehVin;
self.vehicle_year					:= L.vehYear;
self.vehicle_make					:= L.vehMake;
self.make_description			:= if(L.make_description != '',L.make_description,L.vehMake);
self.model_description		:= if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city:= L.inc_city;
self.vehicle_incident_st	:= L.state_abbr;
self.point_of_impact			:= L.impact_location;
//------------------------------------
self.section_nbr					:=  L.vehicle_nbr;
self.driver_full_name     :=  map(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME  +' '+L.FIRST_NAME,'');
self.driver_st_city				:=  L.inc_city;
									
self.driver_resident_state:= L.STATE_ABBR;
self.driver_zip  					:= L.z5;
self.driver_dob    				:= L.dob;
self.driver_dl_nbr				:= L.pty_drivers_license;
self.driver_lic_st				:= L.pty_drivers_license_st;
self.driver_sex						:= '';//inquiry data, if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.gender_1[1],'');
self.addr_suffix 					:= L.suffix;
self.ace_fips_st					:= L.county_code[1..2];
self.county								:= L.county_code[3..5];
self.zip									:= L.z5;
self.score 								:= L.name_score;
self.suffix 							:= L.name_suffix;
self.cname								:= stringlib.stringtouppercase(L.business_name);
self.carrier_name					:= L.LEGAL_NAME;
self.driver_ssn						:= '';
self.Policy_num						  := L.POLICY_NBR;   
self.Policy_Effective_Date  := '';	   
self.Policy_Expiration_Date := L.POLICY_EXP_DATE;
self.inquiry_ssn					:= L.inquiry_ssn;
self.inquiry_dob					:= L.inquiry_dob;
self.inquiry_mname				:= L.inquiry_mname;
self.inquiry_zip5 				:= L.inquiry_zip5;
self.inquiry_zip4 				:= L.inquiry_zip4;
self											:= L;
self 											:= [];
end;

pntl := project(ntlFile(party_type = 'DRIVER'),slimrec(left));

allrecs := dedup(pflc4+pntl,record,all)
					 : persist('~thor_data400::persist::ntlcrash4');

export Key_ntlCrash4 := index(allrecs
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{allrecs}
							,'~thor_data400::key::ntlcrash4_' + doxie.Version_SuperKey);
						 	 
							