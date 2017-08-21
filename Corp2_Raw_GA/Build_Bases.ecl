IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN                                             pUseProd,
	DATASET(Corp2_Raw_GA.Layouts.AddressLayoutIn)				pInAddress   		      = Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Address,
	DATASET(Corp2_Raw_GA.Layouts.AddressLayoutBase)			pBaseAddress 		      = IF(Corp2_Raw_GA._Flags.Base.Address, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, DATASET([], Corp2_Raw_GA.Layouts.AddressLayoutBase)),
	DATASET(Corp2_Raw_GA.Layouts.CorporationLayoutIn)		pInCorporation   			= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Corporation.logical,
	DATASET(Corp2_Raw_GA.Layouts.CorporationLayoutBase)	pBaseCorporation 			= IF(Corp2_Raw_GA._Flags.Base.Corporation, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Corporation.qa, DATASET([], Corp2_Raw_GA.Layouts.CorporationLayoutBase)),
	DATASET(Corp2_Raw_GA.Layouts.FilingLayoutIn)				pInFiling   	   		  = Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Filing.logical,
	DATASET(Corp2_Raw_GA.Layouts.FilingLayoutBase)			pBaseFiling 	   			= IF(Corp2_Raw_GA._Flags.Base.Filing, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, DATASET([], Corp2_Raw_GA.Layouts.FilingLayoutBase)),
	DATASET(Corp2_Raw_GA.Layouts.OfficerLayoutIn)				pInOfficer   	   			= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Officer.logical,
	DATASET(Corp2_Raw_GA.Layouts.OfficerLayoutBase)			pBaseOfficer 	 	 			= IF(Corp2_Raw_GA._Flags.Base.Officer, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, DATASET([], Corp2_Raw_GA.Layouts.OfficerLayoutBase)),
	DATASET(Corp2_Raw_GA.Layouts.RAgentLayoutIn)				pInRAgent  			 			= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.RAgent.logical,
	DATASET(Corp2_Raw_GA.Layouts.RAgentLayoutBase)			pBaseRAgent			 			= IF(Corp2_Raw_GA._Flags.Base.RAgent, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.RAgent.qa, DATASET([], Corp2_Raw_GA.Layouts.RAgentLayoutBase)),
	DATASET(Corp2_Raw_GA.Layouts.StockLayoutIn)					pInStock   			 			= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Stock.logical,
	DATASET(Corp2_Raw_GA.Layouts.StockLayoutBase)				pBaseStock			 			= IF(Corp2_Raw_GA._Flags.Base.Stock, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_GA.Layouts.StockLayoutBase))
	
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_GA.Build_Bases_Address(pfiledate,pversion,pUseProd,pInAddress,pBaseAddress).ALL,
																		Corp2_Raw_GA.Build_Bases_Corporation(pfiledate,pversion,pUseProd,pInCorporation,pBaseCorporation).ALL,
																		Corp2_Raw_GA.Build_Bases_Filing(pfiledate,pversion,pUseProd,pInFiling,pBaseFiling).ALL,
																		Corp2_Raw_GA.Build_Bases_Officer(pfiledate,pversion,pUseProd,pInOfficer,pBaseOfficer).ALL,
																		Corp2_Raw_GA.Build_Bases_Stock(pfiledate,pversion,pUseProd,pInStock,pBaseStock).ALL,
																		Corp2_Raw_GA.Build_Bases_RAgent(pfiledate,pversion,pUseProd,pInRAgent,pBaseRAgent).ALL,
																		Promote(pversion).buildfiles.New2Built,
																	  Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_GA.Build_Bases attribute')
									 );

END;
