import ut, tools, Corp2_Raw_ND;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
	
	  // Vendor Data files
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.Corp1,       Corp2_Raw_ND.Layouts.CorpLayoutIn, Corp1);	
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.Corp2,	     Corp2_Raw_ND.Layouts.CorpLayoutIn, Corp2);
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.FictName1,   Corp2_Raw_ND.Layouts.FictNameLayoutIn, FictName1);
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.FictName2,   Corp2_Raw_ND.Layouts.FictNameLayoutIn, FictName2);														
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.Partnership, Corp2_Raw_ND.Layouts.PartnershipLayoutIn, Partnership);														
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.TradeMark1,  Corp2_Raw_ND.Layouts.TradeMarkLayoutIn, TradeMark1);														
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.TradeMark2,  Corp2_Raw_ND.Layouts.TradeMarkLayoutIn, TradeMark2);
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.TradeName1,  Corp2_Raw_ND.Layouts.TradeNameLayoutIn, TradeName1);														
		tools.mac_FilesInput(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Input.TradeName2,  Corp2_Raw_ND.Layouts.TradeNameLayoutIn, TradeName2);
	
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Base.Corp,        Corp2_Raw_ND.Layouts.CorpLayoutBase, Corp);
		tools.mac_FilesBase(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Base.FictName, 	 Corp2_Raw_ND.Layouts.FictNameLayoutBase, FictName);
		tools.mac_FilesBase(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Base.Partnership, Corp2_Raw_ND.Layouts.PartnershipLayoutBase, Partnership);	
		tools.mac_FilesBase(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Base.TradeMark,   Corp2_Raw_ND.Layouts.TradeMarkLayoutBase, TradeMark);	
		tools.mac_FilesBase(Corp2_Raw_ND.Filenames(pversion, pUseOtherEnvironment).Base.TradeName,   Corp2_Raw_ND.Layouts.TradeNameLayoutBase, TradeName);	
	END;

END;

