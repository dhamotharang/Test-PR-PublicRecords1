import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Entities, Corp2_Raw_RI.Layouts.EntitiesIn, Entities,
   		                   'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);	
  
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.amendments,	Corp2_Raw_RI.Layouts.amendmentsIn, amendments,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Names, Corp2_Raw_RI.Layouts.NamesIn, Names,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Mergers, Corp2_Raw_RI.Layouts.MergersIn, Mergers,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Officers, Corp2_Raw_RI.Layouts.OfficersIn, Officers,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Stocks, Corp2_Raw_RI.Layouts.StocksIn,  Stocks,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);												 
		
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Inactive_Entities, Corp2_Raw_RI.Layouts.InActEntitiesIN, Inactive_Entities,
   		                   'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := ',', pHeading := 1);	 //JIRA: DF-24004--Format change from vendor staring from 20181204
  
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Inactive_amendments,	Corp2_Raw_RI.Layouts.amendmentsIn, Inactive_amendments,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Inactive_Names, Corp2_Raw_RI.Layouts.NamesIn, Inactive_Names,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Inactive_Mergers, Corp2_Raw_RI.Layouts.MergersIn, Inactive_Mergers,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Inactive_Officers, Corp2_Raw_RI.Layouts.OfficersIn, Inactive_Officers,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Inactive_Stocks, Corp2_Raw_RI.Layouts.StocksIn,  Inactive_Stocks,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);	
   																			

	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Entities, 						 Corp2_Raw_RI.Layouts.EntitiesBase, Entities);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Amendments,					 Corp2_Raw_RI.Layouts.AmendmentsBase, Amendments);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Names,  		 					 Corp2_Raw_RI.Layouts.NamesBase, Names);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Mergers,    					 Corp2_Raw_RI.Layouts.MergersBase, Mergers);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Officers,  					 Corp2_Raw_RI.Layouts.OfficersBase, Officers);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Stocks,	 	 					 Corp2_Raw_RI.Layouts.StocksBase,  Stocks);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Inactive_Entities, 	 Corp2_Raw_RI.Layouts.InActEntitiesBase, Inactive_Entities);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Inactive_Amendments,  Corp2_Raw_RI.Layouts.AmendmentsBase, Inactive_Amendments);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Inactive_Names,  		 Corp2_Raw_RI.Layouts.NamesBase, Inactive_Names);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Inactive_Mergers,     Corp2_Raw_RI.Layouts.MergersBase, Inactive_Mergers);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Inactive_Officers,    Corp2_Raw_RI.Layouts.OfficersBase, Inactive_Officers);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Inactive_Stocks,	 	   Corp2_Raw_RI.Layouts.StocksBase,  Inactive_Stocks);	
		
		
	END;

END;