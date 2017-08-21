//spray_ARS0824 Arkansas Real Estate Appraisers File for MARI	
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT spray_ARS0824(string pVersion) := MODULE
#workunit('name','Spray ARS0824');
	SHARED code 					:= 'ARS0824';

	//  Spray All Files
	EXPORT S0824_SprayFiles := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Appraiser_AR.csv', 'apr','comma'), 		 
		);
	END;

END;
