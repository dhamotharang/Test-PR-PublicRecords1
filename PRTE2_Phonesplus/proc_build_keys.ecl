IMPORT PRTE2_PhonesPlus, roxiekeybuild, ut, VersionControl, PRTE2_Common, _control, PRTE, AutoKey;

//Variables for DOPS and email are used in current PRTE process
EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS := is_running_in_prod AND NOT skipDOPS;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_phonesplus_did, Constants.KEY_PREFIX + 'phonesplusv2::did',Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::did',bld_DID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_phonesplus_did_roy, Constants.KEY_PREFIX + 'phonesplusv2_royalty::did',Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + filedate + '::did',bld_roy_DID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_phonesplus_fdids, Constants.KEY_PREFIX + 'phonesplusv2::fdids',Constants.KEY_PREFIX + 'phonesplusv2::' + filedate + '::fdids',bld_FDIDS_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_phonesplus_fdids_roy, Constants.KEY_PREFIX + 'phonesplusv2_royalty::fdids',Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + filedate +'::fdids',bld_roy_FDIDS_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_phonesplus_companyname, Constants.KEY_PREFIX + 'phonesplusv2::companyname',Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::companyname',bld_companyname_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_phonesplus_companyname_roy, Constants.KEY_PREFIX + 'phonesplusv2_royalty::companyname',Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + filedate +'::companyname',bld_roy_companyname_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_iverification_phone, Constants.KEY_PREFIX + 'iverification::phone',Constants.KEY_PREFIX + 'iverification::' + filedate +'::phone',bld_iverify_phone_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_iverification_did_phone, Constants.KEY_PREFIX + 'iverification::did_phone',Constants.KEY_PREFIX + 'iverification::' + filedate +'::did_phone',bld_iverify_did_phone_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_neustar_phone, Constants.KEY_PREFIX + 'neustar::phone',Constants.KEY_PREFIX + 'neustar::' + filedate +'::phone',bld_neustar_phone_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_neustar_hist, Constants.KEY_PREFIX + 'neustar::phone_history',Constants.KEY_PREFIX + 'neustar::' + filedate +'::phone_history',bld_neustar_phone_hist_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_scoring_address, Constants.KEY_PREFIX + 'phonesplus_scoring::address',Constants.KEY_PREFIX + 'phonesplus_scoring::' + filedate +'::address',bld_scoring_address_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhonesPlus.Keys.key_scoring_phone, Constants.KEY_PREFIX + 'phonesplus_scoring::phone',Constants.KEY_PREFIX + 'phonesplus_scoring::' + filedate +'::phone',bld_scoring_phone_key);

//Move keys to built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::did', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::did',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2_royalty::@version@::did', Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + filedate +'::did',mv_roy_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::fdids', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::fdids',mv_fdids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'phonesplusv2_royalty::@version@::fdids', Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + filedate +'::fdids',mv_roy_fdids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'phonesplusv2::@version@::companyname', Constants.KEY_PREFIX + 'phonesplusv2::' + filedate +'::companyname',mv_companyname_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'phonesplusv2_royalty::@version@::companyname', Constants.KEY_PREFIX + 'phonesplusv2_royalty::' + filedate +'::companyname',mv_roy_companyname_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'iverification::@version@::phone', Constants.KEY_PREFIX + 'iverification::' + filedate +'::phone',mv_iverify_phone_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'iverification::@version@::did_phone', Constants.KEY_PREFIX + 'iverification::' + filedate +'::did_phone',mv_iverify_did_phone_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'neustar::@version@::phone', Constants.KEY_PREFIX + 'neustar::' + filedate +'::phone',mv_neustar_phone_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX +  'neustar::@version@::phone_history', Constants.KEY_PREFIX + 'neustar::' + filedate +'::phone_history',mv_neustar_phone_hist_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplus_scoring::@version@::address', Constants.KEY_PREFIX + 'phonesplus_scoring::' + filedate +'::address',mv_scoring_address_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'phonesplus_scoring::@version@::phone', Constants.KEY_PREFIX + 'phonesplus_scoring::' + filedate +'::phone',mv_scoring_phone_key);

//Move keys to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::did','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2_royalty::@version@::did','Q', mv_roy_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::fdids','Q', mv_fdids_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2_royalty::@version@::fdids','Q', mv_roy_fdids_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2::@version@::companyname','Q', mv_companyname_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplusv2_royalty::@version@::companyname','Q', mv_roy_companyname_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'iverification::@version@::phone','Q', mv_iverify_phone_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'iverification::@version@::did_phone','Q', mv_iverify_did_phone_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'neustar::@version@::phone','Q', mv_neustar_phone_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'neustar::@version@::phone_history','Q', mv_neustar_phone_hist_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplus_scoring::@version@::address','Q', mv_scoring_address_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'phonesplus_scoring::@version@::phone','Q', mv_scoring_phone_QA);	

		//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail := IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		PerformUpdate := 		PRTE.UpdateVersion('PhonesPlusV2Keys',					//	Package name
																						 filedate,									//	Package version
																						 notifyEmail,								//	Who to email with specifics
																						 l_inloc:='B',							//	B = Boca, A = Alpharetta
																						 l_inenvment:='N',					//	N = Non-FCRA, F = FCRA
																						 l_includeboolean :='N'		  //	N = Do not also include boolean, Y = Include boolean, too
																						);
		PerformUpdateOrNot := IF(doDOPS,PerformUpdate,NoUpdate);
		//--------------------------------------------------------------------------------------
		
		RETURN sequential(
											parallel(bld_DID_key, bld_roy_DID_key, bld_FDIDS_key, bld_roy_FDIDS_key, bld_companyname_key, bld_roy_companyname_key,
																bld_iverify_phone_key, bld_iverify_did_phone_key, bld_neustar_phone_key, bld_neustar_phone_hist_key,
																bld_scoring_address_key, bld_scoring_phone_key),
											parallel(mv_DID_key, mv_roy_DID_key, mv_FDIDS_key, mv_roy_FDIDS_key, mv_companyname_key, mv_roy_companyname_key,
																mv_iverify_phone_key, mv_iverify_did_phone_key, mv_neustar_phone_key, mv_neustar_phone_hist_key,
																mv_scoring_address_key, mv_scoring_phone_key),
											parallel(mv_DID_QA, mv_roy_DID_QA, mv_FDIDS_QA, mv_roy_FDIDS_QA, mv_companyname_QA, mv_roy_companyname_QA,
																mv_iverify_phone_QA, mv_iverify_did_phone_QA, mv_neustar_phone_QA, mv_neustar_phone_hist_QA,
																mv_scoring_address_QA, mv_scoring_phone_QA),
											PRTE2_PhonesPlus.proc_build_autokeys(filedate);
											PerformUpdateOrNot);
		END;