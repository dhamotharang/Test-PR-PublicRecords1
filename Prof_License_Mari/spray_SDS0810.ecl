// SDS0810 / South Dakota Revenue and Regulation / Real Estate Appraisers //
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_SDS0810 := MODULE

	#workunit('name','Spray SDS0810');
	SHARED STRING7 code						:= 'SDS0810';
	//  Spray all raw files
	EXPORT S0810_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'appraiser.csv', 'apr','comma'),
										);
	END;

END;