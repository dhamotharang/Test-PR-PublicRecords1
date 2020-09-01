IMPORT tools;

EXPORT Files( STRING  pversion = ''
				     ,BOOLEAN pUseOtherEnvironment = FALSE ) := MODULE

	// -- Input File Versions
	export Input:= 
	module
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Companies,
                       Layouts.Sprayed_Input,
                       Companies,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator  := '|',
                       pHeading    := 1);
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Contacts,
                       Layouts.Sprayed_Input_Contacts,
                       Contacts,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator  := '|',
                       pHeading    := 1);
	end;
											 
	// -- Base File Versions
	export Base := 
	module
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base.Companies,
                       Layouts.Base,
                       Companies);
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base.Contacts,
                       Layouts.Base_Contacts,
                       Contacts);
	end;
	
END;                  