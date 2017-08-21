import ut, tools, Corp2_Mapping;

EXPORT Files(STRING  pversion = '',
						 Boolean pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Addresses, Corp2_Raw_WV.Layouts.AddressesLayoutIn, addresses,
   		                   'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);	
  
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.amendments,	Corp2_Raw_WV.Layouts.amendmentsLayoutIn, amendments,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.annualreports, Corp2_Raw_WV.Layouts.annualreportsLayoutIn, annualreports,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.corporations, Corp2_Raw_WV.Layouts.corporationsLayoutIn, corporations,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.Dissolutions, Corp2_Raw_WV.Layouts.DissolutionsLayoutIn, dissolutions,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.dbas, Corp2_Raw_WV.Layouts.dbasLayoutIn,  dbas,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
												 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.mergers, Corp2_Raw_WV.Layouts.mergersLayoutIn, mergers,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.namechanges, Corp2_Raw_WV.Layouts.namechangesLayoutIn, namechanges,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);
												 
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.subsidiaries, Corp2_Raw_WV.Layouts.subsidiariesLayoutIn, subsidiaries,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '~', pHeading := 1);		
	
	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.addresses, 		 Corp2_Raw_WV.Layouts.AddressesLayoutBase, addresses);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.amendments, 	 	 Corp2_Raw_WV.Layouts.amendmentsLayoutBase, amendments);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.annualreports,  Corp2_Raw_WV.Layouts.annualreportsLayoutBase, annualreports);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.corporations,   Corp2_Raw_WV.Layouts.corporationsLayoutBase, corporations);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.dissolutions,   Corp2_Raw_WV.Layouts.dissolutionsLayoutBase, dissolutions);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.dbas, 		 		   Corp2_Raw_WV.Layouts.dbasLayoutBase,  dbas);	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.mergers, 		 	 Corp2_Raw_WV.Layouts.mergersLayoutBase, mergers);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.namechanges, 	 Corp2_Raw_WV.Layouts.namechangesLayoutBase, namechanges);
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.subsidiaries,   Corp2_Raw_WV.Layouts.subsidiariesLayoutBase, subsidiaries);	
		
	END;

END;