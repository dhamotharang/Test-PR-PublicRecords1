// spray HIS0117 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_HIS0117 := MODULE

	#workunit('name','Spray HIS0117');
	SHARED STRING7 code						:= 'HIS0117';

	//  Spray All Files
	EXPORT S0117_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'LEGAL_SORTNAME.CSV', 'legal_sortname','comma'), 		
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'LICENSE_DATA.CSV','license_data','comma') 		
										);
	END;
	
END;
