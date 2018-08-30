﻿import watercraft,roxiekeybuild,doxie,dops,DOPSGrowthCheck;

export proc_build_keys(string file_date) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_cid()   			 ,'~thor_data400::key::watercraft_cid'    			,'~thor_data400::key::watercraft::'+file_date+'::cid'    			  ,cid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_bdid   			 ,'~thor_data400::key::watercraft_bdid'   			,'~thor_data400::key::watercraft::'+file_date+'::bdid'   			  ,bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_did()    		 ,'~thor_data400::key::watercraft_did'    			,'~thor_data400::key::watercraft::'+file_date+'::did'    			  ,did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid()    		 ,'~thor_data400::key::watercraft_sid'    			,'~thor_data400::key::watercraft::'+file_date+'::sid'    			  ,sid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_wid()   			 ,'~thor_data400::key::watercraft_wid'    			,'~thor_data400::key::watercraft::'+file_date+'::wid'    			  ,wid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_hullnum			 ,'~thor_data400::key::watercraft_hullnum'			,'~thor_data400::key::watercraft::'+file_date+'::hullnum'			  ,hullnum_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_offnum 			 ,'~thor_data400::key::watercraft_offnum' 			,'~thor_data400::key::watercraft::'+file_date+'::offnum' 			  ,offnum_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_vslnam 			 ,'~thor_data400::key::watercraft_vslnam'       ,'~thor_data400::key::watercraft::'+file_date+'::vslnam' 			  ,vslnam_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Watercraft.Key_LinkIds.key 						 ,'~thor_data400::Key::watercraft_linkids' 		  ,'~thor_data400::key::watercraft::'+file_date+'::linkids' 		  ,linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid_linkids() ,'~thor_data400::key::watercraft_sid::linkids' ,'~thor_data400::key::watercraft::'+file_date+'::sid::linkids'  ,sid_key_linkids);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Watercraft.key_watercraft_SourceRecId 	 ,'~thor_data400::key::watercraft_Source_Rec_Id','~thor_data400::key::watercraft::'+file_date+'::Source_Rec_Id' ,Source_Rec_Id_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_cid'    		   ,'~thor_data400::key::watercraft::'+file_date+'::cid'           ,mv_cid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_bdid'   		   ,'~thor_data400::key::watercraft::'+file_date+'::bdid'          ,mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_did'    		   ,'~thor_data400::key::watercraft::'+file_date+'::did'           ,mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_sid'    		   ,'~thor_data400::key::watercraft::'+file_date+'::sid'           ,mv_sid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_wid'    		   ,'~thor_data400::key::watercraft::'+file_date+'::wid'           ,mv_wid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_hullnum'		   ,'~thor_data400::key::watercraft::'+file_date+'::hullnum'       ,mv_hullnum_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_offnum' 		   ,'~thor_data400::key::watercraft::'+file_date+'::offnum'        ,mv_offnum_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_vslnam' 		   ,'~thor_data400::key::watercraft::'+file_date+'::vslnam'        ,mv_vslnam_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::Key::watercraft_linkids'       ,'~thor_data400::key::watercraft::'+file_date+'::linkids'       ,mv_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_sid::linkids'  ,'~thor_data400::key::watercraft::'+file_date+'::sid::linkids'  ,mv_sid_key_linkids);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_Source_Rec_Id' ,'~thor_data400::key::watercraft::'+file_date+'::Source_Rec_Id' ,mv_Source_Rec_Id);

// FCRA 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_cid(true)    ,'~thor_data400::key::watercraft::fcra::cid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::cid'    ,fcra_cid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_did(true)    ,'~thor_data400::key::watercraft::fcra::did'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::did'    ,fcra_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid(true)   	,'~thor_data400::key::watercraft::fcra::sid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::sid'    ,fcra_sid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_wid(true)    ,'~thor_data400::key::watercraft::fcra::wid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::wid'    ,fcra_wid_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::cid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::cid'    ,mv_fcra_cid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::did'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::did'    ,mv_fcra_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::sid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::sid'    ,mv_fcra_sid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::wid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::wid'    ,mv_fcra_wid_key);

// Persitence/Growth check
GetDops := dops.GetDeployedDatasets('P', 'B', 'F');
OnlyCrim:=GetDops(datasetname='FCRA_WatercraftKeys');
father_file_date := OnlyCrim[1].buildversion;

