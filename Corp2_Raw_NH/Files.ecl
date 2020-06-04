IMPORT tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Corporation, Corp2_Raw_NH.Layouts.CorporationLayoutIn, Corporation,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Address, Corp2_Raw_NH.Layouts.AddressLayoutIn, Address,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Filing, Corp2_Raw_NH.Layouts.FilingLayoutIn, Filing,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.RegAgent,	Corp2_Raw_NH.Layouts.RegAgentLayoutIn, RegAgent,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.PrevNames, Corp2_Raw_NH.Layouts.PrevNamesLayoutIn, PrevNames,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');
		
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Principals, Corp2_Raw_NH.Layouts.PrincipalsLayoutIn, Principals,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.PrinPurp, Corp2_Raw_NH.Layouts.PrinPurposeLayoutIn, PrinPurp,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');
														
		tools.mac_FilesInput(Corp2_Raw_NH.Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_NH.Layouts.StockLayoutIn, Stock,
		                        'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '|');


	END;

END;