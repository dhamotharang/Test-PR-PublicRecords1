IMPORT tools;

EXPORT Files( STRING  pversion = ''
				     ,BOOLEAN pUseOtherEnvironment = FALSE ) := MODULE

	// -- Input File Versions
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input,
                       Database_USA.Layouts.Sprayed_Input,
                       Input,
                       'CSV', ,
                       pTerminator := ['\n','\r\n','\n\r'],
                       pSeparator  := '|',
											 pQuote			 := '"',
                       pHeading    := 1,
											 pMaxLength	 := 8192);

	// -- Base File Versions
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base,
                       Database_USA.Layouts.Base,
                       Base);
	
END;