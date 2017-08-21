//Idaho Real Estate Appraisers 
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_IDS0262 := MODULE

	#workunit('name','Spray IDS0262');
	SHARED STRING7 code						:= 'IDS0262';

	//  Spray All Files
	EXPORT S0262_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'LPRBrowser.csv', 'apr','comma') 		
										);

	END;

END;