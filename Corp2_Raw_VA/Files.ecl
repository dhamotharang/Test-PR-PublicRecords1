import corp2_mapping, corp2_raw_va, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.Corps, Corp2_Raw_VA.Layouts.CorpsLayoutIn, Corps,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.BT, Corp2_Raw_VA.Layouts.BTLayoutIn , BT,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);											 
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.LP, Corp2_Raw_VA.Layouts.LPLayoutIn, LP,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.GP, Corp2_Raw_VA.Layouts.GPLayoutIn, GP,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);													 
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.LLC, Corp2_Raw_VA.Layouts.LLCLayoutIn, LLC,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.PSA, Corp2_Raw_VA.Layouts.PSALayoutIn, PSA,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);												 
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.Officer, Corp2_Raw_VA.Layouts.OfficersLayoutIn, Officer,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.NamesHist, Corp2_Raw_VA.Layouts.NamesHistLayoutIn, NamesHist,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.Merger, Corp2_Raw_VA.Layouts.MergersLayoutIn, Merger,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);	
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.ResrvdName, Corp2_Raw_VA.Layouts.ReservedLayoutIn, ResrvdName,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_VA.Filenames(pversion, pUseOtherEnvironment).Input.Amendment, Corp2_Raw_VA.Layouts.AmendmentLayoutIn, Amendment,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);					 

	END;

END;