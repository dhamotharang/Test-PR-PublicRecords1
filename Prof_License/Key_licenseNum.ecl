import doxie,Data_Services;

export Key_licenseNum := index(
	file_doxie,
	{string20 s_license_number := license_number}, {file_doxie},
	Data_Services.Data_location.Prefix()+'thor_data400::key::proflic_licensenum' + doxie.version_Keys);