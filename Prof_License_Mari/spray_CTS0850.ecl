// spray Connecticut Dept of Consumer Protection Professional Licenses Files for MARI	    
IMPORT ut, _control,Prof_License_Mari,Lib_FileServices,lib_stringlib;
	   
EXPORT spray_CTS0850 := MODULE

	#workunit('name','Spray CTS0850');
	SHARED code						:= 'CTS0850';

	//  Spray All Files
	EXPORT S0850_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Certified_General_Real_Estate_Appraisers.csv', 'general_apprs','comma'),
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Certified_Residential_Real_Estate_Appraisers.csv', 'residential_apprs','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Mobile_Home_Parks.csv','mobile_parks','comma'),
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Provisional_Real_Estate_Appraisers.csv','provisional_apprs','comma'),
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Real_Estate_Brokers.csv','brokers','comma'),
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Real_Estate_Salespersons.csv','salespersons','comma')
		);
	END;

END;
