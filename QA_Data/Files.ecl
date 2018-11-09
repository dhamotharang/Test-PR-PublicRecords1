IMPORT tools;

EXPORT Files( STRING  pversion = ''
				     ,BOOLEAN pUseOtherEnvironment = FALSE ) := MODULE

	// -- Trans data Input File Versions
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputTrans,
                       layouts.Input.Sprayed_Transactions,
                       Input_Trans,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator := ',',
                       pHeading := 1);

	// -- Addr data Input File Versions
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).InputAddr,
                       layouts.Input.Sprayed_Addresses,
                       Input_Addr,
                       'CSV', ,
                       pTerminator := ['\n','\r\n'],
                       pSeparator := ',',
                       pHeading := 1);
		
	// -- Base File Versions
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base,
                       layouts.Base,
                       Base);
	
END;                        