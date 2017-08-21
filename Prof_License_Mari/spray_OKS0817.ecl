// spray Oklahoma Real Estate Professional Licenses Files for MARI	   
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_OKS0817 := MODULE

	#workunit('name','Spray OKS0817'); 
	SHARED STRING7 code						:= 'OKS0817';
	//  Spray all raw files
	EXPORT S0817_SprayFiles(string pVersion) := FUNCTION
	
		//DFI - Department of Financial Institutions
		RETURN Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'extract.csv', 're','comma');
	END;

END;
