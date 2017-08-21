// spray MES0888 Maine Real Estate Appraiser Licenses Files for MARI	   
//#workunit('name','Spray MES0838');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_MES0838 := MODULE

	SHARED STRING7 code						:= 'MES0838';
	
	//  Spray all raw files
	EXPORT S0838_SprayFiles(string pVersion) := FUNCTION
	
		RETURN Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REA for LEXISNEXIS.csv', 'apr','comma'); 
		
	END;

END;