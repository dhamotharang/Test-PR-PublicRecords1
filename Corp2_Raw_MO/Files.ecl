import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Address, Corp2_Raw_MO.Layouts.AddressLayoutIn, Address,
   		                   'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);	
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Filing, Corp2_Raw_MO.Layouts.FilingLayoutIn, Filing,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Corporation, Corp2_Raw_MO.Layouts.CorporationLayoutIn, Corporation,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);
			 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Names, Corp2_Raw_MO.Layouts.NamesLayoutIn, Names,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);
												 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Officer, Corp2_Raw_MO.Layouts.OfficerLayoutIn, Officer,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_MO.Layouts.StockLayoutIn,Stock,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);
												 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.merger, Corp2_Raw_MO.Layouts.mergerLayoutIn, merger,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := [','], pHeading := 1);
		
		export DocumentType_Table        := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files +'lookup::corp2::'+pversion+'::documenttype_table::mo',Corp2_Raw_MO.Layouts.DocTypeTable,CSV(SEPARATOR([[',']]), quote('"'), TERMINATOR(['\r\n', '\n']))); 
		export OfficerPartyType_table    := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files +'lookup::corp2::'+pversion+'::officerpartyType_table::mo',Corp2_Raw_MO.Layouts.OfficerTypeTable,CSV(SEPARATOR([[',']]), quote('"'), TERMINATOR(['\r\n', '\n']))); 
		export FixedNames                := corp2_Raw_MO.File_names_in(Names.logical);
																			
	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Address,    Corp2_Raw_MO.Layouts.AddressLayoutBase, Address);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Filing,  	 Corp2_Raw_MO.Layouts.FilingLayoutBase, Filing);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Corporation,Corp2_Raw_MO.Layouts.CorporationLayoutBase, Corporation);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Names, 		 Corp2_Raw_MO.Layouts.NamesLayoutBase,  Names);	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Officer, 	 Corp2_Raw_MO.Layouts.OfficerLayoutBase, Officer);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Stock, 	   Corp2_Raw_MO.Layouts.StockLayoutBase, Stock);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.merger,     Corp2_Raw_MO.Layouts.mergerLayoutBase, merger);	
		
	END;

END;