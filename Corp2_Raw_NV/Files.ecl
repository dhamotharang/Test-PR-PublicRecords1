import ut, tools, corp2_raw_nv;

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

		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.TM, Corp2_Raw_NV.Layouts.TMLayoutIn, TM,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);		
		
		tools.mac_FilesInput(Corp2_Raw_NV.Filenames(pversion, pUseOtherEnvironment).Input.TMActions, Corp2_Raw_NV.Layouts.TMActionsLayoutIn, TMActions,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '~', pHeading := 0);																
	END;

END;