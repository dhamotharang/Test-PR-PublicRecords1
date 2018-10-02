// MARI - Spray Arizona Board of Appraisers - AZS0808
import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib;
	   
EXPORT spray_AZS0808 := MODULE
 
 #workunit('name','Yogurt:Spray AZS0808');
	SHARED code						:= 'AZS0808';

	//  Spray All Files
	EXPORT S0808_SprayFiles(string pVersion) := FUNCTION
		RETURN PARALLEL(
				Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'apprlist.csv', 'apr','comma'), 		 
		);
	END;

END;