import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	
	// -- Input File Versions
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Corporation, Corp2_Raw_DC.Layouts.CorporationsLayoutIn, Corporation,
		                     'CSV', , pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
												 
	END;

	
	// -- Base File Versions
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Corporation, Corp2_Raw_DC.Layouts.CorporationsLayoutBase, Corporation);
		
	END;

end;