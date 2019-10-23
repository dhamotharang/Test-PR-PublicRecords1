IMPORT PRTE, PRTE2_Common, PRTE2_Bankruptcy, roxiekeybuild, ut, autokey, VersionControl, _control, strata;

EXPORT proc_build_keys (string filedate) := FUNCTION

	//BankruptcyV2 keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_bdid, Constants.KEY_PREFIX + 'bankruptcyv2::bdid', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::bdid', v2_bdid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_case_number, Constants.KEY_PREFIX + 'bankruptcyv2::case_number', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::case_number', v2_case_number_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_did, Constants.KEY_PREFIX + 'bankruptcyv2::did', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::did', v2_did_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_main_tmsid, Constants.KEY_PREFIX + 'bankruptcyv2::main::tmsid', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::main::tmsid', v2_main_tmsid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_search_tmsid, Constants.KEY_PREFIX + 'bankruptcyv2::search::tmsid', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::search::tmsid', v2_search_tmsid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_search_linkids.key, Constants.KEY_PREFIX + 'bankruptcyv2::search_v3::linkids', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::search_v3::linkids', v2_searchv3_linkids_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_ssn, Constants.KEY_PREFIX + 'bankruptcyv2::ssn', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::ssn', v2_ssn_key);
	
	//BankruptcyV3 keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_search_tmsid(), Constants.KEY_PREFIX + 'bankruptcyv3::search::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::search::tmsid', v3_search_tmsid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_main_tmsid(), Constants.KEY_PREFIX + 'bankruptcyv3::main::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::main::tmsid', v3_main_tmsid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_main_supplement(), Constants.KEY_PREFIX + 'bankruptcyv3::main::supplemental', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::main::supplemental', v3_supplemental_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_ssn4st(), Constants.KEY_PREFIX + 'bankruptcyv3::ssn4st', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::ssn4st', v3_ssn4st_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_ssnmatch(), Constants.KEY_PREFIX + 'bankruptcyv3::ssnmatch', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::ssnmatch', v3_ssnmatch_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_trusteeidname(), Constants.KEY_PREFIX + 'bankruptcyv3::trusteeidname', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::trusteeidname', v3_trusteeidname_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_search_v3_linkids().KeyV3, Constants.KEY_PREFIX + 'bankruptcyv3::search_v3::linkids', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::search_v3::linkids', v3_searchv3_linkids_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_search_tmsid_linkids(), Constants.KEY_PREFIX + 'bankruptcyv3::search::tmsid_linkids', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::search::tmsid_linkids', v3_search_tmsid_linkids_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_bdid(), Constants.KEY_PREFIX + 'bankruptcyv3::bdid', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::bdid', v3_bdid_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_did(), Constants.KEY_PREFIX + 'bankruptcyv3::did', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::did', v3_did_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_case_number(), Constants.KEY_PREFIX + 'bankruptcyv3::case_number', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::case_number', v3_case_number_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_ssn(), Constants.KEY_PREFIX + 'bankruptcyv3::ssn', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::ssn', v3_ssn_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyV3_withdrawnstatus(), Constants.KEY_PREFIX + 'bankruptcyv3::withdrawnstatus', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::withdrawnstatus', v3_withdrawnstatus_key);
	
		
	//Bankruptcy FCRA keys
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_search_tmsid(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::search::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::search::tmsid', v3_search_tmsid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_main_tmsid(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::main::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::main::tmsid', v3_main_tmsid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_main_supplement(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::main::supplemental', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::main::supplemental', v3_supplemental_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_ssn4st(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::ssn4st', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::ssn4st', v3_ssn4st_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_ssnmatch(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::ssnmatch', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::ssnmatch', v3_ssnmatch_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_trusteeidname(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::trusteeidname', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::trusteeidname', v3_trusteeidname_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv2_search_v3_linkids(TRUE).KeyV3, Constants.KEY_PREFIX + 'bankruptcyv3::fcra::search_v3::linkids', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::search_v3::linkids', v3_searchv3_linkids_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_search_tmsid_linkids(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::search::tmsid_linkids', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::search::tmsid_linkids', v3_search_tmsid_linkids_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_bdid(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::bdid', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::bdid', v3_bdid_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_did(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::did', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::did', v3_did_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_case_number(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::case_number', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::case_number', v3_case_number_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyv3_ssn(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::ssn', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::ssn', v3_ssn_key_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Bankruptcy.Keys.key_bankruptcyV3_withdrawnstatus(TRUE), Constants.KEY_PREFIX + 'bankruptcyv3::fcra::withdrawnstatus', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::withdrawnstatus', v3_withdrawnstatus_key_fcra);
	
	
	
	//Move keys
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::bdid', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::bdid',mv_v2_bdid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::case_number', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::case_number',mv_v2_case_number_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::did', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::did',mv_v2_did_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::main::tmsid', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::main::tmsid',mv_v2_main_tmsid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::search::tmsid', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::search::tmsid',mv_v2_search_tmsid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::search_v3::linkids', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::search_v3::linkids',mv_v2_searchv3_linkids_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::ssn', Constants.KEY_PREFIX + 'bankruptcyv2::' + filedate +'::ssn',mv_v2_ssn_key);
	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::search::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::search::tmsid',mv_v3_search_tmsid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::main::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::main::tmsid',mv_v3_main_tmsid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::main::supplemental', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::main::supplemental',mv_v3_supplemental_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::ssn4st', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::ssn4st',mv_v3_ssn4st_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::ssnmatch', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::ssnmatch',mv_v3_ssnmatch_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::trusteeidname', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::trusteeidname',mv_v3_trusteeidname_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::search_v3::linkids', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::search_v3::linkids',mv_v3_searchv3_linkids_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::search::tmsid_linkids', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::search::tmsid_linkids',mv_v3_search_tmsid_linkids_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::bdid', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::bdid',mv_v3_bdid_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::did', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::did',mv_v3_did_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::case_number', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::case_number',mv_v3_case_number_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::ssn', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::ssn',mv_v3_ssn_key);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::withdrawnstatus', Constants.KEY_PREFIX + 'bankruptcyv3::' + filedate +'::withdrawnstatus',mv_v3_withdrawnstatus_key);
	
	
	//Move FCRA Keys
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::search::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::search::tmsid',mv_v3_search_tmsid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::main::tmsid', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::main::tmsid',mv_v3_main_tmsid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::main::supplemental', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::main::supplemental',mv_v3_supplemental_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::ssn4st', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::ssn4st',mv_v3_ssn4st_key_fcra);
	//Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::ssnmatch', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::ssnmatch',mv_v3_ssnmatch_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::trusteeidname', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::trusteeidname',mv_v3_trusteeidname_key_fcra);
	//Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::search_v3::linkids', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::search_v3::linkids',mv_v3_searchv3_linkids_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::search::tmsid_linkids', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::search::tmsid_linkids',mv_v3_search_tmsid_linkids_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::bdid', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::bdid',mv_v3_bdid_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::did', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::did',mv_v3_did_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::case_number', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::case_number',mv_v3_case_number_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::ssn', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::ssn',mv_v3_ssn_key_fcra);
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::withdrawnstatus', Constants.KEY_PREFIX + 'bankruptcyv3::fcra::' + filedate +'::withdrawnstatus',mv_v3_withdrawnstatus_key_fcra);
	
	
	
	//Move to QA
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::bdid','Q', mv_v2_bdid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::case_number','Q', mv_v2_case_number_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::did','Q', mv_v2_did_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::main::tmsid','Q', mv_v2_main_tmsid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::search::tmsid','Q', mv_v2_search_tmsid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::search_v3::linkids','Q', mv_v2_searchv3_linkids_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv2::@version@::ssn','Q', mv_v2_ssn_QA);
	
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::search::tmsid','Q', mv_v3_search_tmsid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::main::tmsid','Q', mv_v3_main_tmsid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::main::supplemental','Q', mv_v3_supplemental_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::ssn4st','Q', mv_v3_ssn4st_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::ssnmatch','Q', mv_v3_ssnmatch_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::trusteeidname','Q', mv_v3_trusteeidname_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::search_v3::linkids','Q', mv_v3_searchv3_linkids_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::search::tmsid_linkids','Q', mv_v3_search_tmsid_linkids_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::bdid','Q', mv_v3_bdid_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::did','Q', mv_v3_did_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::case_number','Q', mv_v3_case_number_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::ssn','Q', mv_v3_ssn_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::@version@::withdrawnstatus','Q',mv_v3_withdrawnstatus_QA);
	
	
	//Move FCRA to QA
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::search::tmsid','Q', mv_v3_search_tmsid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::main::tmsid','Q', mv_v3_main_tmsid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::main::supplemental','Q', mv_v3_supplemental_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::ssn4st','Q', mv_v3_ssn4st_QA_fcra);
	//RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::ssnmatch','Q', mv_v3_ssnmatch_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::trusteeidname','Q', mv_v3_trusteeidname_QA_fcra);
	//RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::search_v3::linkids','Q', mv_v3_searchv3_linkids_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::search::tmsid_linkids','Q', mv_v3_search_tmsid_linkids_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::bdid','Q', mv_v3_bdid_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::did','Q', mv_v3_did_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::case_number','Q', mv_v3_case_number_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::ssn','Q', mv_v3_ssn_QA_fcra);
	RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + 'bankruptcyv3::fcra::@version@::withdrawnstatus','Q',mv_v3_withdrawnstatus_QA_fcra);
	
	
	//FCRA Depreciation Stats
		//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcyv3::fcra::main::tmsid_qa
	cnt_fcra_main_tmsid := OUTPUT(strata.macf_pops(prte2_bankruptcy.keys.key_bankruptcyv3_main_tmsid(true),,,,,,FALSE,
																														['assets','complaint_deadline','confheardate','datereclosed',
																														 'liabilities','planconfdate']));
	//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcyv3::fcra::search::tmsid_qa
	cnt_fcra_srch_tmsid := OUTPUT(strata.macf_pops(prte2_bankruptcy.keys.key_bankruptcyv3_search_tmsid(true),,,,,,FALSE,
																														['delete_flag','holdcase','tax_id']));
	//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcyv3::fcra::search::tmsid_linkids_qa
	cnt_fcra_srch_tmsid_linkids := OUTPUT(strata.macf_pops(prte2_bankruptcy.keys.key_bankruptcyv3_search_tmsid_linkids(true),,,,,,FALSE,
																														['delete_flag','holdcase','tax_id']));
	//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcy::autokey::fcra::payload_qa
	// cnt_fcra_autokey_payload := OUTPUT(strata.macf_pops(,,,,,,FALSE,['tax_id']));
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops					:= PRTE.UpdateVersion('BankruptcyV2Keys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',  l_inenvment:='N',l_includeboolean := 'N' );
	updatedops_fcra			:= PRTE.UpdateVersion('FCRA_BankruptcyKeys', filedate, _control.MyInfo.EmailAddressNormal,l_inloc:='B',  l_inenvment:='F',l_includeboolean := 'N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,parallel(updatedops,updatedops_fcra),NoUpdate);
	
	build_keys := SEQUENTIAL(
													parallel(v2_bdid_key,v2_case_number_key,v2_did_key,v2_main_tmsid_key,v2_search_tmsid_key,v2_searchv3_linkids_key,v2_ssn_key),
													parallel(v3_search_tmsid_key,v3_main_tmsid_key,v3_supplemental_key,v3_ssn4st_key,v3_ssnmatch_key,v3_trusteeidname_key,v3_searchv3_linkids_key,
																	v3_search_tmsid_linkids_key,v3_bdid_key,v3_did_key,v3_case_number_key,v3_ssn_key,v3_withdrawnstatus_key),
													parallel(v3_search_tmsid_key_fcra,v3_main_tmsid_key_fcra,v3_supplemental_key_fcra,v3_ssn4st_key_fcra,/*v3_ssnmatch_key_fcra,*/v3_trusteeidname_key_fcra,
																	/*v3_searchv3_linkids_key_fcra,*/v3_search_tmsid_linkids_key_fcra,v3_bdid_key_fcra,v3_did_key_fcra,v3_case_number_key_fcra,v3_ssn_key_fcra,
																	v3_withdrawnstatus_key_fcra),
													parallel(mv_v2_bdid_key,mv_v2_case_number_key,mv_v2_did_key,mv_v2_main_tmsid_key,mv_v2_search_tmsid_key,mv_v2_searchv3_linkids_key,mv_v2_ssn_key),
													parallel(mv_v3_search_tmsid_key,mv_v3_main_tmsid_key,mv_v3_supplemental_key,mv_v3_ssn4st_key,mv_v3_ssnmatch_key,mv_v3_trusteeidname_key,
																	mv_v3_searchv3_linkids_key,mv_v3_search_tmsid_linkids_key,mv_v3_bdid_key,mv_v3_did_key,mv_v3_case_number_key,mv_v3_ssn_key,
																	mv_v3_withdrawnstatus_key),
													parallel(mv_v3_search_tmsid_key_fcra,mv_v3_main_tmsid_key_fcra,mv_v3_supplemental_key_fcra,mv_v3_ssn4st_key_fcra,/*mv_v3_ssnmatch_key_fcra,*/mv_v3_trusteeidname_key_fcra,
																	/*mv_v3_searchv3_linkids_key_fcra,*/mv_v3_search_tmsid_linkids_key_fcra,mv_v3_bdid_key_fcra,mv_v3_did_key_fcra,mv_v3_case_number_key_fcra,mv_v3_ssn_key_fcra,
																	mv_v3_withdrawnstatus_key_fcra),
													parallel(mv_v2_bdid_QA,mv_v2_case_number_QA,mv_v2_did_QA,mv_v2_main_tmsid_QA,mv_v2_search_tmsid_QA,mv_v2_searchv3_linkids_QA,mv_v2_ssn_QA),
													parallel(mv_v3_search_tmsid_QA,mv_v3_main_tmsid_QA,mv_v3_supplemental_QA,mv_v3_ssn4st_QA,mv_v3_ssnmatch_QA,mv_v3_trusteeidname_QA,
																	mv_v3_searchv3_linkids_QA,mv_v3_search_tmsid_linkids_QA,mv_v3_bdid_QA,mv_v3_did_QA,mv_v3_case_number_QA,mv_v3_ssn_QA,
																	mv_v3_withdrawnstatus_QA),
													parallel(mv_v3_search_tmsid_QA_fcra,mv_v3_main_tmsid_QA_fcra,mv_v3_supplemental_QA_fcra,mv_v3_ssn4st_QA_fcra,/*mv_v3_ssnmatch_QA_fcra,*/mv_v3_trusteeidname_QA_fcra,
																	/*mv_v3_searchv3_linkids_QA_fcra,*/mv_v3_search_tmsid_linkids_QA_fcra,mv_v3_bdid_QA_fcra,mv_v3_did_QA_fcra,mv_v3_case_number_QA_fcra,mv_v3_ssn_QA_fcra,
																	mv_v3_withdrawnstatus_QA_fcra),
													
													//Build Autokeys
													PRTE2_Bankruptcy.Keys.bld_autokeys(filedate,),
													PRTE2_Bankruptcy.Keys.bld_autokeys(filedate,TRUE),
													PerformUpdateOrNot,
													parallel(cnt_fcra_main_tmsid, cnt_fcra_srch_tmsid, cnt_fcra_srch_tmsid_linkids)
												 );
RETURN build_keys;

END;
	
	