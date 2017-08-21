// spray AZS0639 Professional Licenses Files for MARI	 
import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib;
	   
EXPORT spray_AZS0639 := MODULE

	#workunit('name','Spray AZS0639');
	SHARED code						:= 'AZS0639';

	//  Spray All Files
	EXPORT S0639_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BK_List.CSV', 'bk','comma'), 		 
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'CBK_List.CSV', 'cbk','comma'), 		 
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'EA_List.CSV', 'ea','comma'), 		 
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'MB_List.CSV', 'mb','comma'), 		 
		);
	END;

END;