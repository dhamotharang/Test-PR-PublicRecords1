IMPORT tools;

EXPORT Files( STRING  pversion = ''
				     ,BOOLEAN pUseOtherEnvironment = FALSE ) := MODULE

	// -- Input File Versions
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input,
                       Layouts.Sprayed_Input,
                       Input,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator  := '\t',
                       pHeading    := 0);

	// -- Base File Versions
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base,
                       Layouts.Base,
                       Base);
	
END;                        