set of string DistSet_watercraft_cid :=['vessel_id']; // WaterCraft.Out_Coastguard_Base_Dev - Persistent_record_id 
set of string InputSet_watercraft_cid := ['watercraft_key','sequence_key ','state_origin','source_code',  'vessel_database_key', 'name_of_vessel','call_sign','official_number','imo_number','hull_number','hull_identification_number', 'vessel_service_type','flag','self_propelled_indicator','registered_gross_tons','registered_net_tons', 'registered_length','registered_breadth','registered_depth','itc_gross_tons','itc_net_tons','itc_length', 'itc_breadth','itc_depth','hailing_port','hailing_port_state','hailing_port_province','home_port_name', 'home_port_state','home_port_province','trade_ind_coastwise_unrestricted','trade_ind_limited_coastwise_bowaters_only', 'trade_ind_limited_coastwise_restricted','trade_ind_limited_coastwise_oil_spill_response_only', 'trade_ind_limited_coastwise_under_charter_to_citizen','trade_ind_fishery','trade_ind_limited_fishery_only', 'trade_ind_recreation','trade_ind_limited_recreation_great_lakes_use_only','trade_ind_registry', 'trade_ind_limited_registry_cross_border_financing','trade_ind_limited_registry_no_foreign_voyage', 'trade_ind_limited_registry_trade_with_canada_only','trade_ind_great_lakes','vessel_complete_build_city', 'vessel_complete_build_state','vessel_complete_build_province','vessel_complete_build_country','vessel_build_year', 'vessel_hull_build_city','vessel_hull_build_state','vessel_hull_build_province','vessel_hull_build_country', 'party_identification_number','main_hp_ahead','main_hp_astern','propulsion_type','hull_material','ship_yard', 'hull_builder_name','doc_certificate_status','date_issued','date_expires','hull_design_type','sail_ind', 'party_database_key','itc_tons_cod_ind']; 

set of string DistSet_watercraft_sid :=['did']; // watercraft.Out_Search_Base_Dev 
set of string InputSet_watercraft_sid := ['watercraft_key','sequence_key','state_origin','source_code','dppa_flag','orig_name','orig_name_type_code', 'orig_name_type_description','orig_name_first','orig_name_middle','orig_name_last','orig_name_suffix', 'orig_address_1','orig_address_2','orig_city','orig_state','orig_zip','orig_fips','orig_province', 'orig_country','dob','orig_ssn','orig_fein','gender','phone_1','phone_2'] ;

set of string DistSet_watercraft_wid :=['watercraft_id']; // WaterCraft.Persist_Main_Joined 
set of string InputSet_watercraft_wid := ['state_origin','source_code','st_registration','county_registration','registration_number','hull_number', 'propulsion_code','propulsion_description','vehicle_type_code','vehicle_type_description','fuel_code', 'fuel_description','hull_type_code','hull_type_description','use_code','use_description','model_year', 'watercraft_name','watercraft_class_code','watercraft_class_description','watercraft_make_code', 'watercraft_make_description','watercraft_model_code','watercraft_model_description','watercraft_length', 'watercraft_width','watercraft_weight','watercraft_color_1_code','watercraft_color_1_description', 'watercraft_color_2_code','watercraft_color_2_description','watercraft_toilet_code','watercraft_toilet_description', 'watercraft_number_of_engines','watercraft_hp_1','watercraft_hp_2','watercraft_hp_3','engine_number_1', 'engine_number_2','engine_number_3','engine_make_1','engine_make_2','engine_make_3','engine_model_1', 'engine_model_2','engine_model_3','engine_year_1','engine_year_2','engine_year_3','coast_guard_documented_flag', 'coast_guard_number','registration_date','registration_expiration_date','registration_status_code', 'registration_status_description','registration_status_date','registration_renewal_date','decal_number', 'transaction_type_code','transaction_type_description','title_state','title_status_code', 'title_status_description','title_number','title_issue_date','title_type_code','title_type_description', 'additional_owner_count','lien_1_indicator','lien_1_name','lien_1_date','lien_1_address_1', 'lien_1_address_2','lien_1_city','lien_1_state','lien_1_zip','lien_2_indicator','lien_2_name', 'lien_2_date','lien_2_address_1','lien_2_address_2','lien_2_city','lien_2_state','lien_2_zip', 'state_purchased','purchase_date','dealer','purchase_price','new_used_flag','watercraft_status_code', 'watercraft_status_description','history_flag','coastguard_flag','signatory'];
	
