// spray MTS0398 Montana Professional Licenses Files for MARI   
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_MTS0398 := MODULE

	#workunit('name','Yogurt: Spray MTS0398'); 
	SHARED STRING7 code						:= 'MTS0398';
	//  Spray all raw files
	EXPORT S0398_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'licensees.csv', 're','comma'),
										);
	END;

END;
