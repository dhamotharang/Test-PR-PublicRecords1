// spray West Virginia Real Estate WVS0816 Appraisers Licenses Files for MARI	   
IMPORT Prof_License_Mari;

EXPORT spray_WVS0816 := MODULE

	SHARED STRING7 code						:= 'WVS0816';
	//  Spray all raw files
	EXPORT S0816_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster.csv', 'apr','comma');
							);
	END;

END;