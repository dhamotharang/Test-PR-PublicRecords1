import BankruptcyV2,roxiekeybuild,ingenix_natlprof,ut,autokey,doxie,doxie_files,bankruptcyv3;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_main_full(),'~thor_data400::key::bankruptcyv2::main::TMSID','~thor_data400::key::bankruptcyv2::'+filedate+'::main::TMSID',bk_MID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_search_full(),'~thor_data400::key::bankruptcyv2::search::TMSID','~thor_data400::key::bankruptcyv2::'+filedate+'::search::TMSID',bk_SID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_did(),'~thor_data400::key::bankruptcyv2::DID','~thor_data400::key::bankruptcyv2::'+filedate+'::DID',bk_DID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_bdid(),'~thor_data400::key::bankruptcyv2::BDID','~thor_data400::key::bankruptcyv2::'+filedate+'::BDID',bk_BDID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_ssn(),'~thor_data400::key::bankruptcyv2::ssn','~thor_data400::key::bankruptcyv2::'+filedate+'::ssn',bk_ssn_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_fein(),'~thor_data400::key::bankruptcyv2::TAXID','~thor_data400::key::bankruptcyv2::'+filedate+'::taxID',bk_taxid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_casenumber(),'~thor_data400::key::bankruptcyv2::case_number','~thor_data400::key::bankruptcyv2::'+filedate+'::case_number',bk_case_number_key);
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.Key_BocaShell_bkruptV2(),'~thor_data400::key::bankruptcyv2::bocashell_did','~thor_data400::key::bankruptcyv2::'+filedate+'::bocashell_did',bk_bocashell_did_key);


// Commenting these non-fcra/non payload keys out until we are ready to retire V1 & V2 versions of these keys

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_main_full(),'~thor_data400::key::bankruptcyv3::main::TMSID','~thor_data400::key::bankruptcyv3::'+filedate+'::main::TMSID',bk_MID_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_search_full(),'~thor_data400::key::bankruptcyv3::search::TMSID','~thor_data400::key::bankruptcyv3::'+filedate+'::search::TMSID',bk_SID_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.Key_BocaShell_bkruptV3(),'~thor_data400::key::bankruptcyv3::bocashell_did','~thor_data400::key::bankruptcyv3::'+filedate+'::bocashell_did',bk_bocashell_did_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.Key_bankruptcyV3_bocashell,'~thor_data400::key::bankruptcyv3::bocashell','~thor_data400::key::bankruptcyv3::'+filedate+'::bocashell',bk_bocashell_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcy_main_supp(),'~thor_data400::key::bankruptcyv3::main::supplemental','~thor_data400::key::bankruptcyv3::'+filedate+'::main::supplemental',bk_main_supp_key_V3);

// Adding this key in as a test for timing impact to the build
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.Key_bankruptcyV3_ssnmatch(),'~thor_data400::key::bankruptcyv3::ssnmatch','~thor_data400::key::bankruptcyv3::'+filedate+'::ssnmatch',bk_ssnmatch_key_V3);

// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_did(),'~thor_data400::key::bankruptcyv3::DID','~thor_data400::key::bankruptcyv3::'+filedate+'::DID',bk_DID_key_V3);
// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_bdid(),'~thor_data400::key::bankruptcyv3::BDID','~thor_data400::key::bankruptcyv3::'+filedate+'::BDID',bk_BDID_key_V3);
// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_ssn(),'~thor_data400::key::bankruptcyv3::ssn','~thor_data400::key::bankruptcyv3::'+filedate+'::ssn',bk_ssn_key_V3);
// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_fein(),'~thor_data400::key::bankruptcyv3::TAXID','~thor_data400::key::bankruptcyv3::'+filedate+'::taxID',bk_taxid_key_V3);
// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_casenumber(),'~thor_data400::key::bankruptcyv3::case_number','~thor_data400::ey::bankruptcyv3::'+filedate+'::case_number',bk_case_number_key_V3);


Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::main::TMSID','~thor_data400::key::bankruptcyv2::'+filedate+'::main::TMSID',mv_mid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::search::TMSID','~thor_data400::key::bankruptcyv2::'+filedate+'::search::TMSID',mv_sid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::DID','~thor_data400::key::bankruptcyv2::'+filedate+'::DID',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::BDID','~thor_data400::key::bankruptcyv2::'+filedate+'::BDID',mv_BDID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::ssn','~thor_data400::key::bankruptcyv2::'+filedate+'::ssn',mv_ssn_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::TAXID','~thor_data400::key::bankruptcyv2::'+filedate+'::taxID',mv_taxid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::case_number','~thor_data400::key::bankruptcyv2::'+filedate+'::case_number',mv_case_number_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::bocashell_did','~thor_data400::key::bankruptcyv2::'+filedate+'::bocashell_did',mv_bocashell_did_key);

// Commenting these non-fcra/non payload keys out until we are ready to retire V1 & V2 versions of these keys

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::main::TMSID','~thor_data400::key::bankruptcyv3::'+filedate+'::main::TMSID',mv_mid_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::search::TMSID','~thor_data400::key::bankruptcyv3::'+filedate+'::search::TMSID',mv_sid_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::bocashell_did','~thor_data400::key::bankruptcyv3::'+filedate+'::bocashell_did',mv_bocashell_did_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::bocashell','~thor_data400::key::bankruptcyv3::'+filedate+'::bocashell',mv_bocashell_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::main::supplemental','~thor_data400::key::bankruptcyv3::'+filedate+'::main::supplemental',mv_main_supp_key_V3);

