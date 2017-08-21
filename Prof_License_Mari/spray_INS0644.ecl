// spray INS0644 Professional Licenses Files for MARI	     
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_INS0644 := MODULE

	SHARED STRING7 code						:= 'INS0644';

	EXPORT S0644_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'mortgage_lender.csv', 'mtg_lender','comma') 		
										);
	END;

END;	   

