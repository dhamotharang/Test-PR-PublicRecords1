import corp2_mapping, corp2_raw_mi, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
												 
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.CorpMaster, Corp2_Raw_MI.Layouts.CorporationLayoutIn, CorpMaster,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
												
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.AssumedName, Corp2_Raw_MI.Layouts.AssumedNamedLayoutIn, AssumedName,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.GeneralPartner, Corp2_Raw_MI.Layouts.GeneralPartnerLayoutIn, GeneralPartner,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.History, Corp2_Raw_MI.Layouts.HistoryLayoutIn, History,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.LLC, Corp2_Raw_MI.Layouts.LLCLayoutIn, LLC,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.LP, Corp2_Raw_MI.Layouts.LPLayoutIn, LP,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_MI.Filenames(pversion, pUseOtherEnvironment).Input.NameRegistration, Corp2_Raw_MI.Layouts.NameRegLayoutIn, NameRegistration,
												'CSV',,pTerminator := ['\n','\r\n','\n\r'], pSeparator := [','], pHeading := 1);
	END;

END;