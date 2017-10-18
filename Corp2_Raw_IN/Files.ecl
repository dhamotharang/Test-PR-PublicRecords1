IMPORT corp2_mapping, corp2_raw_in, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
 	   
	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Input.CorpAgents, 			Corp2_Raw_IN.Layouts.CorpAgentsLayoutIn, 			 CorpAgents,
												'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1, pMaxLength := 4096);
		tools.mac_FilesInput(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Input.CorpCorporations, Corp2_Raw_IN.Layouts.CorpCorporationsLayoutIn, CorpCorporations,
												'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1, pMaxLength := 4096);
		tools.mac_FilesInput(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Input.CorpFilings,			Corp2_Raw_IN.Layouts.CorpFilingsLayoutIn,			 CorpFilings,
		                    'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1, pMaxLength := 4096);
		tools.mac_FilesInput(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Input.CorpMergers, 			Corp2_Raw_IN.Layouts.CorpMergersLayoutIn,			 CorpMergers,
		                    'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1, pMaxLength := 4096);
		tools.mac_FilesInput(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Input.CorpNames, 				Corp2_Raw_IN.Layouts.CorpNamesLayoutIn,			 	 CorpNames,
		                    'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1, pMaxLength := 4096);
		tools.mac_FilesInput(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Input.CorpOfficers, 		Corp2_Raw_IN.Layouts.CorpOfficersLayoutIn,		 CorpOfficers,
		                    'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t', pHeading := 1, pMaxLength := 4096);
    
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Base.CorpAgents, 			Corp2_Raw_IN.Layouts.CorpAgentsLayoutBase, 			 CorpAgents);
		tools.mac_FilesBase(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Base.CorpCorporations, Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase, CorpCorporations);
		tools.mac_FilesBase(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Base.CorpFilings,			Corp2_Raw_IN.Layouts.CorpFilingsLayoutBase,			 CorpFilings);
		tools.mac_FilesBase(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Base.CorpMergers, 			Corp2_Raw_IN.Layouts.CorpMergersLayoutBase,			 CorpMergers);
		tools.mac_FilesBase(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Base.CorpNames, 				Corp2_Raw_IN.Layouts.CorpNamesLayoutBase,			 	 CorpNames);
		tools.mac_FilesBase(Corp2_Raw_IN.Filenames(pversion, pUseOtherEnvironment).Base.CorpOfficers, 		Corp2_Raw_IN.Layouts.CorpOfficersLayoutBase,		 CorpOfficers);
		
	END;

END;