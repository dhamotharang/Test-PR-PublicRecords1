// spray ILS0829 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_ILS0829 := MODULE

	#workunit('name','Spray ILS0829');
	SHARED STRING7 code						:= 'ILS0829';

	//  Spray All Files
	EXPORT S0829_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster471A.csv', 're','comma'),
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster473A.csv', 're','comma'), 
		//Vendor no longer providing	- TG 20150818
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster474A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster475A.csv', 're','comma'), 		 
		//Vendor no longer providing	- TG 20150818
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster475B.csv', 're','comma'), 		 
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster476A.csv', 're','comma'), 		 
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster476B.csv', 're','comma'), 		 
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster476C.csv', 're','comma'), 		 
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster476D.csv', 're','comma'), 		 
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster476E.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster477A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster478A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster479A.csv', 're','comma'), 		 
		//Vendor no longer providing	- TG 20150818	
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster480A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster481A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster553A.csv', 're','comma'), 		 
		//Vendor no longer providing	- TG 20150818
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster554A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster556A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster557A.csv', 're','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Roster572A.csv', 're','comma') 		 
		);
	END;

END;

