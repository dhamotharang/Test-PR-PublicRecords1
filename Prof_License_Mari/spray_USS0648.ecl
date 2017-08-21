// spray USS0648 National Credit Union Charter Number Files for MARI	   
IMPORT Prof_License_Mari;
   
export spray_USS0648 := MODULE

	#workunit('name','Spray USS0648');
	SHARED STRING7 code						:= 'USS0648';

	//  Spray All Files
	EXPORT S0648_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'foicu.txt', 'foicu','comma'), 		 
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Credit Union Branch Information.txt','cubi','comma'),
		);
	END;

END;