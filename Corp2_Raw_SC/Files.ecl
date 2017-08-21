import corp2_mapping, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_SC.Filenames(pversion, pUseOtherEnvironment).Input.CorpFile, Corp2_Raw_SC.Layouts.CorpFileLayoutIn, CorpFile,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_SC.Filenames(pversion, pUseOtherEnvironment).Input.CorpName, Corp2_Raw_SC.Layouts.CorpNameLayoutIn, CorpName,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_SC.Filenames(pversion, pUseOtherEnvironment).Input.CorpTXN, Corp2_Raw_SC.Layouts.CorpTXNLayoutIn, CorpTXN,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);

		EXPORT ForgnStateTable := dataset(Corp2_Raw_SC._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::forgnstatedesc::sc', Corp2_Raw_SC.Layouts.ForgnStateDescLookUpLayoutIn,
																			csv(separator([',']),quote('"'), terminator(['\r\n', '\n'])));
														

	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_SC.Filenames(pversion, pUseOtherEnvironment).Base.CorpFile, 	Corp2_Raw_SC.Layouts.CorpFileLayoutBase, CorpFile);
		tools.mac_FilesBase(Corp2_Raw_SC.Filenames(pversion, pUseOtherEnvironment).Base.CorpName, 	Corp2_Raw_SC.Layouts.CorpNameLayoutBase, CorpName);
		tools.mac_FilesBase(Corp2_Raw_SC.Filenames(pversion, pUseOtherEnvironment).Base.CorpTXN, 		Corp2_Raw_SC.Layouts.CorpTXNLayoutBase,  CorpTXN);		
	END;

END;