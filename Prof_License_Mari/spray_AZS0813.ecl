// spray AZS0813 Professional Licenses Files for MARI	
//Unzip files before running spray   
import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib;
	   
EXPORT spray_AZS0813 := MODULE

	#workunit('name','Yogurt:Spray AZS0813');
	SHARED code						:= 'AZS0813';

	//  Spray All Files
	EXPORT S0813_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Entities.txt', 'entities','comma'), 		 
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Individuals.txt','individuals','comma'), 		 
		);
	END;

END;