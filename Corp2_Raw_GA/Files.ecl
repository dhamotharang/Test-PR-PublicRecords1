import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Input.Corporation, Corp2_Raw_GA.Layouts.CorporationLayoutIn, Corporation,
		                     'CSV', , pQuote := '', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);	
														
		tools.mac_FilesInput(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Input.RAgent,	Corp2_Raw_GA.Layouts.RAgentLayoutIn, RAgent,
		                     'CSV', , pQuote := '', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Input.Officer, Corp2_Raw_GA.Layouts.OfficerLayoutIn, Officer,
		                     'CSV', , pQuote := '', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
									 
		tools.mac_FilesInput(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Input.Address, Corp2_Raw_GA.Layouts.AddressLayoutIn, AddressIn,
		                     'CSV', , pQuote := '', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);

		Corp2_Raw_GA.Layouts.AddressLayoutIn	trfRemoveQuote(Corp2_Raw_GA.Layouts.AddressLayoutIn l):= transform
					SELF.BizEntityId	 :=	Stringlib.StringFilterOut(l.BizEntityId, '"');
					SELF.ControlNumber :=	Stringlib.StringFilterOut(l.ControlNumber, '"');
					SELF.StreetAddr1	 :=	Stringlib.StringFilterOut(l.StreetAddr1, '"');
					SELF.StreetAddr2	 :=	Stringlib.StringFilterOut(l.StreetAddr2, '"');
					SELF.City	         :=	Stringlib.StringFilterOut(l.City, '"');
					SELF.State	       :=	Stringlib.StringFilterOut(l.State, '"');
					SELF.Zip	         :=	Stringlib.StringFilterOut(l.Zip, '"');
					SELF.Country	     :=	Stringlib.StringFilterOut(l.Country, '"');
					SELF							 := l; 

		END;
    
		EXPORT Address	:=	PROJECT(AddressIn.Logical, trfRemoveQuote(LEFT));
		
		tools.mac_FilesInput(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Input.Stock, Corp2_Raw_GA.Layouts.StockLayoutIn, Stock,
		                     'CSV', , pQuote := '', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Input.filing, Corp2_Raw_GA.Layouts.filingLayoutIn, Filing,
		                     'CSV', , pQuote := '', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
														
	END;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Base.Corporation, Corp2_Raw_GA.Layouts.CorporationLayoutBase, Corporation);
		tools.mac_FilesBase(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Base.RAgent, 		 Corp2_Raw_GA.Layouts.RAgentLayoutBase, RAgent);
		tools.mac_FilesBase(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Base.Officer, 	   Corp2_Raw_GA.Layouts.OfficerLayoutBase, Officer);
		tools.mac_FilesBase(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Base.Address, 		 Corp2_Raw_GA.Layouts.AddressLayoutBase, Address);
		tools.mac_FilesBase(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Base.Stock, 			 Corp2_Raw_GA.Layouts.StockLayoutBase, Stock);
		tools.mac_FilesBase(Corp2_Raw_GA.Filenames(pversion, pUseOtherEnvironment).Base.Filing, 		 Corp2_Raw_GA.Layouts.FilingLayoutBase, filing);	
		
	END;

END;