//Spray NCS0840 Professional Licenses Files for MARI	   

IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_NCS0840 := MODULE

	#workunit('name','Spray NCS0840');
	SHARED STRING7 code						:= 'NCS0840';
	//  Spray all raw files
	EXPORT S0840_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(
										// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'INACTIVE.txt', 'inactive','tab'),
										// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'ACTIVE.txt', 'active','tab')
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Real_Estate_File.csv', 'active','csv')
										);
	END;

END;	



