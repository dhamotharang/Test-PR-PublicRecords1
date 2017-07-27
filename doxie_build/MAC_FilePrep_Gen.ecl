export MAC_FilePrep_Gen := 
macro

a := 1;

ut.mac_create_superfiles('~thor_data400::base::codes_v3',, false,'')
ut.mac_create_superkey_files('~hthor::key::codes_v3')
ut.mac_create_superfiles('~thor_data400::in::fips_counties',, false,'')
ut.mac_create_superfiles('~thor_data400::out::VinaShrunk',, false,'')

fileservices.createsuperfile('~thor_data400::base::name_base');
fileservices.createsuperfile('~thor_data400::BASE::Address_Cache::Super');


endmacro;