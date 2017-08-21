// spray Reference Files for MARI	sources   
import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date;
	   

export spray_ReferFiles:= MODULE	
#workunit('name','Spray Reference Files'); 
//  Spray all raw files
	EXPORT Reference(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_reference.spray_csv(pVersion,'cnldtrans.txt','cmvtrans', 'tab'),
										Prof_License_Mari.spray_reference.spray_csv(pVersion,'cmvlictype.txt','cmvlictype', 'tab'),
										Prof_License_Mari.spray_reference.spray_csv(pVersion,'cmvlicstatus.csv','cmvlicstatus', 'common'),
										);

	END;

END;

