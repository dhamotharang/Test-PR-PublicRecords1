IMPORT ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Input.Filing, Corp2_Raw_TN.Layouts.FilingLayoutIn, Filing,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);	
														
		tools.mac_FilesInput(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Input.FilingName,	Corp2_Raw_TN.Layouts.FilingNameLayoutIn, FilingName,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Input.Party, Corp2_Raw_TN.Layouts.PartyLayoutIn, Party,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Input.AnnualReport, Corp2_Raw_TN.Layouts.AnnualReportLayoutIn, AnnualReport,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
														
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Base.Filing, Corp2_Raw_TN.Layouts.FilingLayoutBase, Filing);
		tools.mac_FilesBase(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Base.FilingName,	Corp2_Raw_TN.Layouts.FilingNameLayoutBase, FilingName);
		tools.mac_FilesBase(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Base.Party, Corp2_Raw_TN.Layouts.PartyLayoutBase, Party);
		tools.mac_FilesBase(Corp2_Raw_TN.Filenames(pversion, pUseOtherEnvironment).Base.AnnualReport, Corp2_Raw_TN.Layouts.AnnualReportLayoutBase, AnnualReport);
	END;

END;	