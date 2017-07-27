import ut, autokey;
ut.mac_sk_move_v2('~thor_data400::key::liensv2::main::tmsid.rmsid',  'Q', mv_mid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::party::tmsid.rmsid', 'Q',mv_pid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::did', 'Q', mv_did_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::bdid',  'Q',mv_bdid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::ssn',  'Q',mv_ssn_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::taxid', 'Q', mv_taxid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::filing_number',  'Q',mv_filing_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::case_number', 'Q',mv_case_number_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::main::rmsid', 'Q',mv_rmsid_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::bocashell_did','Q',mv_bshell_did_key);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::main::IRS_serial_number','Q',mv_irs_key);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::main::certificate_number','Q',mv_cert_nbr);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::bocashell_liens_and_evictions_did_v2','Q',mv_liens_evic_v2);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::party::linkids','Q',mv_linkId_key);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::party::tmsid.rmsid_linkids','Q',mv_pid_linkids_key);
ut.mac_sk_move_v2('~thor_data400::key::liensv2::party::sourcerecid',  'Q',mv_sourcerecid_key, 2);
     
export Proc_AcceptSK_ToQA :=  parallel(mv_mid_key, mv_pid_key, 
			            mv_did_key, mv_bdid_key,
					  mv_ssn_key, mv_taxid_key,mv_filing_key,
					  mv_case_number_key,
					  mv_rmsid_key,mv_bshell_did_key,mv_irs_key,mv_cert_nbr,mv_liens_evic_v2,mv_linkId_key,mv_pid_linkids_key,mv_sourcerecid_key);					  
					  