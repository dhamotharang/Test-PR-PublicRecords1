// spray LAS0832 Professional Licenses Files for MARI	     
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_LAS0832 := MODULE

	#workunit('name','Yogurt: Spray LAS0832');
	SHARED STRING7 code						:= 'LAS0832';

	//  Spray All Files
	EXPORT S0832_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Request_ALL_Lexis.csv', 're','comma') 		
										);
	END;

END;
	
