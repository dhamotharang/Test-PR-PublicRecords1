IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																										pfiledate,
	STRING																										pversion,
	BOOLEAN																	        					pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.AmendHistIn)									pInAmendHist   	  = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.AmendHist.logical,
	DATASET(Corp2_Raw_MD.Layouts.AmendHistLayoutBase)					pBaseAmendHist 	  = IF(Corp2_Raw_MD._Flags.Base.AmendHist, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.AmendHist.qa, DATASET([], Corp2_Raw_MD.Layouts.AmendHistLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.AmendHistIn)									pInARCAmendHist   = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ARCAmendHist.logical,
	DATASET(Corp2_Raw_MD.Layouts.AmendHistLayoutBase)					pBaseARCAmendHist = IF(Corp2_Raw_MD._Flags.Base.AmendHist, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.AmendHist.qa, DATASET([], Corp2_Raw_MD.Layouts.AmendHistLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusAddrIn)										pInBusAddr   		  = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusAddr.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusAddrLayoutBase)			  		pBaseBusAddr 		  = IF(Corp2_Raw_MD._Flags.Base.BusAddr, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusAddr.qa, DATASET([], Corp2_Raw_MD.Layouts.BusAddrLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusAddrIn)										pInARCBusAddr   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ARCBusAddr.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusAddrLayoutBase)			  		pBaseARCBusAddr 	= IF(Corp2_Raw_MD._Flags.Base.BusAddr, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusAddr.qa, DATASET([], Corp2_Raw_MD.Layouts.BusAddrLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusEntityIn)									pInBusEntity   	  = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusEntity.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusEntityLayoutBase)					pBaseBusEntity 	  = IF(Corp2_Raw_MD._Flags.Base.BusEntity, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusEntity.qa, DATASET([], Corp2_Raw_MD.Layouts.BusEntityLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusNmIndxIn)									pInBusNmIndx   	  = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusNmIndx.logical,
  DATASET(Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase)					pBaseBusNmIndx   	= IF(Corp2_Raw_MD._Flags.Base.BusNmIndx, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusNmIndx.qa, DATASET([], Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusNmIndxIn)									pInARCBusNmIndx   = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ARCBusNmIndx.logical,
  DATASET(Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase)					pBaseARCBusNmIndx = IF(Corp2_Raw_MD._Flags.Base.BusNmIndx, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusNmIndx.qa, DATASET([], Corp2_Raw_MD.Layouts.BusNmIndxLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusTypeIn)										pInBusType  		  = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusType.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusTypeLayoutBase)						pBaseBusType		  = IF(Corp2_Raw_MD._Flags.Base.BusType, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusType.qa, DATASET([], Corp2_Raw_MD.Layouts.BusTypeLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.BusCommentIn)								pInBusComment     = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusComment.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusCommentLayoutBase)				pBaseBusComment	  = IF(Corp2_Raw_MD._Flags.Base.BusComment, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusComment.qa, DATASET([], Corp2_Raw_MD.Layouts.BusCommentLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.EntityStatusIn)							pInEntityStatus   = Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.EntityStatus.logical,
  DATASET(Corp2_Raw_MD.Layouts.EntityStatusLayoutBase)			pBaseEntityStatus = IF(Corp2_Raw_MD._Flags.Base.EntityStatus, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.EntityStatus.qa, DATASET([], Corp2_Raw_MD.Layouts.EntityStatusLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.FilingTypeIn)				  			pInFilingType  		= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.FilingType.logical,
	DATASET(Corp2_Raw_MD.Layouts.FilingTypeLayoutBase)	 			pBaseFilingType		= IF(Corp2_Raw_MD._Flags.Base.FilingType, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.FilingType.qa, DATASET([], Corp2_Raw_MD.Layouts.FilingTypeLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.TradeNameIn)	 								pInTradeName   		= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.TradeName.logical,
	DATASET(Corp2_Raw_MD.Layouts.TradeNameLayoutBase) 				pBaseTradeName		= IF(Corp2_Raw_MD._Flags.Base.TradeName, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.TradeName.qa, DATASET([], Corp2_Raw_MD.Layouts.TradeNameLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.FilmIndxIn)				 				  pInFilmIndx  			= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.FilmIndx.logical,
	DATASET(Corp2_Raw_MD.Layouts.FilmIndxLayoutBase)	 				pBaseFilmIndx			= IF(Corp2_Raw_MD._Flags.Base.FilmIndx, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.FilmIndx.qa, DATASET([], Corp2_Raw_MD.Layouts.FilmIndxLayoutBase)),
	DATASET(Corp2_Raw_MD.Layouts.ReserveNameIn)	 							pInReserveName   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ReserveName.logical,
	DATASET(Corp2_Raw_MD.Layouts.ReserveNameLayoutBase) 			pBaseReserveName	= IF(Corp2_Raw_MD._Flags.Base.ReserveName, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.ReserveName.qa, DATASET([], Corp2_Raw_MD.Layouts.ReserveNameLayoutBase))
	
	
) := MODULE

	EXPORT full_build := sequential( Corp2_Raw_MD.Build_Bases_AmendHist(pfiledate,pversion,pUseOtherEnvironment,pInAmendHist,pBaseAmendHist).ALL,
																	 Corp2_Raw_MD.Build_Bases_ARCAmendHist(pfiledate,pversion,pUseOtherEnvironment,pInARCAmendHist,pBaseARCAmendHist).ALL,
																	 Corp2_Raw_MD.Build_Bases_BusAddr(pfiledate,pversion,pUseOtherEnvironment,pInBusAddr,pBaseBusAddr).ALL,
																	 Corp2_Raw_MD.Build_Bases_ARCBusAddr(pfiledate,pversion,pUseOtherEnvironment,pInARCBusAddr,pBaseARCBusAddr).ALL,
																	 Corp2_Raw_MD.Build_Bases_BusEntity(pfiledate,pversion,pUseOtherEnvironment,pInBusEntity,pBaseBusEntity).ALL,
																	 Corp2_Raw_MD.Build_Bases_BusNmIndx(pfiledate,pversion,pUseOtherEnvironment,pInBusNmIndx,pBaseBusNmIndx).ALL,
																	 Corp2_Raw_MD.Build_Bases_ARCBusNmIndx(pfiledate,pversion,pUseOtherEnvironment,pInARCBusNmIndx,pBaseARCBusNmIndx).ALL,
																	 Corp2_Raw_MD.Build_Bases_BusType(pfiledate,pversion,pUseOtherEnvironment,pInBusType,pBaseBusType).ALL,
																	 Corp2_Raw_MD.Build_Bases_BusComment(pfiledate,pversion,pUseOtherEnvironment,pInBusComment,pBaseBusComment).ALL,
																	 Corp2_Raw_MD.Build_Bases_EntityStatus(pfiledate,pversion,pUseOtherEnvironment,pInEntityStatus,pBaseEntityStatus).ALL,
																	 Corp2_Raw_MD.Build_Bases_FilingType(pfiledate,pversion,pUseOtherEnvironment,pInFilingType,pBaseFilingType).ALL,
																	 Corp2_Raw_MD.Build_Bases_TradeName(pfiledate,pversion,pUseOtherEnvironment,pInTradeName,pBaseTradeName).ALL,
																	 Corp2_Raw_MD.Build_Bases_FilmIndx(pfiledate,pversion,pUseOtherEnvironment,pInFilmIndx,pBaseFilmIndx).ALL,
																	 Corp2_Raw_MD.Build_Bases_ReserveName(pfiledate,pversion,pUseOtherEnvironment,pInReserveName,pBaseReserveName).ALL,
																		
																	 Promote(pversion).buildfiles.New2Built,
																	 Promote().BuildFiles.Built2QA
																  );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases attribute')
									 );

END;
