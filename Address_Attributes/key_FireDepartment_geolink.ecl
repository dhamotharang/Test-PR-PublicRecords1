import address_attributes, doxie, ut;

f := address_attributes.File_Fire_Departments(geolink <> '');

export key_FireDepartment_geolink := index(f,{geolink},{f},
	// ut.foreign_dataland + 'thor_data400::key::'+doxie.Version_SuperKey+'::fire_department_geolink');
	'~thor_data400::key::fire_department_geolink_' + doxie.Version_SuperKey);