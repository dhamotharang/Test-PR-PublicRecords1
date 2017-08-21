import ut, tools, Corp2_Raw_AK, corp2_mapping;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// -- Input Files   
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.CorpData, Layouts.CorpDataLayoutIn, CorpData,
		                      'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.CorpNames,	Layouts.CorpNamesLayoutIn, CorpNames,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
														
		tools.mac_FilesInput(Filenames(pversion, pUseOtherEnvironment).Input.CorpOfficer,	Layouts.CorpOfficerLayoutIn, CorpOfficer,
		                     'CSV', , pQuote := '', pTerminator := ['\r\n', '\n'], pSeparator := '\t');
	
		EXPORT CorpDataRaw				:= CorpData.logical;
		EXPORT CorpAddrFixed     	:= Corp2_Raw_AR.File_In_CorpData(CorpDataRaw);
														
	END;

	// -- Base Files  
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.CorpData,    Layouts.CorpDataLayoutBase, CorpData);
		
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.CorpNames,   Layouts.CorpNamesLayoutBase, CorpNames);
		
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.CorpOfficer, Layouts.CorpOfficerLayoutBase, CorpOfficer);
		
	END;

END;