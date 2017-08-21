// spray KYS0809 - Kentucky Real Estate Appraisers 	     
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_KYS0809 := MODULE

	SHARED STRING7 code						:= 'KYS0809';

	EXPORT S0809_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'appraiser.csv', 'apr','comma') 		
										);
	END;

END;	