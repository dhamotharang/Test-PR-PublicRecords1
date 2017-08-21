import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Input.CorpDataExport, Corp2_Raw_MA.Layouts.CorpDataExportLayoutIn, CorpDataExport,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '|', pHeading := 1);	
														
		tools.mac_FilesInput(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Input.CorpIndividualExport,	Corp2_Raw_MA.Layouts.CorpIndividualExportLayoutIn, CorpIndividualExport,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '|', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Input.CorpNameChange, Corp2_Raw_MA.Layouts.CorpNameChangeLayoutIn, CorpNameChange,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '|', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Input.CorpMerger, Corp2_Raw_MA.Layouts.CorpMergerLayoutIn, CorpMerger,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '|', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Input.CorpDetailExport, Corp2_Raw_MA.Layouts.CorpDetailExportLayoutIn, CorpDetailExport,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '|', pHeading := 1);

		tools.mac_FilesInput(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Input.CorpStockExport, Corp2_Raw_MA.Layouts.CorpStockExportLayoutIn, CorpStockExport,
		                        'CSV', , pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := '|', pHeading := 1);
	 
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Base.CorpDataExport, Corp2_Raw_MA.Layouts.CorpDataExportLayoutBase, CorpDataExport);
		tools.mac_FilesBase(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Base.CorpIndividualExport, Corp2_Raw_MA.Layouts.CorpIndividualExportLayoutBase, CorpIndividualExport);
		tools.mac_FilesBase(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Base.CorpNameChange, Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase, CorpNameChange);
		tools.mac_FilesBase(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Base.CorpMerger, Corp2_Raw_MA.Layouts.CorpMergerLayoutBase, CorpMerger);
		tools.mac_FilesBase(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Base.CorpDetailExport, Corp2_Raw_MA.Layouts.CorpDetailExportLayoutBase, CorpDetailExport);		
		tools.mac_FilesBase(Corp2_Raw_MA.Filenames(pversion, pUseOtherEnvironment).Base.CorpStockExport, Corp2_Raw_MA.Layouts.CorpStockExportLayoutBase, CorpStockExport);	
	END;

END;	