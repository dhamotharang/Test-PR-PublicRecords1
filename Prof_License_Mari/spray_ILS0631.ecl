// spray ILS0631 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_ILS0631 := MODULE

	SHARED STRING7 code						:= 'ILS0631';

	//  Spray All Files
	EXPORT S0631_SprayFiles(string pVersion) := FUNCTION
	
		RETURN Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Licensees.csv', 'mtg_license','comma');
		
	END;

END;

