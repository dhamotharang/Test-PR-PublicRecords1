import ut, header,doxie;

pro := doxie.build_file_base_did_rid;
ut.MAC_SF_BuildProcess(pro,'~thor_data400::base::file_did_rid',a1,2);
ut.MAC_SK_BuildProcess(doxie.Key_prep_Did_Rid,'~thor_data400::key::rid_did','~thor_data400::key::rid_did',rid_did,2);

did_keys := proc_build_didkeys;

ut.MAC_SK_BuildProcess(header_slimsort.key_prep_probationary_dids,'~thor_data400::key::probationary_dids','~thor_data400::key::probationary_dids',out_key_probation,2);

ssn_did_keys_4 := header_slimsort.did_ssn_keys;

full_keys := parallel(
	sequential(
		proc_build_address_key,
		proc_build_ssn_key,
		proc_build_phone_key,
		proc_build_dob_keys,
		proc_build_agessn4zip_keys),
	did_keys,
	out_key_probation,
	sequential(a1,rid_did),
	ssn_did_keys_4
);

export proc_buildkeys := full_keys;