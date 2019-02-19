/*2015-10-22T22:12:19Z (Xia Sheng)
Bug: 187038 


*/
// spray USS0814 National Real Estate Appraisers for MARI	   
IMPORT Prof_License_Mari;
   
export spray_USS0814 := MODULE

	#workunit('name','Yogurt: Spray USS0814');
	SHARED STRING7 code						:= 'USS0814';

	//  Spray All Files
	EXPORT S0814_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'asc_data.txt', 'asc','tab'), 		 	 
		);
	END;

END;