// spray MNS0869 Professional Licenses Files for MARI	   
// #workunit('name','Spray MNS0869');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_MNS0869 := MODULE

	#workunit('name','Yogurt: Spray MNS0869');
	SHARED STRING7 code						:= 'MNS0869';
	//  Spray all raw files
	EXPORT S0869_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REAGTS.TXT', 'rea','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RECOS.TXT', 'rec','tab')
										);
	END;

END;