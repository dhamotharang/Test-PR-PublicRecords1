import corp2_mapping, corp2_raw_NE, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpAction, Corp2_Raw_NE.Layouts.CorpActionLayoutIn, CorpAction,
												 'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
												 
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpOfficers, Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn, CorpOfficers,
												 'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
												 
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.CorpEntity, Corp2_Raw_NE.Layouts.CorpEntityLayoutIn, CorpEntity,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
												 
		tools.mac_FilesInput(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Input.RegisterAgent, Corp2_Raw_NE.Layouts.RegisterAgentLayoutIn, RegisterAgent,
		                     'CSV', , pQuote := '"', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
	
		EXPORT  CorpTypeTable   := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::CorporationType::ne',Corp2_Raw_NE.Layouts.Lookup_CorpCode, CSV(SEPARATOR(['\t']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));
   	 			  
    EXPORT  TitleTypeTable  := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::PositionHeld::ne',Corp2_Raw_NE.Layouts.Lookup_TitleCode, CSV(SEPARATOR(['\t']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));
	 
		EXPORT  FilingTypeTable := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::ServiceType::ne',Corp2_Raw_NE.Layouts.Lookup_FilingCode, CSV(SEPARATOR(['\t']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));
		
		EXPORT  StateCodeTable  := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::ListOfStates::ne',Corp2_Raw_NE.Layouts.StateTypeCodeLayout,CSV(SEPARATOR(['\t']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));
   		 		  
   	EXPORT  CntryCodeTable  := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::' + pversion + '::NECountryCodes::ne',Corp2_Raw_NE.Layouts.CntryTypeCodeLayout, CSV(SEPARATOR(['\t']), QUOTE(''), TERMINATOR(['\r\n', '\n'])));
   	 				
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
			tools.mac_FilesBase(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Base.CorpAction, 	Corp2_Raw_NE.Layouts.CorpActionLayoutBase, 		CorpAction);
			
			tools.mac_FilesBase(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Base.CorpOfficers, Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase,  CorpOfficers);
			
			tools.mac_FilesBase(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Base.CorpEntity, 	Corp2_Raw_NE.Layouts.CorpEntityLayoutBase, 		CorpEntity);
			
			tools.mac_FilesBase(Corp2_Raw_NE.Filenames(pversion, pUseOtherEnvironment).Base.RegisterAgent,Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase, RegisterAgent);
			
	END;

END;