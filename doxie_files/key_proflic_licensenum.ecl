import doxie, data_services;

df := file_proflicense_keybuilt;

export key_proflic_licensenum := index(
	df(license_number != ''),
	{string20 s_license_number := license_number, did, bdid}, 
	{df},
	data_services.data_location.prefix() + 'thor_data400::key::proflic_licensenum_' + doxie.version_superKey);