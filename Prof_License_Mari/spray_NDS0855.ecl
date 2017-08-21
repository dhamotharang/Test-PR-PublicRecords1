// spray NDS0855 Professional Licenses Files for MARI	   

IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_NDS0855 := MODULE

	#workunit('name','Spray NDS0855');
	SHARED STRING7 code						:= 'NDS0855';
	//  Spray all raw files
	EXPORT S0855_SprayFiles(string pVersion) := FUNCTION

		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'rptLicensee.csv', 're','comma');
										);
	END;

END;