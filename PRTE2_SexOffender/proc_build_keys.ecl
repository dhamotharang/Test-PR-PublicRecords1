IMPORT PRTE2_SexOffender,roxiekeybuild,ut,autokey, promotesupers, VersionControl, PRTE2_Common, PRTE, _control,strata;

EXPORT proc_build_keys (string filedate) := FUNCTION

//Non FCRA
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_DID(), Constants.KEY_PREFIX + 'didpublic',Constants.KEY_PREFIX + filedate +'::didpublic',did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_fdid, Constants.KEY_PREFIX + 'fdid_public',Constants.KEY_PREFIX + filedate +'::fdid_public',fdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.key_sexoffender_offenses(), Constants.KEY_PREFIX + 'offenses_public',Constants.KEY_PREFIX + filedate +'::offenses_public',offenses_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_SPK(), Constants.KEY_PREFIX + 'spkpublic',Constants.KEY_PREFIX + filedate +'::spkpublic',spk_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_SPK_Enh, Constants.KEY_PREFIX + 'enhpublic',Constants.KEY_PREFIX + filedate +'::enhpublic',enh_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_Zip_Type, Constants.KEY_PREFIX + 'zip_type_public',Constants.KEY_PREFIX + filedate +'::zip_type_public',zip_type_key);

//FCRA keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_DID(true), Constants.KEY_PREFIX + 'fcra::didpublic',Constants.KEY_PREFIX + 'fcra::' + filedate +'::didpublic',did_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.key_sexoffender_offenses(true), Constants.KEY_PREFIX + 'fcra::offenses_public',Constants.KEY_PREFIX + 'fcra::' + filedate +'::offenses_public',offenses_key_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_SexOffender.keys.Key_SexOffender_SPK(true), Constants.KEY_PREFIX + 'fcra::spkpublic',Constants.KEY_PREFIX + 'fcra::' + filedate +'::spkpublic',spk_key_fcra);

//Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::didpublic', Constants.KEY_PREFIX + filedate +'::didpublic',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::fdid_public', Constants.KEY_PREFIX + filedate +'::fdid_public',mv_fdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::offenses_public', Constants.KEY_PREFIX + filedate +'::offenses_public',mv_offenses_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::spkpublic', Constants.KEY_PREFIX + filedate +'::spkpublic',mv_spk_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::enhpublic', Constants.KEY_PREFIX + filedate +'::enhpublic',mv_enh_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::zip_type_public', Constants.KEY_PREFIX + filedate +'::zip_type_public',mv_zip_type_key);

//Move FCRA keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::didpublic', Constants.KEY_PREFIX + 'fcra::' + filedate +'::didpublic',mv_did_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::offenses_public', Constants.KEY_PREFIX + 'fcra::' + filedate +'::offenses_public',mv_offenses_key_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'fcra::' + '@version@::spkpublic', Constants.KEY_PREFIX + 'fcra::' + filedate +'::spkpublic',mv_spk_key_fcra);

//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::didpublic','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::fdid_public','Q', mv_fdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::offenses_public','Q', mv_offenses_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::spkpublic','Q', mv_spk_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::enhpublic','Q', mv_enh_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::zip_type_public','Q', mv_zip_type_QA);

//Move FCRA QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::didpublic','Q', mv_did_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::offenses_public','Q', mv_offenses_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::spkpublic','Q', mv_spk_QA_fcra);

