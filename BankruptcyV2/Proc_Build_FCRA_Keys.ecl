// FCRA keys are now included as a part of fcra build.
// Bankrupt.Mac_BK_Daily_Spray

import RoxieKeyBuild,BankruptcyV3,VersionControl;
export Proc_Build_FCRA_Keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_main_full(true),'~thor_data400::key::bankruptcyv3::fcra::main::TMSID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::main::TMSID',bk_MID_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_search_full(true),'~thor_data400::key::bankruptcyv3::fcra::search::TMSID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::search::TMSID',bk_SID_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyv3_search_full_bip(true),'~thor_data400::key::bankruptcyv3::fcra::search::TMSID_linkIds','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::search::TMSID_linkIds',bk_SIDLKIDS_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_did(true),'~thor_data400::key::bankruptcyv3::fcra::DID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::DID',bk_DID_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_bdid(true),'~thor_data400::key::bankruptcyv3::fcra::BDID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::BDID',bk_BDID_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_ssn(true),'~thor_data400::key::bankruptcyv3::fcra::ssn','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::ssn',bk_ssn_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_fein(true),'~thor_data400::key::bankruptcyv3::fcra::TAXID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::taxID',bk_taxid_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_casenumber(true),'~thor_data400::key::bankruptcyv3::fcra::case_number','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::case_number',bk_case_number_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_ssn4st(true),'~thor_data400::key::bankruptcyv3::fcra::ssn4st','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::ssn4st',bk_ssn4st_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcyV3_trusteeidname(true),'~thor_data400::key::bankruptcyv3::fcra::trusteeidname','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::trusteeidname',bk_tid_fcra_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.key_bankruptcy_main_supp(true),'~thor_data400::key::bankruptcyv3::fcra::main::supplemental','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::main::supplemental',bk_fcra_main_supp_key_V3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BankruptcyV3.Key_bankruptcyV3_FCRA_bocashell,'~thor_data400::key::bankruptcyv3::fcra::bocashell','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::bocashell',bk_fcra_bocashell_key_V3);
VersionControl.macBuildNewLogicalKeyWithName(BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(filedate,,TRUE)	,BankruptcyV3.Keynames(filedate,,TRUE).WithdrawnStatus.new	,bk_withdrawnstatus_fcra_key_V3);


Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::main::TMSID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::main::TMSID',mv_mid_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::search::TMSID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::search::TMSID',mv_sid_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::search::TMSID_linkids','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::search::TMSID_linkids',mv_sidlkids_fcra_key_v3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::DID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::DID',mv_did_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::BDID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::BDID',mv_BDID_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::ssn','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::ssn',mv_ssn_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::TAXID','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::taxID',mv_taxid_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::case_number','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::case_number',mv_case_number_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::ssn4st','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::ssn4st',mv_ssn4st_fcra_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::main::supplemental','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::main::supplemental',mv_fcra_main_supp_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::bocashell','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::bocashell',mv_fcra_bocashell_key_V3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bankruptcyv3::fcra::trusteeidname','~thor_data400::key::bankruptcyv3::fcra::'+filedate+'::trusteeidname',mv_tid_fcra_key_V3);

autokeysFCRA 	:= BankruptcyV2.proc_build_autokeys(filedate, true);

buildkeys := sequential(parallel
								(	//bk_MID_key,bk_SID_key, bk_DID_key,bk_BDID_key,bk_ssn_key,bk_taxID_key,bk_case_number_key, bk_bocashell_did_key,
									//bk_MID_key_V3,bk_SID_key_V3,bk_bocashell_did_key_v3,bk_bocashell_key_v3,
									// Commenting these non-fcra keys out until we are ready to retire V1 & V2 versions of these keys
									// bk_DID_key_V3,bk_BDID_key_V3,bk_ssn_key_V3,bk_taxID_key_V3,bk_case_number_key_V3,
									bk_MID_fcra_key_V3,bk_SID_fcra_key_V3, bk_SIDLKIDS_fcra_key_V3, bk_DID_fcra_key_V3,bk_BDID_fcra_key_V3,bk_ssn_fcra_key_V3,bk_taxID_fcra_key_V3,bk_case_number_fcra_key_V3,
									bk_ssn4st_fcra_key_V3,bk_tid_fcra_key_V3,bk_fcra_main_supp_key_V3,bk_fcra_bocashell_key_V3,bk_withdrawnstatus_fcra_key_V3
									// ,bk_ssnmatch_key_V3
									/*fcra_casenum_key,fcra_did_key,fcra_DIDs_key,fcra_main_key,bshell_fcra_key*/
								), 
						parallel
								(
									//mv_mid_key,mv_sid_key, mv_DID_key,mv_BDID_key,mv_ssn_key,mv_taxID_key,mv_case_number_key,mv_bocashell_did_key,
									//mv_mid_key_V3,mv_sid_key_V3,mv_bocashell_did_key_v3,mv_bocashell_key_v3,
									// Commenting these non-fcra keys out until we are ready to retire V1 & V2 versions of these keys									
									// mv_DID_key_V3,mv_BDID_key_V3,mv_ssn_key_V3,mv_taxID_key_V3,mv_case_number_key_V3,
									mv_mid_fcra_key_V3,mv_sid_fcra_key_V3,mv_sidlkids_fcra_key_v3,mv_DID_fcra_key_V3,mv_BDID_fcra_key_V3,mv_ssn_fcra_key_V3,mv_taxID_fcra_key_V3,mv_case_number_fcra_key_V3,
									mv_ssn4st_fcra_key_V3,mv_tid_fcra_key_V3,mv_fcra_main_supp_key_V3,mv_fcra_bocashell_key_V3,
									BankruptcyV3.Promote(filedate,'key').BuildFiles.New2Built // WithdrawnStatus Keys
									// ,mv_ssnmatch_key_V3
									/*mv_fcra_casenum_key,mv_fcra_did_key,mv_fcra_DIDs_key,mv_fcra_main_key,mv_bshell_fcra_key*/
								)
				
						);

return parallel(buildkeys,autokeysFCRA);


end;