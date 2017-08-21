EXPORT BWR_ProfLic_Lookup_Build(version) := MACRO

DoBuild := Prof_LicenseV2.fBuild_All_ProfLic_Lookup(version);

SampleRecs :=	SAMPLE(Prof_LicenseV2.File_ProfLic_LicenseType_lookup.License_Type_Base,50,1);
					
SEQUENTIAL(
			DoBuild,
	OUTPUT(SampleRecs));

 ENDMACRO;