//Blanking FCRA fields
cnt_so_spkpublic_fcra := OUTPUT(strata.macf_pops(PRTE2_SexOffender.keys.Key_SexOffender_SPK(true),,,,,,FALSE,
																									['addl_comments_1','addl_comments_2','age','build_type','corrective_lense_flag','dna','dob_aka','doc_number','employer','employer_address_1',
																									 'employer_address_2','employer_address_3','employer_address_4','employer_address_5','employer_comments','employer_county',
																									 'employer_phone','ethnicity','fbi_number','fingerprint_date','fingerprint_link','image_date','image_link','intnet_email_address_1',
																									 'intnet_email_address_2','intnet_email_address_3','intnet_email_address_4','intnet_email_address_5','intnet_instant_message_addr_1',
																									 'intnet_instant_message_addr_2','intnet_instant_message_addr_3','intnet_instant_message_addr_4','intnet_instant_message_addr_5','intnet_user_name_1',
																									 'intnet_user_name_1_url','intnet_user_name_2','intnet_user_name_2_url','intnet_user_name_3','intnet_user_name_3_url',
																									 'intnet_user_name_4','intnet_user_name_4_url','intnet_user_name_5','intnet_user_name_5_url','ncic_number',
																									 'offender_category','offender_status','orig_dl_date','orig_dl_link','orig_dl_number',
																									 'orig_dl_state','orig_registration_number_1','orig_registration_number_2','orig_registration_number_3','orig_registration_number_4',
																									 'orig_registration_number_5','orig_state','orig_state_code','orig_veh_color_1','orig_veh_color_2',
																									 'orig_veh_color_3','orig_veh_color_4','orig_veh_color_5','orig_veh_location_1','orig_veh_location_2',
																									 'orig_veh_location_3','orig_veh_location_4','orig_veh_location_5','orig_veh_make_model_1','orig_veh_make_model_2',
																									 'orig_veh_make_model_3','orig_veh_make_model_4','orig_veh_make_model_5','orig_veh_plate_1','orig_veh_plate_2',
																									 'orig_veh_plate_3','orig_veh_plate_4','orig_veh_plate_5','orig_veh_state_1','orig_veh_state_2',
																									 'orig_veh_state_3','orig_veh_state_4','orig_veh_state_5','orig_veh_year_1','orig_veh_year_2',
																									 'orig_veh_year_3','orig_veh_year_4','orig_veh_year_5','other_registration_address_1','other_registration_address_2',
																									 'other_registration_address_3','other_registration_address_4','other_registration_address_5','other_registration_county','other_registration_phone',
																									 'palmprint_date','palmprint_link','passport_authority','passport_code','passport_date',
																									 'passport_dob','passport_endorsement','passport_expiration_date','passport_first_name','passport_given_name',
																									 'passport_issue_date','passport_link','passport_nationality','passport_number','passport_place_of_birth',
																									 'passport_sex','passport_type','police_agency','police_agency_address_1','police_agency_address_2',
																									 'police_agency_contact_name','police_agency_phone','professional_licenses_1','professional_licenses_2','professional_licenses_3',
																									 'professional_licenses_4','professional_licenses_5','reg_date_1_type','reg_date_2','reg_date_2_type',
																									 'reg_date_3','reg_date_3_type','registration_address_3','registration_address_4','registration_address_5',
																									 'registration_cell_phone','registration_home_phone','registration_type','risk_description','risk_level_code',
																									 'scars_marks_tattoos','school','school_address_1','school_address_2','school_address_3',
																									 'school_address_4','school_address_5','school_comments','school_county','school_phone',
																									 'shoe_size','skin_tone','ssn','st_id_number','temp_lodge_address_1',
																									 'temp_lodge_address_2','temp_lodge_address_3','temp_lodge_address_4','temp_lodge_address_5','temp_lodge_county','temp_lodge_phone']),
																									 named('cnt_so_spkpublic_fcra'));

cnt_so_offenses_fcra := OUTPUT(strata.macf_pops(PRTE2_SexOffender.keys.key_sexoffender_offenses(true),,,,,,FALSE,
																									['arrest_date','arrest_warrant','conviction_date','conviction_jurisdiction','court','court_case_number',
																									 'offense_category','offense_code_or_statute','offense_date','offense_description','offense_description_2',
																									 'sentence_description','sentence_description_2','victim_age','victim_gender','victim_minor','victim_relationship']),
																									 named('cnt_so_offenses_fcra'));


//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops   		 		:= PRTE.UpdateVersion('SexOffenderKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
	updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_SexOffenderKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);





build_keys := sequential(
													parallel(did_key, fdid_key, offenses_key, spk_key, enh_key, zip_type_key),
													parallel(did_key_fcra, offenses_key_fcra, spk_key_fcra),
													parallel(mv_did_key, mv_fdid_key, mv_offenses_key, mv_spk_key, mv_enh_key, mv_zip_type_key),
													parallel(mv_did_key_fcra, mv_offenses_key_fcra, mv_spk_key_fcra),
													parallel(mv_did_QA, mv_fdid_QA, mv_offenses_QA, mv_spk_QA, mv_enh_QA, mv_zip_type_QA),
													parallel(mv_did_QA_fcra, mv_offenses_QA_fcra, mv_spk_QA_fcra),
													//Build Autokeys
													PRTE2_SexOffender.Proc_build_autokeys(filedate),
													parallel(cnt_so_spkpublic_fcra, cnt_so_offenses_fcra), 
													PerformUpdateOrNot,
												 );
RETURN build_keys;

END;

