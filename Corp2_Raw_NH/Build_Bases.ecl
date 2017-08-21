IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																												pfiledate,
	STRING																												pversion,
	BOOLEAN																												puseprod,	
	DATASET(Corp2_Raw_NH.Layouts.CorporationLayoutIn)							pInCorporation   			= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Corporation.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.CorporationLayoutBase)						pBaseCorporation 		 	= IF(Corp2_Raw_NH._Flags.Base.Corporation, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Corporation.qa, DATASET([], Corp2_Raw_NH.Layouts.CorporationLayoutBase)),
	DATASET(Corp2_Raw_NH.Layouts.AddressLayoutIn)									pInAddress   					= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Address.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.AddressLayoutBase)								pBaseAddress 					= IF(Corp2_Raw_NH._Flags.Base.Address, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, DATASET([], Corp2_Raw_NH.Layouts.AddressLayoutBase)),
	DATASET(Corp2_Raw_NH.Layouts.FilingLayoutIn)									pInFiling   					= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Filing.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.FilingLayoutBase)								pBaseFiling 					= IF(Corp2_Raw_NH._Flags.Base.Filing, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, DATASET([], Corp2_Raw_NH.Layouts.FilingLayoutBase)),
	DATASET(Corp2_Raw_NH.Layouts.MergerLayoutIn)									pInMerger   					= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Merger.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.MergerLayoutBase)								pBaseMerger	 					= IF(Corp2_Raw_NH._Flags.Base.Merger, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa, DATASET([], Corp2_Raw_NH.Layouts.MergerLayoutBase)),
	DATASET(Corp2_Raw_NH.Layouts.CorporationNameLayoutIn)					pInCorporationName 	 	= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.CorporationName.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.CorporationNameLayoutBase)				pBaseCorporationName	= IF(Corp2_Raw_NH._Flags.Base.CorporationName, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.CorporationName.qa, DATASET([], Corp2_Raw_NH.Layouts.CorporationNameLayoutBase)),
	DATASET(Corp2_Raw_NH.Layouts.OfficerLayoutIn)									pInOfficer   			 		= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Officer.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.OfficerLayoutBase)								pBaseOfficer					= IF(Corp2_Raw_NH._Flags.Base.Officer, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, DATASET([], Corp2_Raw_NH.Layouts.OfficerLayoutBase)),
	DATASET(Corp2_Raw_NH.Layouts.StockLayoutIn)										pInStock   			 			= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Stock.Sprayed,
	DATASET(Corp2_Raw_NH.Layouts.StockLayoutBase)									pBaseStock						= IF(Corp2_Raw_NH._Flags.Base.Stock, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_NH.Layouts.StockLayoutBase))

) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_NH.Build_Bases_Corporation(pfiledate,pversion,puseprod,pInCorporation,pBaseCorporation).ALL,
																		Corp2_Raw_NH.Build_Bases_Address(pfiledate,pversion,puseprod,pInAddress,pBaseAddress).ALL,
																		Corp2_Raw_NH.Build_Bases_Filing(pfiledate,pversion,puseprod,pInFiling,pBaseFiling).ALL,
																		Corp2_Raw_NH.Build_Bases_Merger(pfiledate,pversion,puseprod,pInMerger,pBaseMerger).ALL,
																		Corp2_Raw_NH.Build_Bases_CorporationName(pfiledate,pversion,puseprod,pInCorporationName,pBaseCorporationName).ALL,
																		Corp2_Raw_NH.Build_Bases_Officer(pfiledate,pversion,puseprod,pInOfficer,pBaseOfficer).ALL,
																		Corp2_Raw_NH.Build_Bases_Stock(pfiledate,pversion,puseprod,pInStock,pBaseStock).ALL,
																		Promote(pversion).buildfiles.New2Built,	
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NH.Build_Bases attribute')
									 );

END;