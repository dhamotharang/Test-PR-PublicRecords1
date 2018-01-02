import address_attributes, doxie, data_services;

f := address_attributes.File_Law_Enforcement;

export key_LawEnforcement_geolink := index(f,{geolink},{f},
	data_services.data_location.prefix() + 'thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::law_enforcement_geolink');