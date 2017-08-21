IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																								pfiledate,
	STRING																								pversion,
  BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_PA.Layouts.CorpNameLayoutIn)				pInCorpName   		= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.CorpNamePipeDelim,
	DATASET(Corp2_Raw_PA.Layouts.CorpNameLayoutBase)			pBaseCorpName 		= IF(Corp2_Raw_PA._Flags.Base.CorpName, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.CorpName.qa, DATASET([], Corp2_Raw_PA.Layouts.CorpNameLayoutBase)),
	DATASET(Corp2_Raw_PA.Layouts.AddressLayoutIn)					pInAddress   			= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Address.logical,
	DATASET(Corp2_Raw_PA.Layouts.AddressLayoutBase)				pBaseAddress 			= IF(Corp2_Raw_PA._Flags.Base.Address, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, DATASET([], Corp2_Raw_PA.Layouts.AddressLayoutBase)),
	DATASET(Corp2_Raw_PA.Layouts.OfficerLayoutIn)					pInOfficer   	 		= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Officer.logical,
	DATASET(Corp2_Raw_PA.Layouts.OfficerLayoutBase)				pBaseOfficer 	 		= IF(Corp2_Raw_PA._Flags.Base.Officer, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, DATASET([], Corp2_Raw_PA.Layouts.OfficerLayoutBase)),
	DATASET(Corp2_Raw_PA.Layouts.CorporationsLayoutIn)		pInCorporations   = Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.CorporationsPipeDelim,
	DATASET(Corp2_Raw_PA.Layouts.CorporationsLayoutBase)	pBaseCorporations	= IF(Corp2_Raw_PA._Flags.Base.Corporations, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Corporations.qa, DATASET([], Corp2_Raw_PA.Layouts.CorporationsLayoutBase)),
  DATASET(Corp2_Raw_PA.Layouts.FilingLayoutIn)					pInFiling   			= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Filing.logical,
	DATASET(Corp2_Raw_PA.Layouts.FilingLayoutBase)				pBaseFiling			 	= IF(Corp2_Raw_PA._Flags.Base.Filing, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, DATASET([], Corp2_Raw_PA.Layouts.FilingLayoutBase)),
	DATASET(Corp2_Raw_PA.Layouts.MergerLayoutIn)					pInMerger   			= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Merger.logical,
	DATASET(Corp2_Raw_PA.Layouts.MergerLayoutBase)				pBaseMerger			 	= IF(Corp2_Raw_PA._Flags.Base.Merger, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa, DATASET([], Corp2_Raw_PA.Layouts.MergerLayoutBase))
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_PA.Build_Bases_CorpName(pfiledate,pversion,pUseProd,pInCorpName,pBaseCorpName).ALL,
																		Corp2_Raw_PA.Build_Bases_Address(pfiledate,pversion,pUseProd,pInAddress,pBaseAddress).ALL,
																		Corp2_Raw_PA.Build_Bases_Officer(pfiledate,pversion,pUseProd,pInOfficer,pBaseOfficer).ALL,
																		Corp2_Raw_PA.Build_Bases_Corporations(pfiledate,pversion,pUseProd,pInCorporations,pBaseCorporations).ALL,
																		Corp2_Raw_PA.Build_Bases_Filing(pfiledate,pversion,pUseProd,pInFiling,pBaseFiling).ALL,
																		Corp2_Raw_PA.Build_Bases_Merger(pfiledate,pversion,pUseProd,pInMerger,pBaseMerger).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																 
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases attribute')
									 );

END;
