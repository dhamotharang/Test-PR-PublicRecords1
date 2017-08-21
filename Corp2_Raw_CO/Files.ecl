import corp2_mapping, Corp2_Raw_CO, tools;

EXPORT Files(STRING  pfiledate 	          = '',
						 STRING  ptmfiledate          = '',
						 STRING  pversion 	          = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(pfiledate, pUseOtherEnvironment).Input.CorpMstr, 			   Corp2_Raw_CO.Layouts.CorpMstrLayoutIn, 	CorpMstr,
		                    'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(pfiledate, pUseOtherEnvironment).Input.CorpTrdnm, 		   Corp2_Raw_CO.Layouts.CorpTrdnmLayoutIn, 	CorpTrdnm,
		                    'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
		
		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(pfiledate, pUseOtherEnvironment).Input.CorpHist1, 			 Corp2_Raw_CO.Layouts.CorpHistLayoutIn, 	CorpHist1,
		                    'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);
														
		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(pfiledate, pUseOtherEnvironment).Input.CorpHist2, 			 Corp2_Raw_CO.Layouts.CorpHistLayoutIn, 	CorpHist2,
		                    'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '\t', pHeading := 1);														
														
		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMChange, 	     Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMChange,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');
		
		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMCorrection,   Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMCorrection,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMExpired, 	   Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMExpired,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMRegistration, Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMRegistration,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMRenewal, 		 Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMRenewal,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMTransfer, 		 Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMTransfer,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');

		tools.mac_FilesInput(Corp2_Raw_CO.Filenames(ptmfiledate, pUseOtherEnvironment).Input.TMWithdraw, 		 Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMWithdraw,
												'CSV', , pQuote := '"', pTerminator := ['\r','\r\n','\n'], pSeparator := '|');												
		

		EXPORT CorpHist							:= CorpHist1.Logical + CorpHist2.Logical;

	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	/////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.CorpMstr, 			Corp2_Raw_CO.Layouts.CorpMstrLayoutBase, 	CorpMstr);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.CorpTrdnm, 			Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase, CorpTrdnm);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.CorpHist, 			Corp2_Raw_CO.Layouts.CorpHistLayoutBase, 	CorpHist);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMChange, 			Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMChange);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMCorrection, 	Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMCorrection);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMExpired, 			Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMExpired);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMRegistration, Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMRegistration);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMRenewal, 			Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMRenewal);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMTransfer, 		Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMTransfer);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMWithdraw, 		Corp2_Raw_CO.Layouts.TradeMarkLayoutBase, TMWithdraw);
		tools.mac_FilesBase(Corp2_Raw_CO.Filenames(pversion, pUseOtherEnvironment).Base.TMHistory,   		Corp2_Raw_CO.Layouts.TradeMarkLayoutIn, 	TMHistory);		

	END;

END;