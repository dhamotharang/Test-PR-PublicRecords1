IMPORT tools, ut;

EXPORT Build_Bases(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	
	DATASET(Corp2_Raw_CT.Layouts.BusFilingLayoutIn)		pInBusFiling 	 = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fBusFiling,
	DATASET(Corp2_Raw_CT.Layouts.BusFilingLayoutBase)	pBaseBusFiling = IF(Corp2_Raw_CT._Flags.Base.BusFiling, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusFiling.qa, DATASET([], Corp2_Raw_CT.Layouts.BusFilingLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.BusMasterLayoutIn)		pInBusMaster   = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fBusMaster,
	DATASET(Corp2_Raw_CT.Layouts.BusMasterLayoutBase)	pBaseBusMaster = IF(Corp2_Raw_CT._Flags.Base.BusMaster, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusMaster.qa, DATASET([], Corp2_Raw_CT.Layouts.BusMasterLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.BusMergerLayoutIn)		pInBusMerger   = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fBusMerger,
	DATASET(Corp2_Raw_CT.Layouts.BusMergerLayoutBase)	pBaseBusMerger = IF(Corp2_Raw_CT._Flags.Base.BusMerger, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusMerger.qa, DATASET([], Corp2_Raw_CT.Layouts.BusMergerLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.BusOtherLayoutIn)		pInBusOther    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fBusOther,
	DATASET(Corp2_Raw_CT.Layouts.BusOtherLayoutBase)	pBaseBusOther	 = IF(Corp2_Raw_CT._Flags.Base.BusOther, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusOther.qa, DATASET([], Corp2_Raw_CT.Layouts.BusOtherLayoutBase)),
  
	DATASET(Corp2_Raw_CT.Layouts.BusReserveLayoutIn)	pInBusReserve  = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fBusReserve,
	DATASET(Corp2_Raw_CT.Layouts.BusReserveLayoutBase)pBaseBusReserve= IF(Corp2_Raw_CT._Flags.Base.BusReserve, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.BusReserve.qa, DATASET([], Corp2_Raw_CT.Layouts.BusReserveLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.CorpsLayoutIn)		    pInCorps       = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fCorps,
	DATASET(Corp2_Raw_CT.Layouts.CorpsLayoutBase)	    pBaseCorps	   = IF(Corp2_Raw_CT._Flags.Base.Corps, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.Corps.qa, DATASET([], Corp2_Raw_CT.Layouts.CorpsLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.DLMLPartLayoutIn)		pInDLMLPart    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fDLMLPart,
	DATASET(Corp2_Raw_CT.Layouts.DLMLPartLayoutBase)	pBaseDLMLPart	 = IF(Corp2_Raw_CT._Flags.Base.DLMLPart, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.DLMLPart.qa, DATASET([], Corp2_Raw_CT.Layouts.DLMLPartLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.DLMTCorpLayoutIn)		pInDLMTCorp    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fDLMTCorp,
	DATASET(Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase)	pBaseDLMTCorp	 = IF(Corp2_Raw_CT._Flags.Base.DLMTCorp, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.DLMTCorp.qa, DATASET([], Corp2_Raw_CT.Layouts.DLMTCorpLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.DLMTPartLayoutIn)		pInDLMTPart    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fDLMTPart,
	DATASET(Corp2_Raw_CT.Layouts.DLMTPartLayoutBase)	pBaseDLMTPart	 = IF(Corp2_Raw_CT._Flags.Base.DLMTPart, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.DLMTPart.qa, DATASET([], Corp2_Raw_CT.Layouts.DLMTPartLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.FilmIndxLayoutIn)		pInFilmIndx    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fFilmIndx,
	DATASET(Corp2_Raw_CT.Layouts.FilmIndxLayoutBase)	pBaseFilmIndx	 = IF(Corp2_Raw_CT._Flags.Base.FilmIndx, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FilmIndx.qa, DATASET([], Corp2_Raw_CT.Layouts.FilmIndxLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.FLMLPartLayoutIn)		pInFLMLPart    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fFLMLPart,
	DATASET(Corp2_Raw_CT.Layouts.FLMLPartLayoutBase)	pBaseFLMLPart	 = IF(Corp2_Raw_CT._Flags.Base.FLMLPart, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FLMLPart.qa, DATASET([], Corp2_Raw_CT.Layouts.FLMLPartLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.FLMTCorpLayoutIn)		pInFLMTCorp    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fFLMTCorp,
	DATASET(Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase)	pBaseFLMTCorp	 = IF(Corp2_Raw_CT._Flags.Base.FLMTCorp, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FLMTCorp.qa, DATASET([], Corp2_Raw_CT.Layouts.FLMTCorpLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.FLMTPartLayoutIn)		pInFLMTPart    = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fFLMTPart,
	DATASET(Corp2_Raw_CT.Layouts.FLMTPartLayoutBase)	pBaseFLMTPart	 = IF(Corp2_Raw_CT._Flags.Base.FLMTPart, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.FLMTPart.qa, DATASET([], Corp2_Raw_CT.Layouts.FLMTPartLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.ForStatLayoutIn)		  pInForStat     = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fForStat,
	DATASET(Corp2_Raw_CT.Layouts.ForStatLayoutBase)	  pBaseForStat	 = IF(Corp2_Raw_CT._Flags.Base.ForStat, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.ForStat.qa, DATASET([], Corp2_Raw_CT.Layouts.ForStatLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.GeneralLayoutIn)		  pInGeneral     = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fGeneral,
	DATASET(Corp2_Raw_CT.Layouts.GeneralLayoutBase)	  pBaseGeneral	 = IF(Corp2_Raw_CT._Flags.Base.General, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.General.qa, DATASET([], Corp2_Raw_CT.Layouts.GeneralLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.NameChgLayoutIn)		  pInNameChg     = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fNameChg,
	DATASET(Corp2_Raw_CT.Layouts.NameChgLayoutBase)	  pBaseNameChg	 = IF(Corp2_Raw_CT._Flags.Base.NameChg, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.NameChg.qa, DATASET([], Corp2_Raw_CT.Layouts.NameChgLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.PrncipalLayoutIn)		pInPrncipal   = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fPrncipal,
	DATASET(Corp2_Raw_CT.Layouts.PrncipalLayoutBase)	pBasePrncipal = IF(Corp2_Raw_CT._Flags.Base.Prncipal, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.Prncipal.qa, DATASET([], Corp2_Raw_CT.Layouts.PrncipalLayoutBase)),
	
	DATASET(Corp2_Raw_CT.Layouts.StockLayoutIn)		    pInStock       = Corp2_Raw_CT.Files(pfiledate,puseprod).Input.fStock,
	DATASET(Corp2_Raw_CT.Layouts.StockLayoutBase)	    pBaseStock	   = IF(Corp2_Raw_CT._Flags.Base.Stock, Corp2_Raw_CT.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_CT.Layouts.StockLayoutBase))
	
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_CT.Build_Bases_BusFiling (pfiledate,pversion,puseprod,pInBusFiling,pBaseBusFiling).ALL,
																		Corp2_Raw_CT.Build_Bases_BusMaster (pfiledate,pversion,puseprod,pInBusMaster,pBaseBusMaster).ALL,
																		Corp2_Raw_CT.Build_Bases_BusMerger (pfiledate,pversion,puseprod,pInBusMerger,pBaseBusMerger).ALL,
																		Corp2_Raw_CT.Build_Bases_BusOther  (pfiledate,pversion,puseprod,pInBusOther,pBaseBusOther).ALL,
																		Corp2_Raw_CT.Build_Bases_BusReserve(pfiledate,pversion,puseprod,pInBusReserve,pBaseBusReserve).ALL,
																		Corp2_Raw_CT.Build_Bases_Corps     (pfiledate,pversion,puseprod,pInCorps,pBaseCorps).ALL,
																		Corp2_Raw_CT.Build_Bases_DLMLPart  (pfiledate,pversion,puseprod,pInDLMLPart,pBaseDLMLPart).ALL,	
																		Corp2_Raw_CT.Build_Bases_DLMTCorp  (pfiledate,pversion,puseprod,pInDLMTCorp,pBaseDLMTCorp).ALL,
																		Corp2_Raw_CT.Build_Bases_DLMTPart  (pfiledate,pversion,puseprod,pInDLMTPart,pBaseDLMTPart).ALL,
																		Corp2_Raw_CT.Build_Bases_FilmIndx  (pfiledate,pversion,puseprod,pInFilmIndx,pBaseFilmIndx).ALL,
																		Corp2_Raw_CT.Build_Bases_FLMLPart  (pfiledate,pversion,puseprod,pInFLMLPart,pBaseFLMLPart).ALL,
																		Corp2_Raw_CT.Build_Bases_FLMTCorp  (pfiledate,pversion,puseprod,pInFLMTCorp,pBaseFLMTCorp).ALL,
																		Corp2_Raw_CT.Build_Bases_FLMTPart  (pfiledate,pversion,puseprod,pInFLMTPart,pBaseFLMTPart).ALL,
																		Corp2_Raw_CT.Build_Bases_ForStat   (pfiledate,pversion,puseprod,pInForStat,pBaseForStat).ALL,
																		Corp2_Raw_CT.Build_Bases_General   (pfiledate,pversion,puseprod,pInGeneral,pBaseGeneral).ALL,
																		Corp2_Raw_CT.Build_Bases_NameChg   (pfiledate,pversion,puseprod,pInNameChg,pBaseNameChg).ALL,
																		Corp2_Raw_CT.Build_Bases_Prncipal (pfiledate,pversion,puseprod,pInPrncipal,pBasePrncipal).ALL,
																		Corp2_Raw_CT.Build_Bases_Stock     (pfiledate,pversion,puseprod,pInStock,pBaseStock).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA	
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CT.Build_Bases attribute')
									 );

END;
