export MAC_FilePrep_Vehicle() :=

macro

a := 1;

ut.mac_create_superfiles('~thor_data400::base::perout'+doxie_build.buildstate,, false,'')
ut.mac_create_superfiles('~thor_data400::base::vehout'+doxie_build.buildstate,, false,'')
ut.mac_create_superfiles('~thor_data400::hole::wildcard_' + doxie_build.buildstate,, false,'')
ut.mac_create_superfiles('~thor_data400::WC_Vehicle::NameBase_' + doxie_build.buildstate,, false,'')
ut.mac_create_superfiles('~thor_data400::WC_Vehicle::ModelBase_' + doxie_build.buildstate,, false,'')


ut.mac_create_superkey_files('~thor_data400::key::'+doxie_build.buildstate+'vehiclefull')
ut.mac_create_superkey_files('~thor_data400::key::'+doxie_build.buildstate+'vehicle_id')
ut.mac_create_superkey_files('~thor_data400::key::'+doxie_build.buildstate+'vehicle_did')
ut.mac_create_superkey_files('~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag')
ut.mac_create_superkey_files('~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin')
ut.mac_create_superkey_files('~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid')
ut.mac_create_superkey_files('~thor_data400::WC_Vehicle::KeyNameIndex_' + doxie_build.buildstate)
ut.mac_create_superkey_files('~thor_data400::WC_Vehicle::KeyModelIndex_' + doxie_build.buildstate)


ut.mac_create_superfiles('~thor_data400::stats::vehicle_base_pop'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::vehicle_base_tag'+doxie_build.buildstate,,false,'')
ut.mac_create_superfiles('~thor_data400::stats::vehicle_base_vin'+doxie_build.buildstate,,false,'')

endmacro;