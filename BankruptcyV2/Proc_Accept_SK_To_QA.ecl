import ut, autokey,	BankruptcyV3;
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::main::TMSID',  'Q', mv_mid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::search::TMSID', 'Q',mv_sid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::DID', 'Q', mv_did_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::BDID',  'Q',mv_bdid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::ssn',  'Q',mv_ssn_key, 2);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::TAXID', 'Q', mv_taxid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::case_number', 'Q',mv_case_number_key, 2);
//ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::bocashell_did', 'Q',mv_bocashell_did_key, 2);

// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::main::TMSID','Q',mv_mid_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::search::TMSID','Q',mv_sid_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::DID','Q',mv_did_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::BDID','Q',mv_BDID_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::ssn','Q',mv_ssn_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::TAXID','Q',mv_taxid_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::case_number','Q',mv_case_number_fcra_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::ssn4st','Q',mv_ssn4st_fcra_key_v3);

// Commenting these non-fcra/non-payload keys out until we are ready to retire V1 & V2 versions of these keys

ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::main::TMSID','Q',mv_mid_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::search::TMSID','Q',mv_sid_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::search::tmsid_linkids', 'Q',mv_sidlkids_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::bocashell_did','Q',mv_bocashell_did_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::bocashell','Q',mv_bocashell_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::main::supplemental','Q',mv_supp_key_v3);

// Adding V3 Keys to the build
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::ssnmatch','Q',mv_ssnmatch_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::ssn4st','Q',mv_ssn4st_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::trusteeidname','Q',mv_tid_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::DID','Q',mv_did_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::BDID','Q',mv_BDID_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::ssn','Q',mv_ssn_key_v3);
// ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::TAXID','Q',mv_taxid_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::case_number','Q',mv_case_number_key_v3);

//***  Move xlinkid keys to QA.
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::search_v3::linkids', 'Q',mv_linkid_key);

//***  Move V3 xlinkid keys to QA.
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::search_v3::linkids', 'Q',mv_linkid_key_v3);

/*
// FCRA keys
ut.mac_sk_move_v2('~thor_data400::key::BankruptcyV2::fcra::bocashell_did','Q',mv_fcra_bshell_did_key,2);
ut.mac_sk_move_v2('~thor_data400::key::BankruptcyV2::fcra::DID','Q',mv_fcra_did_key,2);
ut.mac_sk_move_v2('~thor_Data400::key::BankruptcyV2::fcra::didslim','Q',mv_fcra_dids_key,2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::fcra::main','Q',mv_fcra_main_key,2);
ut.mac_sk_move_v2('~thor_data400::key::BankruptcyV2::fcra::case_number','Q',mv_fcra_case_key,2);

*/

export Proc_Accept_SK_To_QA :=  parallel(	mv_mid_key,mv_sid_key,mv_did_key,mv_bdid_key,mv_ssn_key,/*mv_taxid_key,*/mv_case_number_key,
											//mv_bocashell_did_key,
											// mv_mid_fcra_key_v3,mv_sid_fcra_key_v3,mv_did_fcra_key_v3,mv_BDID_fcra_key_v3,mv_ssn_fcra_key_v3,mv_taxid_fcra_key_v3,mv_case_number_fcra_key_v3,mv_ssn4st_fcra_key_v3,											// Commenting these non-fcra keys out until we are ready to retire V1 & V2 versions of these keys
											mv_mid_key_v3,mv_sid_key_v3,mv_sidlkids_key_v3,mv_bocashell_did_key_v3,mv_bocashell_key_v3,mv_ssnmatch_key_v3,mv_ssn4st_key_v3,mv_supp_key_v3,mv_tid_key_v3,mv_linkid_key,mv_linkid_key_v3
											,mv_did_key_v3,mv_BDID_key_v3,mv_ssn_key_v3,/*mv_taxid_key_v3,*/mv_case_number_key_v3
											,BankruptcyV3.Promote(,'key').BuildFiles.Built2QA // WithdrawnStatus Keys
											/*,mv_fcra_bshell_did_key,mv_fcra_did_key,mv_fcra_dids_key,mv_fcra_main_key,mv_fcra_case_key*/
											);					  
					  