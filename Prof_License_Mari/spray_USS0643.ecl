// USS0643 - spray Ferderally Insured Mortgage Lenders File for MARI	   
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_USS0643 := MODULE

	#workunit('name','Spray USS0643'); 
	SHARED STRING7 code						:= 'USS0643';
	//  Spray all raw files
	EXPORT S0643_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'INSTITUTIONS2.CSV', 'lenders','comma');
							);
	END;

END;