// Adding this key in as a test for timing impact to the build
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::ssnmatch','~thor_data400::key::bankruptcyv3::'+filedate+'::ssnmatch',mv_ssnmatch_key_V3);

// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::DID','~thor_data400::key::bankruptcyv3::'+filedate+'::DID',mv_did_key_V3);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::BDID','~thor_data400::key::bankruptcyv3::'+filedate+'::BDID',mv_BDID_key_V3);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::ssn','~thor_data400::key::bankruptcyv3::'+filedate+'::ssn',mv_ssn_key_V3);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::TAXID','~thor_data400::key::bankruptcyv3::'+filedate+'::taxID',mv_taxid_key_V3);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::case_number','~thor_data400::key::bankruptcyv3::'+filedate+'::case_number',mv_case_number_key_V3);


/*
// FCRA keys were removed as they will be same as V1 FCRA keys. 

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_casenumber_FCRA,'~thor_data400::key::BankruptcyV2::fcra::case_number','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::case_number',fcra_casenum_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_did_FCRA,'~thor_data400::key::bankruptcyv2::fcra::DID','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::DId',fcra_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_didslim_FCRA,'~thor_Data400::key::BankruptcyV2::fcra::didslim','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::DIDslim',fcra_DIDs_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_bankruptcy_main_full_FCRA,'~thor_data400::key::bankruptcyv2::fcra::main','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::main',fcra_main_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV2.key_BocaShell_BankruptcyV2_FCRA,'~thor_data400::key::bankruptcyv2::fcra::bocashell_did_','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::bocashell_did',bshell_fcra_key);


Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::BankruptcyV2::fcra::case_number','~thor_data400::key::BankruptcyV2::fcra::'+filedate+'::case_number',mv_fcra_casenum_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::fcra::DID','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::did',mv_fcra_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::BankruptcyV2::fcra::didslim','~thor_Data400::key::BankruptcyV2::fcra::'+filedate+'::DIDslim',mv_fcra_DIDs_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::fcra::main','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::main',mv_fcra_main_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv2::fcra::bocashell_did','~thor_data400::key::bankruptcyv2::fcra::'+filedate+'::bocashell_did',mv_bshell_fcra_key);

*/


build_keys := parallel
								(	bk_MID_key,bk_SID_key, bk_DID_key,bk_BDID_key,bk_ssn_key,bk_taxID_key,bk_case_number_key, 
									//bk_bocashell_did_key,
									bk_MID_key_V3,bk_SID_key_V3,bk_bocashell_did_key_v3,bk_bocashell_key_v3,bk_main_supp_key_v3
									// Commenting these non-fcra keys out until we are ready to retire V1 & V2 versions of these keys
									// bk_DID_key_V3,bk_BDID_key_V3,bk_ssn_key_V3,bk_taxID_key_V3,bk_case_number_key_V3,
									// bk_MID_fcra_key_V3,bk_SID_fcra_key_V3, bk_DID_fcra_key_V3,bk_BDID_fcra_key_V3,bk_ssn_fcra_key_V3,bk_taxID_fcra_key_V3,bk_case_number_fcra_key_V3,
									// bk_ssn4st_fcra_key_V3
									,bk_ssnmatch_key_V3
									/*fcra_casenum_key,fcra_did_key,fcra_DIDs_key,fcra_main_key,bshell_fcra_key*/
								); 
move_keys :=		parallel
								(
									mv_mid_key,mv_sid_key, mv_DID_key,mv_BDID_key,mv_ssn_key,mv_taxID_key,mv_case_number_key,
									//mv_bocashell_did_key,
									mv_mid_key_V3,mv_sid_key_V3,mv_bocashell_did_key_v3,mv_bocashell_key_v3,mv_main_supp_key_v3
									// Commenting these non-fcra keys out until we are ready to retire V1 & V2 versions of these keys									
									// mv_DID_key_V3,mv_BDID_key_V3,mv_ssn_key_V3,mv_taxID_key_V3,mv_case_number_key_V3,
									// mv_mid_fcra_key_V3,mv_sid_fcra_key_V3,mv_DID_fcra_key_V3,mv_BDID_fcra_key_V3,mv_ssn_fcra_key_V3,mv_taxID_fcra_key_V3,mv_case_number_fcra_key_V3,
									// mv_ssn4st_fcra_key_V3
									,mv_ssnmatch_key_V3
									/*mv_fcra_casenum_key,mv_fcra_did_key,mv_fcra_DIDs_key,mv_fcra_main_key,mv_bshell_fcra_key*/
								);
						


// Build Autokeys

autokeys 		:= BankruptcyV2.proc_build_autokeys(filedate);

// autokeysFCRA 	:= BankruptcyV2.proc_build_autokeys(filedate, true);

return sequential(parallel(build_keys,autokeys/*,autokeysFCRA*/),move_keys);

end;


 
 
 
 