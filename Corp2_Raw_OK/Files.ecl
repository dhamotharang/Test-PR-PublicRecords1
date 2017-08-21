import corp2, tools, Corp2_Raw_OK;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Version
	// --------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.RawLayoutIN,
		                     Corp, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.Entity_01_Layout,
		                     f01, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.Address_02_Layout,
		                     f02, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.Agent_03_Layout,
		                     f03, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.Officer_04_Layout,
		                     f04, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.Names_05_Layout,
		                     f05, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.AssocEnt_06_Layout,
		                     f06, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.StockData_07_Layout,
		                     f07, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.StockInfo_08_Layout,
		                     f08, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.CorpType_12_Layout,
		                     f12, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		tools.mac_FilesInput(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Input.Corp, Corp2_Raw_OK.Layouts.CorpFiling_17_Layout,
		                     f17, 'CSV',,, pTerminator := ['\r\n','\n'], pSeparator := '~');	
		
		// Extract by record type into separate files
		EXPORT f01_Entity	    := f01.Logical(f01_record_header = '01' and corp2.t2u(f01_filing_number) not in ['FILING_NUM','FILING_NUMBER']);
		EXPORT f02_Address 	  := f02.Logical(f02_record_header = '02' and corp2.t2u(f02_address_id) <> 'ADDRESS_ID');	
		EXPORT f03_Agent 		  := f03.Logical(f03_record_header = '03' and corp2.t2u(f03_filing_number) not in ['FILING_NUM','FILING_NUMBER']);	
		EXPORT f04_Officer 	  := f04.Logical(f04_record_header = '04' and corp2.t2u(f04_filing_number) not in ['FILING_NUM','FILING_NUMBER']);
		EXPORT f05_Names 		  := f05.Logical(f05_record_header = '05' and corp2.t2u(f05_filing_number) not in ['FILING_NUM','FILING_NUMBER']);
		EXPORT f06_AssocEnt   := f06.Logical(f06_record_header = '06' and corp2.t2u(f06_filing_number) not in ['FILING_NUM','FILING_NUMBER']);	
		EXPORT f07_StockData  := f07.Logical(f07_record_header = '07' and corp2.t2u(f07_filing_number) not in ['FILING_NUM','FILING_NUMBER']);	
		EXPORT f08_StockInfo  := f08.Logical(f08_record_header = '08' and corp2.t2u(f08_filing_number) not in ['FILING_NUM','FILING_NUMBER']);	
		EXPORT f12_CorpType   := f12.Logical(f12_record_header = '12' and corp2.t2u(f12_corp_type_id) <> 'CORP_TYPE_ID');	
		EXPORT f17_CorpFiling := f17.Logical(f17_record_header = '17' and corp2.t2u(f17_filing_number) not in ['FILING_NUM','FILING_NUMBER']);
	END;

	// Base File Version
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f01_Entity,     Corp2_Raw_OK.Layouts.Entity_01_LayoutBASE,     f01_Entity);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f02_Address,    Corp2_Raw_OK.Layouts.Address_02_LayoutBASE,    f02_Address);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f03_Agent,      Corp2_Raw_OK.Layouts.Agent_03_LayoutBASE,      f03_Agent);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f04_Officer,    Corp2_Raw_OK.Layouts.Officer_04_LayoutBASE,    f04_Officer);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f05_Names,      Corp2_Raw_OK.Layouts.Names_05_LayoutBASE,      f05_Names);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f06_AssocEnt,   Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBASE,   f06_AssocEnt);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f07_StockData,  Corp2_Raw_OK.Layouts.StockData_07_LayoutBASE,  f07_StockData);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f08_StockInfo,  Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBASE,  f08_StockInfo);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f12_CorpType,   Corp2_Raw_OK.Layouts.CorpType_12_LayoutBASE,   f12_CorpType);
		tools.mac_FilesBase(Corp2_Raw_OK.Filenames(pversion, pUseOtherEnvironment).Base.f17_CorpFiling, Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBASE, f17_CorpFiling);

	END;

END;

