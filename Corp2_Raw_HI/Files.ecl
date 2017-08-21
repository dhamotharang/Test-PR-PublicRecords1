import corp2_mapping, corp2_raw_hi, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		tools.mac_FilesInput(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Input.CompanyMaster, Corp2_Raw_HI.Layouts.CompanyMasterLayoutIn, CompanyMaster,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Input.CompanyOfficer, Corp2_Raw_HI.Layouts.CompanyOfficerLayoutIn, CompanyOfficer,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Input.CompanyStock, Corp2_Raw_HI.Layouts.CompanyStockLayoutIn, CompanyStock,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Input.CompanyTransaction, Corp2_Raw_HI.Layouts.CompanyTransactionLayoutIn, CompanyTransaction,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Input.TtsMaster, Corp2_Raw_HI.Layouts.TTSMasterLayoutIn, TTSMaster,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Input.TtsTransaction, Corp2_Raw_HI.Layouts.TTSTransactionLayoutIn, TTSTransaction,
												'CSV', ,pQuote := '"', pTerminator := ['\n','\r\n','\n\r'], pSeparator := ',', pHeading := 1);

	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Base.CompanyMaster, Corp2_Raw_HI.Layouts.CompanyMasterLayoutBase, CompanyMaster);
		tools.mac_FilesBase(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Base.CompanyOfficer, Corp2_Raw_HI.Layouts.CompanyOfficerLayoutBase, CompanyOfficer);
		tools.mac_FilesBase(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Base.CompanyStock, Corp2_Raw_HI.Layouts.CompanyStockLayoutBase, CompanyStock);		
		tools.mac_FilesBase(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Base.CompanyTransaction , Corp2_Raw_HI.Layouts.CompanyTransactionLayoutBase, CompanyTransaction);
		tools.mac_FilesBase(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Base.TTSMaster, Corp2_Raw_HI.Layouts.TTSMasterLayoutBase, TtsMaster);
		tools.mac_FilesBase(Corp2_Raw_HI.Filenames(pversion, pUseOtherEnvironment).Base.TTSTransaction, Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase, TtsTransaction);			

	END;

END;