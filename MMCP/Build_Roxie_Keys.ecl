IMPORT tools;

EXPORT Build_Roxie_Keys(STRING pversion = '',
	                      DATASET(Layouts.Base) pBase = Files(pversion).Base.Main.Built) := MODULE

	SHARED TheKeys := Keys(pversion, pBase);

	tools.mac_WriteIndex('TheKeys.LicenseNumber.New', BuildLicenseNumberKey);
	tools.mac_WriteIndex('TheKeys.LicenseState.New', BuildLicenseStateKey);

	EXPORT full_build := SEQUENTIAL(PARALLEL(BuildLicenseNumberKey,
			                                     BuildLicenseStateKey),
		                              Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping MMCP.Build_Roxie_Keys atribute'));

END;