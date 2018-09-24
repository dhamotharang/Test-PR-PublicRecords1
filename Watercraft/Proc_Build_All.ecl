import Orbit_report,Watercraft, Lib_FileServices, doxie_build, watercraftv2_services,ut,RoxieKeyBuild, Watercraft_infutor, Watercraft_preprocess, DOPS, strata;

/*Folderdate and InfolinkQtr are for spray process.
  Folderdate is where files are located, ie: '14q2' or '14q3'.  InfolinkQtr is in filename, ie: WI2014_Q3.  'Q3' would be the InfolinkQtr.*/
export proc_build_all(string filedate, string folderdate, string InfolinkQtr, string emailList='') := function

#workunit('name','Watercraft Build ' + filedate);


eMail_Recipient := 'Sudhir.Kasavajjala@lexisnexis.com';
leMailTarget    := 'RoxieBuilds@seisint.com,'+eMail_Recipient;

//  These build process have been added to SCRUBS - Bug# 168693
/*
ut.MAC_SF_BuildProcess(Watercraft.Out_Coastguard_Base_Dev
											 ,Watercraft.Cluster + 'base::watercraft_coastguard'
											 ,aCoastguardBaseFile,2,,true);										 
											 
ut.MAC_SF_BuildProcess(Watercraft.Persist_Main_Joined
											 ,Watercraft.Cluster + 'base::watercraft_main'
											 ,aMainBaseFile,2,,true);
											 
ut.MAC_SF_BuildProcess(Out_Search_Base_Dev
											 ,Watercraft.Cluster +'base::watercraft_search'
											 ,aSearchBaseFile,2,,true);	
*/								 

// DF-21844 Show counts of blanked out fields in thor_data400::key::watercraft::fcra::sid_qa
// thor_data400::key::watercraft::fcra::cid_qa,thor_data400::key::watercraft::fcra::wid_qa
cnt_watercraft_sid_fcra := OUTPUT(strata.macf_pops(watercraft.key_watercraft_sid(true),,,,,,FALSE,
																								 ['company_name','gender','orig_fips','orig_province','phone_2','title']));

cnt_watercraft_cid_fcra := OUTPUT(strata.macf_pops(watercraft.key_watercraft_cid(true),,,,,,FALSE,
																								 ['call_sign','date_expires','date_issued','doc_certificate_status','flag','hailing_port',
																									'hailing_port_province','hailing_port_state','home_port_name','home_port_province','home_port_state',
																									'hull_builder_name','hull_design_type','hull_identification_number','hull_material','imo_number',
																									'itc_breadth','itc_depth','itc_gross_tons','itc_net_tons','itc_tons_cod_ind','main_hp_ahead',
																									'main_hp_astern','name_of_vessel','official_number','party_database_key','party_identification_number',
																									'propulsion_type','registered_breadth','registered_depth','registered_gross_tons','registered_length',
																									'registered_net_tons','sail_ind','self_propelled_indicator','ship_yard','trade_ind_coastwise_unrestricted',
																									'trade_ind_fishery','trade_ind_great_lakes','trade_ind_limited_coastwise_bowaters_only',
																									'trade_ind_limited_coastwise_oil_spill_response_only','trade_ind_limited_coastwise_restricted',
																									'trade_ind_limited_coastwise_under_charter_to_citizen','trade_ind_limited_fishery_only',
																									'trade_ind_limited_recreation_great_lakes_use_only','trade_ind_limited_registry_cross_border_financing',
																									'trade_ind_limited_registry_no_foreign_voyage','trade_ind_limited_registry_trade_with_canada_only',
																									'trade_ind_recreation','trade_ind_registry','vessel_build_year','vessel_complete_build_city',
																									'vessel_complete_build_country','vessel_complete_build_province','vessel_complete_build_state',
																									'vessel_database_key','vessel_hull_build_city','vessel_hull_build_country','vessel_hull_build_province',
																									'vessel_hull_build_state','vessel_id','vessel_service_type']));
cnt_watercraft_wid_fcra := OUTPUT(strata.macf_pops(watercraft.key_watercraft_wid(true),,,,,,FALSE,
																								 ['additional_owner_count','coast_guard_documented_flag','coast_guard_number','coastguard_flag',
																								 'county_registration','dealer','decal_number','engine_make_1','engine_make_2','engine_make_3','engine_model_1',
																								 'engine_model_2','engine_model_3','engine_number_1','engine_number_2','engine_number_3','engine_year_1',
																								 'engine_year_2','engine_year_3','fuel_code','fuel_description','lien_2_address_1','lien_2_address_2',
																								 'lien_2_city','lien_2_date','lien_2_indicator','lien_2_name','lien_2_state','lien_2_zip','new_used_flag',
																								 'propulsion_code','propulsion_description','purchase_date','purchase_price','registration_expiration_date',
																								 'registration_renewal_date','registration_status_code','registration_status_date','registration_status_description',
																								 'signatory','state_purchased','title_state','title_type_code','title_type_description',
																								 'transaction_type_code','transaction_type_description','use_code','use_description','vehicle_type_code',
																								 'watercraft_color_1_code','watercraft_color_1_description','watercraft_color_2_code',
																								 'watercraft_color_2_description','watercraft_hp_1','watercraft_hp_2','watercraft_hp_3',
																								 'watercraft_name','watercraft_number_of_engines','watercraft_status_code','watercraft_status_description',
																								 'watercraft_toilet_code','watercraft_toilet_description','watercraft_weight','watercraft_width']));
																								 
