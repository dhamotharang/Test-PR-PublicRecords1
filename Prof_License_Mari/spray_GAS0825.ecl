// spray GAS0825 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

//Files for S0825 are Located  //
export spray_GAS0825 := MODULE

	#workunit('name','Spray GAS0825');
	SHARED STRING7 code						:= 'GAS0825';

	//  Spray All Files
	EXPORT S0825_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'APPR_ACTV.TXT', 'apr_actv', 'semi'), 
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'APPR_INACT.TXT','apr_inact','semi'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REBK_ACTV.TXT','rebk_actv', 'tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REBK_INACT.TXT','rebk_inact', 'semi')
										);
	END;

END;