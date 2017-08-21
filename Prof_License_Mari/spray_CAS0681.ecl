//California Mortgage Lender CAS0681

IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
	   
EXPORT spray_CAS0681 := MODULE
	#workunit('name','Spray CAS0681');
	SHARED code						:= 'CAS0681';

	//  Spray All Files
	EXPORT S0681_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'CurrList_Comma_Delimited.txt', 'real_estate','comma'), 		 
		);
	END;

END;
