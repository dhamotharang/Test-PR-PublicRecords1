import ut, autokey, BankruptcyV3;
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::main::TMSID',  'Q', mv_mid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::search::TMSID', 'Q',mv_sid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::DID', 'Q', mv_did_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::BDID',  'Q',mv_bdid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::ssn',  'Q',mv_ssn_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::TAXID', 'Q', mv_taxid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::case_number', 'Q',mv_case_number_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv2::bocashell_did', 'Q',mv_bocashell_did_key, 2);

ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::main::TMSID','Q',mv_mid_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::search::TMSID','Q',mv_sid_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::search::tmsid_linkids', 'Q',mv_sidlkids_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::DID','Q',mv_did_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::BDID','Q',mv_BDID_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::ssn','Q',mv_ssn_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::TAXID','Q',mv_taxid_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::case_number','Q',mv_case_number_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::ssn4st','Q',mv_ssn4st_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::main::supplemental','Q',mv_supp_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::bocashell','Q',mv_bocashell_fcra_key_v3);
ut.mac_sk_move_v2('~thor_data400::key::bankruptcyv3::fcra::trusteeidname','Q',mv_tid_fcra_key_v3);



export Proc_Accept_FCRA_SK_To_QA := parallel(	mv_mid_fcra_key_v3,mv_sid_fcra_key_v3,mv_sidlkids_fcra_key_v3,
																							mv_did_fcra_key_v3,mv_BDID_fcra_key_v3,mv_ssn_fcra_key_v3,
																							mv_taxid_fcra_key_v3,mv_case_number_fcra_key_v3,
																							mv_ssn4st_fcra_key_v3,mv_supp_fcra_key_v3,
																							mv_bocashell_fcra_key_v3,mv_tid_fcra_key_v3,
																							BankruptcyV3.Promote(,'key').BuildFiles.Built2QA
																						);