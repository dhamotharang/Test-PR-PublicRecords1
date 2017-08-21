IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
	   
EXPORT spray_DES0846 := MODULE

	#workunit('name','Spray DES0846');
	SHARED code						:= 'DES0846';
	
	//  Spray All Files
	EXPORT S0846_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RealEstateApp.csv', 'apr','comma'), 		 
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RealEstate.csv', 're','comma'), 		 
		);
	END;

END;