import ut, tools, Corp2_Raw_AZ, Corp2_mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input Files   
	//-----------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.COREXT, Corp2_Raw_AZ.Layouts.COREXT_LayoutIn, COREXT,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.CHGEXT,	Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn, CHGEXT,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.FLMEXT, Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn, FLMEXT,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.OFFEXT,	Corp2_Raw_AZ.Layouts.OFFEXT_LayoutIn, OFFEXT,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1, pQuote := '"');
		tools.mac_FilesInput(Corp2_Raw_AZ.Filenames(pversion, pUseOtherEnvironment).Input.INACTV,	Corp2_Raw_AZ.Layouts.INACTV_LayoutIn, INACTV,
			'CSV', , pTerminator := ['\r\n', '\n'], pSeparator := '|', pHeading := 1, pQuote := '"');
  END;

END;
