import doxie,Data_Services;

df := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  Prof_LicenseV2.Layouts_ProfLic.Layout_Base);
//Prof_LicenseV2.File_Proflic_Base_Keybuild;

export Key_Proflic_Licensenum := index(
	df(license_number != ''),
	{string20 s_license_number := license_number, did, bdid}, {df},
	Data_Services.Data_location.Prefix()+'thor_data400::key::ProlicV2::'+ doxie.version_superKey +'::proflic_licensenum');
