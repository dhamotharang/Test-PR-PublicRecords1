IMPORT strata;
EXPORT Proc_FCRA_Field_Deprecation_Stats := FUNCTION

	//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcyv3::fcra::main::tmsid_qa
	cnt_fcra_main_tmsid := OUTPUT(strata.macf_pops(BankruptcyV3.key_bankruptcyV3_main_full(true),,,,,,FALSE,
																														['assets','complaint_deadline','confheardate','datereclosed','judges_identification',
																														 'liabilities','meeting_time','planconfdate','trusteeemail']));
	//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcyv3::fcra::search::tmsid_linkids_qa
	cnt_fcra_srch_tmsid_linkids := OUTPUT(strata.macf_pops(BankruptcyV3.key_bankruptcyv3_search_full_bip(true),,,,,,FALSE,
																														['datetransferred','holdcase','orig_email','orig_fax','phone',
																														 'tax_id']));
	//DF-21108 Verify followings fields are cleared in thor_data400::key::bankruptcy::autokey::fcra::payload_qa
	cnt_fcra_autokey_payload := OUTPUT(strata.macf_pops(BankruptcyV3.Key_BankruptcyV3_Payload,,,,,,FALSE,
																														['tax_id']));
	RETURN SEQUENTIAL(cnt_fcra_main_tmsid, cnt_fcra_srch_tmsid_linkids, cnt_fcra_autokey_payload);
END;