import corp2_mapping, Corp2_Raw_WY, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE										 

		tools.mac_FilesInput(Corp2_Raw_WY.Filenames(pversion, pUseOtherEnvironment).Input.Filing, Corp2_Raw_WY.Layouts.FilingLayoutIn, Filing,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1, pMaxLength := 100000);
														
		tools.mac_FilesInput(Corp2_Raw_WY.Filenames(pversion, pUseOtherEnvironment).Input.FilingAR, Corp2_Raw_WY.Layouts.FilingARLayoutIn, FilingAR,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1, pMaxLength := 100000);
		
		tools.mac_FilesInput(Corp2_Raw_WY.Filenames(pversion, pUseOtherEnvironment).Input.Party, Corp2_Raw_WY.Layouts.PartyLayoutIn, Party,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1, pMaxLength := 100000);

	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	/////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_WY.Filenames(pversion, pUseOtherEnvironment).Base.Filing, Corp2_Raw_WY.Layouts.FilingLayoutBase, Filing);
		tools.mac_FilesBase(Corp2_Raw_WY.Filenames(pversion, pUseOtherEnvironment).Base.FilingAR, Corp2_Raw_WY.Layouts.FilingARLayoutBase, FilingAR);
		tools.mac_FilesBase(Corp2_Raw_WY.Filenames(pversion, pUseOtherEnvironment).Base.Party, Corp2_Raw_WY.Layouts.PartyLayoutBase, Party);

	END;

END;