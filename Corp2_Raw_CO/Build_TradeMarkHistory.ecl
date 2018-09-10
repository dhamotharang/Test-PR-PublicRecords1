IMPORT corp2, corp2_mapping, corp2_raw_co, tools, versioncontrol;

EXPORT Build_TradeMarkHistory(
	STRING		pFileDate,
	STRING		pTMFileDate,	
	STRING		pVersion,
	BOOLEAN		pUseProd,
	BOOLEAN		pOverwrite			= true,	
	BOOLEAN		pCompress				= true,
	BOOLEAN		pCsvout					= true,
	STRING		pSeparator			= '|',
	STRING		pTerminator			= '\r\n',
	STRING		pQuote					= '"',
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMChange   			=	if(Corp2_Raw_CO._Flags(pfiledate,ptmfiledate,pUseProd).Input.TMChange, Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.TMChange.logical, dataset([], Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMCorrection   	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmCorrection.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMExpired   	 		= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmExpired.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMRegistration 	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmRegistration.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMRenewal   			= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmRenewal.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMTransfer   	 	= if(Corp2_Raw_CO._Flags(pfiledate,ptmfiledate,pUseProd).Input.tmTransfer, Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmTransfer.logical, dataset([], Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMWithdraw   	 	= if(Corp2_Raw_CO._Flags(pfiledate,ptmfiledate,pUseProd).Input.tmWithdraw, Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmWithdraw.logical, dataset([], Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pTMHistory		 	 	= if(Corp2_Raw_CO._Flags().Base.TMHistory, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.TMHistory.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutIn))
) := MODULE
	
	// Combine the current input trademark history file and append update data to it.
	AppendUpdates	:= pTMHistory + pTMChange + pTMCorrection + pTMExpired + pTMRenewal + pTMTransfer + pTMWithdraw + pTMRegistration;

	NewTMHistory 	:= DEDUP(SORT(DISTRIBUTE(AppendUpdates, HASH(trademarkid)), record, LOCAL),record, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_CO.Filenames(pversion).Base.tmHistory.New, NewTMHistory, Build_TMHistory);

	EXPORT All := sequential(
														Build_TMHistory,
														Corp2_Raw_CO.promote(pversion).tmHistoryfiles.New2Built,
														Corp2_Raw_CO.promote().tmHistoryfiles.Built2QA
													);
END;