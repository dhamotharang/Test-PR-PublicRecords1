IMPORT ut, VersionControl, lib_stringlib, lib_fileservices, _control, Prof_LicenseV2;

EXPORT fBuild_All_ProfLic_lookup(STRING version) := FUNCTION

//-----------Spray input file
spray_file := Prof_LicenseV2.fSpray_ProfLic_lookup();

ut.MAC_SF_BuildProcess(Prof_LicenseV2.Proc_Build_ProfLic_Lookup,Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Base, BuildBaseFile,2,,true,version);

built := SEQUENTIAL(
					spray_file,
					BuildBaseFile,
					Prof_LicenseV2.fBuildKey_ProfLic_Lookup(version),
					//Archive processed files in history
					FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Load_Father,Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Load,,true),
					FileServices.ClearSuperFile(Prof_LicenseV2.ProfLic_Lookup_SF_List.License_Type_Load),
					FileServices.FinishSuperFileTransaction());

	RETURN built;

END;