import address_attributes, doxie, data_services;

f := address_attributes.File_Fire_Departments(geolink <> '');

export key_FireDepartment_geolink := index(f,{geolink},{f},

	data_services.data_location.prefix() + 'thor_data400::key::fire_department_geolink_' + doxie.Version_SuperKey);