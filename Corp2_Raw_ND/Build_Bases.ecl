IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN																							puseprod,	
	
	DATASET(Corp2_Raw_ND.Layouts.CorpLayoutIn)				  pInCorp1   		   = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.Corp1.logical,
	DATASET(Corp2_Raw_ND.Layouts.CorpLayoutIn)					pInCorp2   			 = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.Corp2.logical,
	DATASET(Corp2_Raw_ND.Layouts.CorpLayoutBase)				pBaseCorp 			 = IF(Corp2_Raw_ND._Flags.Base.Corp, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.Corp.qa, DATASET([], Corp2_Raw_ND.Layouts.CorpLayoutBase)),
	
	DATASET(Corp2_Raw_ND.Layouts.FictNameLayoutIn)			pInFictName1   	 = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.FictName1.logical,
	DATASET(Corp2_Raw_ND.Layouts.FictNameLayoutIn)		  pInFictName2     = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.FictName2.logical,
	DATASET(Corp2_Raw_ND.Layouts.FictNameLayoutBase)	  pBaseFictName 	 = IF(Corp2_Raw_ND._Flags.Base.FictName, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.FictName.qa, DATASET([], Corp2_Raw_ND.Layouts.FictNameLayoutBase)),
  
	DATASET(Corp2_Raw_ND.Layouts.PartnershipLayoutIn)		pInPartnership   = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.Partnership.logical,
	DATASET(Corp2_Raw_ND.Layouts.PartnershipLayoutBase) pBasePartnership = IF(Corp2_Raw_ND._Flags.Base.Partnership, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.Partnership.qa, DATASET([], Corp2_Raw_ND.Layouts.PartnershipLayoutBase)),
	
	DATASET(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn)		  pInTradeMark1    = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeMark1.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeMarkLayoutIn)		  pInTradeMark2    = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeMark2.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeMarkLayoutBase)	  pBaseTradeMark	 = IF(Corp2_Raw_ND._Flags.Base.TradeMark, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.TradeMark.qa, DATASET([], Corp2_Raw_ND.Layouts.TradeMarkLayoutBase)),
	
	DATASET(Corp2_Raw_ND.Layouts.TradeNameLayoutIn)		  pInTradeName1    = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeName1.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeNameLayoutIn)		  pInTradeName2    = Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.TradeName2.logical,
	DATASET(Corp2_Raw_ND.Layouts.TradeNameLayoutBase)  	pBaseTradeName	 = IF(Corp2_Raw_ND._Flags.Base.TradeName, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.TradeName.qa, DATASET([], Corp2_Raw_ND.Layouts.TradeNameLayoutBase))
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_ND.Build_Bases_Corp(pfiledate,pversion,puseprod,pInCorp1,pInCorp2,pBaseCorp).ALL,
																		Corp2_Raw_ND.Build_Bases_FictName(pfiledate,pversion,puseprod,pInFictName1,pInFictName2,pBaseFictName).ALL,
																		Corp2_Raw_ND.Build_Bases_Partnership(pfiledate,pversion,puseprod,pInPartnership,pBasePartnership).ALL,
																		Corp2_Raw_ND.Build_Bases_TradeMark(pfiledate,pversion,puseprod,pInTradeMark1,pInTradeMark2,pBaseTradeMark).ALL,	
																		Corp2_Raw_ND.Build_Bases_TradeName(pfiledate,pversion,puseprod,pInTradeName1,pInTradeName2,pBaseTradeName).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																	);
											

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ND.Build_Bases attribute')
									 );

END;
