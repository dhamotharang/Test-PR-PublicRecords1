import address_attributes, doxie, ut;

f := address_attributes.File_Law_Enforcement;

export key_LawEnforcement_geolink := index(f,{geolink},{f},
	// ut.foreign_dataland + 'thor_data400::key::'+doxie.Version_SuperKey+'::law_enforcement_geolink');
	'~thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::law_enforcement_geolink');