orbit_report.Watercraft_Stats(getretval);


return sequential
 (
 /* Infutor spray is called from script*/
	//Watercraft_infutor.proc_spray_Infutor(filedate),

	Watercraft_preprocess.proc_build_raw_input(filedate,folderdate,InfolinkQtr), //New clean raw input process using ECL
	Watercraft.file_infutor_in,
//Builds base files and runs scrubs process	
		Watercraft.proc_Scrubs_Coastguard(filedate,emailList),
		Watercraft.proc_Scrubs_Main(filedate,emailList),
		Watercraft.proc_Scrubs_Search(filedate,emailList),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 1 of 4','Watercraft Build - Data Complete'),
	parallel
	 (
		Watercraft.Out_Search_Base_Dev_Stats,
		Watercraft.Out_Main_Base_Dev_Stats,
		Watercraft.Out_Coastguard_Base_Dev_Stats,
		Watercraft.fn_Out_Base_Dev_Stats(filedate),
		Watercraft.coverage,
		Watercraft.SampleQAFile
	 ),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 2 of 4','Watercraft Build - Stats Complete'),
	watercraft.proc_build_keys(filedate),
	watercraftv2_services.proc_autokeybuild(filedate),
	watercraft.Proc_Build_Boolean_key(filedate),
	watercraft.Proc_AcceptSK_toQA,
	parallel(cnt_watercraft_sid_fcra,cnt_watercraft_cid_fcra,cnt_watercraft_wid_fcra),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 3 of 4','Watercraft Build - Keys Complete'),
  Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build Succeeded ' + filedate,
	         'keys: 1)  thor_data400::key::watercraft::'+filedate+'::cid \n' + 
				   '      2)  thor_data400::key::watercraft::'+filedate+'::bdid \n' + 
				   '      3)  thor_data400::key::watercraft::'+filedate+'::did \n' + 
				   '      4)  thor_data400::key::watercraft::'+filedate+'::sid \n' + 
				   '      5)  thor_data400::key::watercraft::'+filedate+'::wid \n' + 
				   '      6)  thor_data400::key::watercraft::'+filedate+'::hullnum \n' + 
				   '      7)  thor_data400::key::watercraft::'+filedate+'::offnum \n' + 
				   '      8)  thor_data400::key::watercraft::'+filedate+'::vslnam \n' +
					 '      9)  thor_data400::key::watercraft::'+filedate+'::linkids \n' +
					 '      10) thor_data400::key::watercraft::'+filedate+'::Source_Rec_Id \n' +
				   '      11) thor_data400::key::watercraft::'+filedate+'::autokey::address \n' +
				   '      12) thor_data400::key::watercraft::'+filedate+'::autokey::addressb2 \n' +
				   '      13) thor_data400::key::watercraft::'+filedate+'::autokey::citystname \n' +
				   '      14) thor_data400::key::watercraft::'+filedate+'::autokey::citystnameb2 \n' +
				   '      15) thor_data400::key::watercraft::'+filedate+'::autokey::fein2 \n' +
				   '      16) thor_data400::key::watercraft::'+filedate+'::autokey::name \n' +
				   '      17) thor_data400::key::watercraft::'+filedate+'::autokey::nameb2 \n' +
				   '      18) thor_data400::key::watercraft::'+filedate+'::autokey::namewords2 \n' +
				   '      19) thor_data400::key::watercraft::'+filedate+'::autokey::payload \n' +
				   '      20) thor_data400::key::watercraft::'+filedate+'::autokey::phone2 \n' +
				   '      21) thor_data400::key::watercraft::'+filedate+'::autokey::phoneb2 \n' +
				   '      22) thor_data400::key::watercraft::'+filedate+'::autokey::ssn2 \n' +
				   '      23) thor_data400::key::watercraft::'+filedate+'::autokey::stname \n' +
				   '      24) thor_data400::key::watercraft::'+filedate+'::autokey::stnameb2 \n' +
				   '      25) thor_data400::key::watercraft::'+filedate+'::autokey::zip \n' +
				   '      26) thor_data400::key::watercraft::'+filedate+'::autokey::zipb2 \n' +
				   'have been built and ready to be deployed to QA.'),
					 DOPS.updateversion('WatercraftKeys',filedate,'skasavajjala@seisint.com',,'N|B'),
					 DOPS.updateversion('FCRA_WatercraftKeys',filedate,'skasavajjala@seisint.com',,'F'),
				   getretval
  );
	
end;