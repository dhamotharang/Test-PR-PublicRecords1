IMPORT tools;

EXPORT Files( STRING  pversion = ''
				     ,BOOLEAN pUseOtherEnvironment = FALSE ) := MODULE

	// -- Input File Versions
	export Input:= 
	module
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.NAICS,
                       Layouts.Sprayed_Input,
                       NAICS,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator  := ',',
                       pHeading    := 1);
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.DnbDmi,
                       Layouts.Sprayed_Input_DnbDmi,
                       DnbDmi,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator  := ',',
                       pHeading    := 3);
	end;
											 
	// -- Base File Versions
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).NAICSLookup,
                       Layouts.NAICSLookup,
                       NAICSLookup);
	
END;                        