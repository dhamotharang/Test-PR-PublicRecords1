IMPORT tools;

EXPORT Build_Bases(
	STRING																						pfiledate,
	STRING																						ptmfiledate,	
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	
	DATASET(Corp2_Raw_CO.Layouts.CorpMstrLayoutIn)		pInCorpMstr   			= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpMstr.logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpMstrLayoutBase)	pBaseCorpMstr 	 		= IF(Corp2_Raw_CO._Flags().Base.CorpMstr, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.CorpMstr.qa, DATASET([], Corp2_Raw_CO.Layouts.CorpMstrLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.CorpHistLayoutIn)		pInCorpHist1   			= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpHist1.logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpHistLayoutIn)		pInCorpHist2   			= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpHist2.logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpHistLayoutBase)	pBaseCorpHist 			= IF(Corp2_Raw_CO._Flags().Base.CorpHist, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.CorpHist.qa, DATASET([], Corp2_Raw_CO.Layouts.CorpHistLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutIn)		pInCorpTrdnm   	 		= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpTrdnm.logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase)	pBaseCorpTrdnm 	 		= IF(Corp2_Raw_CO._Flags().Base.CorpTrdnm, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.CorpTrdnm.qa, DATASET([], Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmChange   			= IF(Corp2_Raw_CO._Flags(pfiledate,ptmfiledate,pUseProd).Input.TMChange, Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.TMChange.logical, dataset([], Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmChange	 			= IF(Corp2_Raw_CO._Flags().Base.tmChange, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmChange.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmCorrection   	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmCorrection.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmCorrection 	= IF(Corp2_Raw_CO._Flags().Base.tmCorrection, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmCorrection.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmExpired   	 		= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmExpired.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmExpired 	 		= IF(Corp2_Raw_CO._Flags().Base.tmExpired, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmExpired.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmRegistration 	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmRegistration.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmRegistration	= IF(Corp2_Raw_CO._Flags().Base.tmRegistration, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmRegistration.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmRenewal   			= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmRenewal.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmRenewal 			= IF(Corp2_Raw_CO._Flags().Base.tmRenewal, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmRenewal.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmTransfer   	 	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmTransfer.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmTransfer 	 	= IF(Corp2_Raw_CO._Flags().Base.tmTransfer, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmTransfer.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)),
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn)		pIntmWithdraw   	 	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.tmWithdraw.logical,
	DATASET(Corp2_Raw_CO.Layouts.TradeMarkLayoutBase)	pBasetmWithdraw 	 	= IF(Corp2_Raw_CO._Flags().Base.tmWithdraw, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.tmWithdraw.qa, DATASET([], Corp2_Raw_CO.Layouts.TradeMarkLayoutBase))
) := MODULE

	EXPORT full_build := SEQUENTIAL(	
																	Corp2_Raw_CO.Build_Bases_CorpMstr(pfiledate,ptmfiledate,pversion,puseprod,pInCorpMstr,pBaseCorpMstr).ALL,
																	Corp2_Raw_CO.Build_Bases_CorpHist(pfiledate,ptmfiledate,pversion,puseprod,pInCorpHist1,pInCorpHist2,pBaseCorpHist).ALL,
																	Corp2_Raw_CO.Build_Bases_CorpTrdnm(pfiledate,ptmfiledate,pversion,puseprod,pInCorpTrdnm,pBaseCorpTrdnm).ALL,
																	Corp2_Raw_CO.Build_Bases_tmChange(pfiledate,ptmfiledate,pversion,puseprod,pIntmChange,pBasetmChange).ALL,
																	Corp2_Raw_CO.Build_Bases_tmCorrection(pfiledate,ptmfiledate,pversion,puseprod,pIntmCorrection,pBasetmCorrection).ALL,
																	Corp2_Raw_CO.Build_Bases_tmExpired(pfiledate,ptmfiledate,pversion,puseprod,pIntmExpired,pBasetmExpired).ALL,
																	Corp2_Raw_CO.Build_Bases_tmRegistration(pfiledate,ptmfiledate,pversion,puseprod,pIntmRegistration,pBasetmRegistration).ALL,
																	Corp2_Raw_CO.Build_Bases_tmRenewal(pfiledate,ptmfiledate,pversion,puseprod,pIntmRenewal,pBasetmRenewal).ALL,
																	Corp2_Raw_CO.Build_Bases_tmTransfer(pfiledate,ptmfiledate,pversion,puseprod,pIntmTransfer,pBasetmTransfer).ALL,
																	Corp2_Raw_CO.Build_Bases_tmWithdraw(pfiledate,ptmfiledate,pversion,puseprod,pIntmWithdraw,pBasetmWithdraw).ALL,
																	Promote(pversion).buildfiles.New2Built,
																	Promote().BuildFiles.Built2QA																	
																 );
																 
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CO.Build_Bases attribute')
									 );

END;