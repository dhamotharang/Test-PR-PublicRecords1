// spray MNS0867 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
EXPORT spray_MNS0867 := MODULE

	#workunit('name','Yogurt: Spray MNS0867');
	SHARED STRING7 code						:= 'MNS0867';
	//  Spray all raw files
	EXPORT S0867_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REAPP.TXT', 'apr','tab') 		
										);
	END;

END;
