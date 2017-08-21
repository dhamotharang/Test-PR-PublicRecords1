//Indiana Real Estate Appraisers License File
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_INS0901 := MODULE

	#workunit('name','Spray INS0901');
	SHARED STRING7 code						:= 'INS0901';

	//  Spray All Files
	EXPORT S0901_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'bulk_licenses_0.csv', 'appraiser','comma') 		
										);
	END;

END;