DeltaCommands:=sequential(
								DOPSGrowthCheck.CalculateStats('FCRA_WatercraftKeys', 'WaterCraft.key_watercraft_cid(true)', 'key_watercraft_cid_FCRA', '~thor_data400::key::watercraft::fcra::'+file_date+'::cid', 'state_origin,watercraft_key,sequence_key', 'vessel_id', '', '', '', '', file_date, father_file_date, true, true), 
								DOPSGrowthCheck.DeltaCommand('~thor_data400::key::watercraft::fcra::'+file_date+'::cid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::cid', 'FCRA_WatercraftKeys', 'key_watercraft_cid_FCRA', 'WaterCraft.key_watercraft_cid(true)', 'vessel_id', file_date, father_file_date, ['vessel_id', 'state_origin', 'source_code',  'vessel_database_key', 'name_of_vessel', 'call_sign', 'official_number', 'imo_number', 'hull_number'], true, true), 
								DOPSGrowthCheck.ChangesByField('~thor_data400::key::watercraft::fcra::'+file_date+'::cid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::cid', 'FCRA_WatercraftKeys', 'key_watercraft_cid_FCRA', 'WaterCraft.key_watercraft_cid(true)', 'vessel_id', 'date_issued,date_expires', file_date, father_file_date, true, true), 
								DOPSGrowthCheck.PersistenceCheck('~thor_data400::key::watercraft::fcra::'+file_date+'::cid',  '~thor_data400::key::watercraft::fcra::'+father_file_date+'::cid',  'FCRA_WatercraftKeys',  'key_watercraft_cid_FCRA',  'WaterCraft.key_watercraft_cid(true)',  'vessel_id',  InputSet_watercraft_cid,  DistSet_watercraft_cid,  file_date,  father_file_date, true, true),
							
								DOPSGrowthCheck.CalculateStats('FAA_DOCKeys', 'WaterCraft.key_watercraft_sid(true)', 'key_watercraft_sid_FCRA', '~thor_data400::key::watercraft::fcra::'+file_date+'::sid', 'state_origin,watercraft_key,sequence_key', 'did', '', '', '', '', file_date, father_file_date, true, true),
								DOPSGrowthCheck.DeltaCommand('~thor_data400::key::watercraft::fcra::'+file_date+'::sid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::sid', 'FAA_DOCKeys', 'key_watercraft_sid_FCRA', 'WaterCraft.key_watercraft_sid(true)', 'did', file_date, father_file_date, ['did',  'state_origin', 'source_code', 'dppa_flag', 'orig_name', 'orig_name_type_code', 'orig_name_type_description', 'orig_name_first', 'orig_name_middle', 'orig_name_last'], true, true),
								DOPSGrowthCheck.ChangesByField('~thor_data400::key::watercraft::fcra::'+file_date+'::sid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::sid', 'FAA_DOCKeys', 'key_watercraft_sid_FCRA', 'WaterCraft.key_watercraft_sid(true)', 'did', 'date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported', file_date, father_file_date, true, true),
								DOPSGrowthCheck.PersistenceCheck('~thor_data400::key::watercraft::fcra::'+file_date+'::sid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::sid', 'FAA_DOCKeys', 'key_watercraft_sid_FCRA', 'WaterCraft.key_watercraft_sid(true)', 'did', InputSet_watercraft_sid, DistSet_watercraft_sid, file_date, father_file_date, true, true),
								
								DOPSGrowthCheck.CalculateStats('FAA_DOCKeys', 'WaterCraft.key_watercraft_wid(true)', 'key_watercraft_wid_FCRA', '~thor_data400::key::watercraft::fcra::'+file_date+'::wid', 'state_origin,watercraft_key,sequence_key', 'watercraft_id', '', '', '', '', file_date, father_file_date, true, true),
								DOPSGrowthCheck.DeltaCommand('~thor_data400::key::watercraft::fcra::'+file_date+'::wid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::wid', 'FAA_DOCKeys', 'key_watercraft_wid_FCRA', 'WaterCraft.key_watercraft_wid(true)', 'watercraft_id', file_date, father_file_date, ['watercraft_id', 'state_origin', 'source_code', 'st_registration', 'county_registration', 'registration_number', 'hull_number', 'propulsion_code'], true, true),
								DOPSGrowthCheck.ChangesByField('~thor_data400::key::watercraft::fcra::'+file_date+'::wid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::wid', 'FAA_DOCKeys', 'key_watercraft_wid_FCRA', 'WaterCraft.key_watercraft_wid(true)', 'watercraft_id', 'registration_date,title_issue_date,purchase_date', file_date, father_file_date, true, true),
								DOPSGrowthCheck.PersistenceCheck('~thor_data400::key::watercraft::fcra::'+file_date+'::wid', '~thor_data400::key::watercraft::fcra::'+father_file_date+'::wid', 'FAA_DOCKeys', 'key_watercraft_wid_FCRA', 'WaterCraft.key_watercraft_wid(true)', 'watercraft_id', InputSet_watercraft_wid, DistSet_watercraft_wid, file_date, father_file_date, true, true)
							);


bk := sequential(parallel(cid_key,bdid_key,did_key,sid_key,wid_key,hullnum_key,offnum_key,vslnam_key,linkids_key,sid_key_linkids,Source_Rec_Id_key,fcra_cid_key,fcra_wid_key,fcra_did_key,fcra_sid_key),
								 parallel(mv_cid_key,mv_bdid_key,mv_did_key,mv_sid_key,mv_wid_key,mv_hullnum_key,mv_offnum_key,mv_vslnam_key,mv_linkids_key,mv_sid_key_linkids,mv_Source_Rec_Id,mv_fcra_cid_key,mv_fcra_wid_key,mv_fcra_sid_key,mv_fcra_did_key),
								 DeltaCommands);
					
return bk;

end;

