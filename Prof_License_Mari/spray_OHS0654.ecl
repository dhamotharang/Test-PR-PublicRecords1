// spray Ohio Department of Commerce Professional Licenses Files for MARI	    
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_OHS0654 := MODULE

	#workunit('name','Spray OHS0654');
	SHARED STRING7 code						:= 'OHS0654';
	//  Spray all raw files
	EXPORT S0654_SprayFiles(string pVersion) := FUNCTION
	
		//DFI - Department of Financial Institutions
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Real Estate and Profession Licensing.csv', 're','comma')
										);
	END;

END;