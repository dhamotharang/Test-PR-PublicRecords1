IMPORT tools;

EXPORT Keys(STRING pversion = '',
	          DATASET(Layouts.Base) pBaseBuilt = Files(pversion).Base.Main.Built) := MODULE

	SHARED Base := pBaseBuilt(license_number != '');
	SHARED Base_State := Base(state != '');

	tools.mac_FilesIndex('Base, {license_number, record_type}, {Base}',
	                        KeyNames(pversion).LicenseNumber, LicenseNumber);
	tools.mac_FilesIndex('Base_State, {state, license_number}, {Base}',
	                        KeyNames(pversion).LicenseState, LicenseState);

END;