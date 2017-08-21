IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
	   
EXPORT spray_CAS0847 := MODULE
	
	#workunit('name','Spray CAS0847');
	SHARED code						:= 'CAS0847';
	
	//  Spray All Files
	EXPORT S0847_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'pouliot.txt', 'apr','comma'); 		 
		);
	END;

END;