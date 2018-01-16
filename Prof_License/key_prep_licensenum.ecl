import Data_Services;

df := file_keybase(license_number != '');

export key_prep_licensenum := index(
	df,
	{string20 s_license_number := license_number, did, bdid}, {df},
	Data_Services.Data_location.Prefix()+'thor_data400::key::proflic_licensenum' + thorlib.wuid());