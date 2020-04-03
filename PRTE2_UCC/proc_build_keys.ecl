IMPORT ut, RoxieKeyBuild, AutoKeyB2, PRTE2_UCC, PRTE2_Common, PRTE, _control, dops, prte2, orbit3;

EXPORT proc_build_keys (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS := is_running_in_prod AND NOT skipDOPS;

// Process NON-FCRA KEYS																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_did,Constants.KEY_PREFIX + 'did',Constants.KEY_PREFIX + filedate +'::did',did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_bdid,Constants.KEY_PREFIX + 'bdid',Constants.KEY_PREFIX + filedate +'::bdid',bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_rmsid_main(),Constants.KEY_PREFIX + 'main_rmsid',Constants.KEY_PREFIX + filedate +'::main_rmsid',main_rmsid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_rmsid_party(),Constants.KEY_PREFIX + 'party_rmsid',Constants.KEY_PREFIX + filedate +'::party_rmsid',party_rmsid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_filing_number,Constants.KEY_PREFIX + 'Filing_number',Constants.KEY_PREFIX + filedate +'::filing_number',filing_number_key); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_RMSID,Constants.KEY_PREFIX + 'RMSID',Constants.KEY_PREFIX + filedate +'::RMSID',rmsid_key); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_did_w_type(),Constants.KEY_PREFIX + 'did_w_type',Constants.KEY_PREFIX + filedate +'::did_w_type',did_w_type_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_bdid_w_type,Constants.KEY_PREFIX + 'bdid_w_type',Constants.KEY_PREFIX + filedate +'::bdid_w_type',bdid_w_type_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_LinkIds.key,Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkids_key);


//Move NON_FCRA
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::did',Constants.KEY_PREFIX + filedate +'::did',did_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::bdid',Constants.KEY_PREFIX + filedate +'::bdid',bdid_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::main_rmsid',Constants.KEY_PREFIX + filedate +'::main_rmsid',main_rmsid_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::party_rmsid',Constants.KEY_PREFIX + filedate +'::party_rmsid',party_rmsid_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::Filing_number',Constants.KEY_PREFIX + filedate +'::filing_number',filing_number_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::RMSID',Constants.KEY_PREFIX + filedate +'::RMSID',RMSID_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::did_w_type',Constants.KEY_PREFIX + filedate +'::did_w_type',did_w_type_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::bdid_w_type',Constants.KEY_PREFIX + filedate +'::bdid_w_type',bdid_w_type_mv);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + '@version@::linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkids_mv);


//Move NON_FCRA Keys to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q',did_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q',bdid_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::main_rmsid','Q',main_rmsid_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::party_rmsid','Q',party_rmsid_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::Filing_number','Q',Filing_number_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::RMSID','Q',RMSID_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did_w_type','Q',did_w_type_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid_w_type','Q',bdid_w_type_mv_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q',linkids_mv_QA);

// Process FCRA KEYS		
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_rmsid_main(true),Constants.KEY_PREFIX + 'fcra::main_rmsid',Constants.KEY_PREFIX + filedate + '::fcra::main_rmsid',main_rmsid_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_rmsid_party(true),Constants.KEY_PREFIX + 'fcra::party_rmsid',Constants.KEY_PREFIX + filedate + '::fcra::party_rmsid',party_rmsid_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_did_w_type(true),Constants.KEY_PREFIX + 'fcra::did_w_type',Constants.KEY_PREFIX + filedate + '::fcra::did_w_type',did_w_type_fcra);

//Move FCRA
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main_rmsid',Constants.KEY_PREFIX + filedate + '::fcra::main_rmsid',main_rmsid_mv_fcra);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::party_rmsid',Constants.KEY_PREFIX + filedate + '::fcra::party_rmsid',party_rmsid_mv_fcra);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did_w_type',Constants.KEY_PREFIX + filedate + '::fcra::did_w_type',did_w_type_mv_fcra);

//Move FCRA to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::main_rmsid','Q', main_rmsid_mv_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::party_rmsid','Q', party_rmsid_mv_QA_fcra);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'fcra::' + '@version@::did_w_type','Q', did_w_type_mv_QA_fcra);

	key_validations :=  parallel(output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation')),
                   output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,Constants.fcra_dops_name, 'F'), named(Constants.fcra_dops_name+'Validation')));	
	
	//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('UCCV2Keys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_UCCKeys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='F',l_includeboolean := 'N');
		PerformUpdateOrNot 	:= IF(doDOPS,parallel(updatedops,updatedops_fcra),NoUpdate);
		//--------------------------------------------------------------------------------------

create_orbit_build := parallel(
																Orbit3.proc_Orbit3_CreateBuild('PRTE - UCC', filedate, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal),
																Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_UCC', filedate, 'F', true, true, false,  _control.MyInfo.EmailAddressNormal),
															);

build_keys := sequential(
													parallel(did_key, bdid_key, main_rmsid_key, party_rmsid_key, filing_number_key, rmsid_key,
																	did_w_type_key, bdid_w_type_key, linkids_key),
													parallel(main_rmsid_fcra, party_rmsid_fcra, did_w_type_fcra),
													parallel(did_mv, bdid_mv, main_rmsid_mv, party_rmsid_mv, filing_number_mv, rmsid_mv,
																	did_w_type_mv, bdid_w_type_mv, linkids_mv),
													parallel(main_rmsid_mv_fcra, party_rmsid_mv_fcra, did_w_type_mv_fcra),
													parallel(did_mv_QA, bdid_mv_QA, main_rmsid_mv_QA, party_rmsid_mv_QA, filing_number_mv_QA, rmsid_mv_QA,
																	did_w_type_mv_QA, bdid_w_type_mv_QA, linkids_mv_QA),
													parallel(main_rmsid_mv_QA_fcra, party_rmsid_mv_QA_fcra, did_w_type_mv_QA_fcra),
													//Build Autokeys
													PRTE2_UCC.Keys.proc_build_autokey(filedate),
													PerformUpdateOrNot,
													key_validations,
													create_orbit_build,
													NOTIFY('UCC PRTE KEY BUILD COMPLETE','*')
												 );
RETURN build_keys;

END;