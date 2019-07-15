IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_INS0610 := MODULE

	#workunit('name','Yogurt: Spray INS0610');
	SHARED STRING7 code						:= 'INS0610';

	//  Spray All Files
	EXPORT S0610_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Loan Broker Companies.csv', 'broker','comma') 		
										);
	END;

END;