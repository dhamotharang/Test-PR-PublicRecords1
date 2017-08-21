IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_MES0888 := MODULE

	#workunit('name','Spray MES0888');
	SHARED STRING7 code						:= 'MES0888';
	
	//  Spray all raw files
	EXPORT S0888_SprayFiles(string pVersion) := FUNCTION
	
		RETURN Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REC for LEXISNEXIS.csv', 're','comma'); 
		
	END;

END;