import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Addresses, Corp2_Raw_NC.Layouts.AddressesLayoutIn, Addresses,
   		                   'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);	
												 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Filings, Corp2_Raw_NC.Layouts.FilingsLayoutIn, Filings,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Corporations, Corp2_Raw_NC.Layouts.CorporationsLayoutIn, Corporations,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.NameReservations, Corp2_Raw_NC.Layouts.NameReservationsLayoutIn, NameReservations,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Names, Corp2_Raw_NC.Layouts.NamesLayoutIn,  Names,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_NC.Layouts.StockLayoutIn,Stock,
   		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
   												 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.PendingFilings, Corp2_Raw_NC.Layouts.PendingFilingsLayoutIn, PendingFilings,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);		
    
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.CorpOfficers, Corp2_Raw_NC.Layouts.CorpOfficersLayoutIn, CorpOfficers,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1);
												 
																			
	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Addresses, 		   Corp2_Raw_NC.Layouts.AddressesLayoutBase, Addresses);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Filings,  			   Corp2_Raw_NC.Layouts.FilingsLayoutBase, Filings);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Corporations,     Corp2_Raw_NC.Layouts.CorporationsLayoutBase, Corporations);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.NameReservations, Corp2_Raw_NC.Layouts.NameReservationsLayoutBase, NameReservations);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Names, 		 		   Corp2_Raw_NC.Layouts.NamesLayoutBase,  Names);	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Stock, 	  			 Corp2_Raw_NC.Layouts.StockLayoutBase, Stock);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.PendingFilings,   Corp2_Raw_NC.Layouts.PendingFilingsLayoutBase, PendingFilings);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.CorpOfficers, 		 Corp2_Raw_NC.Layouts.CorpOfficersLayoutBase, CorpOfficers);
		
		
	END;

END;