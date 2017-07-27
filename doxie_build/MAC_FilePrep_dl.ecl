export MAC_FilePrep_dl() :=

macro

a := 1;

ut.mac_create_superfiles('~thor_data400::base::DLSearch_'+doxie_build.buildstate,, false,'')

ut.mac_create_superkey_files('~thor_data400::key::dl_'+doxie_build.buildstate)
ut.mac_create_superkey_files('~thor_data400::key::dl_number_'+doxie_build.buildstate)

ut.mac_create_superfiles('~thor_data400::stats::dl_base_pop'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::dl_base_number'+doxie_build.buildstate,,false,'')

ut.mac_create_superfiles('~thor_data400::stats::dl_in_pop'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::dl_in_number'+doxie_build.buildstate,,false,'')

endmacro;