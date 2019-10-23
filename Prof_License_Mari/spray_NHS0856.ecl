// spray NHS0856 New Hampshire Real Estate Appraiser Licenses Files for MARI	   

IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_NHS0856 := MODULE

	#workunit('name','Yogurt: Spray NHS0856');
	SHARED STRING7 code						:= 'NHS0856';
	//  Spray all raw files
	EXPORT S0856_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'lexisnexis.csv', 're','comma'),
										);
	END;

END;