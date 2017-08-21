// Despray CMRFLAT Professional Licenses Files for MARI	   

import ut,_control,Prof_License_Mari,Lib_FileServices,lib_stringlib,Lib_date;
	   

export despray_CMRFLAT := MODULE
#workunit('name','Despray CMRFLAT');    

shared filepath		  :=	'/data_build_5_2/MARI/extract/';	

shared destination := Common_Prof_Lic_Mari.DestFolder; 

shared filedate	:= StringLib.GetDateYYYYMMDD();

shared CMRFLAT_Filename := 'cmrflat';

CMRFLAT_DeSprayFile := FUNCTION
	RETURN FileServices.Despray(destination + CMRFLAT_Filename,
		_Control.IPAddress.edata10,
		Common_Prof_Lic_Mari.DestPath + 'cmrflat_' + filedate + '.txt',
		,,,TRUE);
	END;
	
export MARI_CreateProf :=
SEQUENTIAL(
			
	CMRFLAT_DeSprayFile
);

END;








