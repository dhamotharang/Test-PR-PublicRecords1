// spray LAS0833 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_LAS0833 := MODULE

	#workunit('name','Yogurt: Spray LAS0833');
	SHARED STRING7 code						:= 'LAS0833';

	//  Spray All Files
	EXPORT S0833_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Request_APR_Act_Lexis.csv', 'apr','comma') 		
										);

	END;

END;