//spray_KSS0902 Kansas Real Estate Appraisers File for MARI	
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT spray_KSS0902(string pVersion) := MODULE
#workunit('name','Yogurt: Spray KSS0902');
	SHARED code 					:= 'KSS0902';

	//  Spray All Files
	EXPORT S0902_SprayFiles := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Appraiser_KS.csv', 'apr','comma'), 		 
		);
	END;

END;

