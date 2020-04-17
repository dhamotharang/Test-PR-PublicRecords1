// spray FLS0280 Professional Licenses Files for MARI	   

IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
   
export spray_FLS0280 := MODULE

	#workunit('name','Spray FLS0280');
	SHARED STRING7 code						:= 'FLS0280';

	//  Spray All Files
	EXPORT S0280_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'lic64appr.csv', 'lic64','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REALESTATE2501LICENSE_1.csv','re1','comma'),
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REALESTATE2501LICENSE_2.csv','re2','comma'),
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REALESTATE2501LICENSE_3.csv','re3','comma'),
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REALESTATE2501LICENSE_4.csv','re4','comma'),
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REALESTATE2501LICENSE_5.csv','re5','comma'),
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RealEstateCorpLicense.csv','corp','comma')
		);
	END;

END;