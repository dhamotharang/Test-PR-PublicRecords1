import ut, tools, Corp2_Raw_AK;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// -- Input Files   
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_AK.Filenames(pversion, pUseOtherEnvironment).Input.Corporations, Corp2_Raw_AK.Layouts.CorporationsLayoutIn, Corporations,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n'], pSeparator := ',', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_AK.Filenames(pversion, pUseOtherEnvironment).Input.Officials,	Corp2_Raw_AK.Layouts.OfficialsLayoutIn, Officials,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n'], pSeparator := ',', pHeading := 1);
	END;

	// -- Base Files  
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_AK.Filenames(pversion, pUseOtherEnvironment).Base.Corporations, Corp2_Raw_AK.Layouts.CorporationsLayoutBase, Corporations);
		tools.mac_FilesBase(Corp2_Raw_AK.Filenames(pversion, pUseOtherEnvironment).Base.Officials, 		Corp2_Raw_AK.Layouts.OfficialsLayoutBase, Officials);
	END;

END;