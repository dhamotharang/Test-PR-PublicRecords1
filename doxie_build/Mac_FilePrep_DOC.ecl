export Mac_FilePrep_DOC := macro
	
	#uniquename(foo)
	unsigned1	%foo% := 1;
	
	ut.mac_create_superfiles('~thor_data400::base::corrections_activity_' + doxie_build.buildstate,2)
	ut.mac_create_superfiles('~thor_data400::base::corrections_offenders_'+ doxie_build.buildstate,2)
	ut.mac_create_superfiles('~thor_data400::base::corrections_offenses_'+ doxie_build.buildstate,2)
	ut.mac_create_superfiles('~thor_data400::base::corrections_court_offenses_'+ doxie_build.buildstate,2)
	ut.mac_create_superfiles('~thor_data400::base::corrections_punishment_'+ doxie_build.buildstate,2)
	
	ut.mac_Create_superkey_files('~thor_data400::key::corrections_offenders_' + doxie_build.buildstate,2)
	ut.mac_Create_superkey_files('~thor_data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,2)
	ut.mac_Create_superkey_files('~thor_data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate,2)
	ut.mac_Create_superkey_files('~thor_Data400::key::corrections_offenses_' + doxie_build.buildstate,2)
	ut.mac_create_superkey_files('~thor_Data400::key::corrections_activity_' + doxie_build.buildstate,2)
	ut.mac_create_superkey_files('~thor_data400::key::corrections_punishment_' + doxie_build.buildstate,2)
	
	ut.mac_create_superfiles('~thor_data400::stats::doc_base_pop_'+doxie_build.buildstate,2)
	ut.mac_create_superfiles('~thor_data400::stats::doc_base_did_'+doxie_build.buildstate,2)
	ut.mac_create_superfiles('~thor_data400::stats::DOC_Offenders_OffenderKey_'+doxie_build.buildstate,2)
	
endmacro;
