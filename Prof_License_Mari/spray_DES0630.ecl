//Spray Delaware Delaware Mortgage (Delaware Department of State) DES0630
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
	   
EXPORT spray_DES0630 := MODULE

	SHARED code						:= 'DES0630';
	
	//  Spray All Files
	EXPORT S0630_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'liclenders.txt', 'lender','tab'), 		 
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'mortbrokers.txt', 'mbroker','tab'), 		 
		);
	END;

END;