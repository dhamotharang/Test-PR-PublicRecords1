import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.Corporation, Corp2_Raw_NV.Layouts.CorporationsLayoutIn, Corporation,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);	
														
		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.RA,	Corp2_Raw_NV.Layouts.RALayoutIn, RA,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);
														
		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.Officers, Corp2_Raw_NV.Layouts.OfficersLayoutIn, Officers,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);
														
		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.Actions, Corp2_Raw_NV.Layouts.ActionsLayoutIn, Actions,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);
														
		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_NV.Layouts.StockLayoutIn, Stock,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);														

	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Base.Corporation, Corp2_Raw_NV.Layouts.CorporationsLayoutBase, Corporation);
		tools.mac_FilesBase(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Base.RA, 				 Corp2_Raw_NV.Layouts.RALayoutBase, RA);
		tools.mac_FilesBase(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Base.Officers, 	 Corp2_Raw_NV.Layouts.OfficersLayoutBase, Officers);
		tools.mac_FilesBase(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Base.Actions, 		 Corp2_Raw_NV.Layouts.ActionsLayoutBase, Actions);
		tools.mac_FilesBase(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Base.Stock, 			 Corp2_Raw_NV.Layouts.StockLayoutBase, Stock);	
	END;

END;