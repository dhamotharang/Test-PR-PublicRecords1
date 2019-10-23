/********************************************************************************************************** 
	Name: 			proc_build_keys
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This function is responsible for calling the each of the key definition function and manages the 
							building and versioning (and maintaining history) of each of the keys
***********************************************************************************************************/

IMPORT PRTE2_Watercraft,roxiekeybuild,ut,autokey, promotesupers, VersionControl, PRTE, PRTE2_Common, _control,strata;

EXPORT Proc_build_keys (string filedate) := function

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_bdid, Constants.KEY_PREFIX + 'bdid', Constants.KEY_PREFIX + filedate + '::bdid', bdid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_cid(), Constants.KEY_PREFIX + 'cid', Constants.KEY_PREFIX + filedate + '::cid', cid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_did(), Constants.KEY_PREFIX + 'did', Constants.KEY_PREFIX + filedate + '::did', did_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_hullnum, Constants.KEY_PREFIX + 'hullnum', Constants.KEY_PREFIX + filedate + '::hullnum', hullnum_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_offnum, Constants.KEY_PREFIX + 'offnum', Constants.KEY_PREFIX + filedate + '::offnum', offnum_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_sid(), Constants.KEY_PREFIX + 'sid', Constants.KEY_PREFIX + filedate + '::sid', sid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_sid_linkids, Constants.KEY_PREFIX + 'sid::linkids', Constants.KEY_PREFIX + filedate + '::sid::linkids', SIDlinkids_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_SourceRecID, Constants.KEY_PREFIX + 'source_rec_id', Constants.KEY_PREFIX + filedate + '::source_rec_id', SourceRecID_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_vslnam, Constants.KEY_PREFIX + 'vslnam', Constants.KEY_PREFIX + filedate + '::vslnam', vslnam_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_wid(), Constants.KEY_PREFIX + 'wid', Constants.KEY_PREFIX + filedate + '::wid', wid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.Key_LinkIds.key, Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkids_key);

//FCRA keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_cid(true), Constants.KEY_PREFIX + 'fcra::cid', Constants.KEY_PREFIX + 'fcra::' + filedate + '::cid', cid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_did(true), Constants.KEY_PREFIX + 'fcra::did', Constants.KEY_PREFIX + 'fcra::' + filedate + '::did', did_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_sid(true), Constants.KEY_PREFIX + 'fcra::sid', Constants.KEY_PREFIX + 'fcra::' + filedate + '::sid', sid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Watercraft.keys.key_watercraft_wid(true), Constants.KEY_PREFIX + 'fcra::wid', Constants.KEY_PREFIX + 'fcra::' + filedate + '::wid', wid_key_fcra);
	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::bdid', Constants.KEY_PREFIX + filedate + '::bdid', mv_bdid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::cid', Constants.KEY_PREFIX + filedate + '::cid', mv_cid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate + '::did', mv_did_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::hullnum', Constants.KEY_PREFIX + filedate + '::hullnum', mv_hullnum_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::offnum', Constants.KEY_PREFIX + filedate + '::offnum', mv_offnum_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::sid', Constants.KEY_PREFIX + filedate + '::sid', mv_sid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::sid::linkids', Constants.KEY_PREFIX + filedate + '::sid::linkids', mv_SIDlinkids_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::source_rec_id', Constants.KEY_PREFIX + filedate + '::source_rec_id', mv_SourceRecID_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::vslnam', Constants.KEY_PREFIX + filedate + '::vslnam', mv_vslnam_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::wid', Constants.KEY_PREFIX + filedate + '::wid', mv_wid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::linkids', Constants.KEY_PREFIX + filedate +'::linkids', mv_linkids_key);
	
//Move FCRA keys
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::cid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::cid',mv_cid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did', Constants.KEY_PREFIX + 'fcra::' + filedate +'::did',mv_did_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::sid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::sid',mv_sid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::wid', Constants.KEY_PREFIX + 'fcra::' + filedate +'::wid',mv_wid_key_fcra);
	
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q', mv_bdid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::cid','Q', mv_cid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_did_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::hullnum','Q', mv_hullnum_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::offnum','Q', mv_offnum_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::sid','Q', mv_sid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::sid::linkids','Q', mv_SIDlinkids_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::source_rec_id','Q', mv_SourceRecID_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::vslnam','Q', mv_vslnam_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::wid','Q', mv_wid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q', mv_linkids_QA);
	
//Move FCRA QA
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::cid','Q', mv_cid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did','Q', mv_did_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::sid','Q', mv_sid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::wid','Q', mv_wid_QA_fcra);


	cnt_watercraft_sid_fcra := OUTPUT(strata.macf_pops(PRTE2_Watercraft.keys.key_watercraft_sid(true),,,,,,FALSE,
																								 ['company_name','gender','orig_fips','orig_province','phone_2','title']), named('cnt_watercraft_sid_fcra'));

	cnt_watercraft_cid_fcra := OUTPUT(strata.macf_pops(PRTE2_Watercraft.keys.key_watercraft_cid(true),,,,,,FALSE,
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
																									'vessel_hull_build_state','vessel_id','vessel_service_type']), named('cnt_watercraft_cid_fcra'));
																									
cnt_watercraft_wid_fcra := OUTPUT(strata.macf_pops(PRTE2_Watercraft.keys.key_watercraft_wid(true),,,,,,FALSE,
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
																								 'watercraft_toilet_code','watercraft_toilet_description','watercraft_weight','watercraft_width']), named('cnt_watercraft_wid_fcra'));


	
	//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('WatercraftKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_WatercraftKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);
	
	
	
	BuildKeys := sequential(
													parallel(bdid_key, cid_key, did_key, hullnum_key, offnum_key, sid_key, SIDlinkids_key,
																	SourceRecID_key, vslnam_key, wid_key, linkids_key),
													parallel(cid_key_fcra, did_key_fcra, sid_key_fcra, wid_key_fcra),
													parallel(mv_bdid_key, mv_cid_key, mv_did_key, mv_hullnum_key, mv_offnum_key, mv_sid_key,
																	mv_SIDlinkids_key, mv_SourceRecID_key, mv_vslnam_key, mv_wid_key, mv_linkids_key),
													parallel(mv_cid_key_fcra, mv_did_key_fcra, mv_sid_key_fcra, mv_wid_key_fcra),
													parallel(mv_bdid_QA, mv_cid_QA, mv_did_QA, mv_hullnum_QA, mv_offnum_QA, mv_sid_QA,
																	mv_SIDlinkids_QA, mv_SourceRecID_QA, mv_vslnam_QA, mv_wid_QA, mv_linkids_QA),
													parallel(mv_cid_QA_fcra, mv_did_QA_fcra, mv_sid_QA_fcra, mv_wid_QA_fcra),
													//Build Autokeys
													PRTE2_Watercraft.Proc_build_autokeys(filedate),
													parallel(cnt_watercraft_sid_fcra, cnt_watercraft_cid_fcra,cnt_watercraft_wid_fcra),
													PerformUpdateOrNot,
												 );
										
	RETURN BuildKeys;

END;

