export MAC_FilePrep_so :=

macro

a := 1;

ut.mac_create_superfiles('~thor_data400::in::so_accurint' + doxie_build.buildstate)
ut.mac_create_superfiles('~thor_data400::in::so_accurint_search' + doxie_build.buildstate)
ut.mac_create_superfiles('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate,, false,'')
ut.mac_create_superfiles('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate,, false,'')

ut.mac_create_superkey_files('~thor_data400::key::sexoffender_did'+doxie_build.buildstate)
ut.mac_create_superkey_files('~thor_data400::key::sexoffender_offenses_'+doxie_build.buildstate)
ut.mac_create_superkey_files('~thor_data400::key::sexoffender_spk'+ doxie_build.buildstate)

  ut.mac_create_superkey_files('~thor_data400::key::autoSO_ssn')
  ut.mac_create_superkey_files('~thor_data400::key::autoSO_phone')
  ut.mac_create_superkey_files('~thor_data400::key::autoSO_addr')
  ut.mac_create_superkey_files('~thor_data400::key::autoSO_stfl')
  ut.mac_create_superkey_files('~thor_data400::key::autoSO_city')

ut.mac_create_superfiles('~thor_data400::stats::so_base_pop_'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::so_base_did_'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::so_base_case_'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::so_base_spk_'+doxie_build.buildstate,,false,'')

ut.mac_create_superfiles('~thor_data400::stats::so_in_pop_' + doxie_build.buildstate)
ut.mac_create_superfiles('~thor_data400::stats::so_in_personpk_' + doxie_build.buildstate)
ut.mac_create_superfiles('~thor_data400::stats::so_in_addressfk_' + doxie_build.buildstate)

endmacro;