IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																									pfiledate,
	STRING																									pversion,
	Boolean 																								pUseOtherEnvironment,
	DATASET(Corp2_Raw_MO.Layouts.AddressLayoutIn)						pInAddress   		 		= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Address.Logical,
	DATASET(Corp2_Raw_MO.Layouts.AddressLayoutBase)					pBaseAddress 		 		= IF(Corp2_Raw_MO._Flags.Base.Address, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, DATASET([], Corp2_Raw_MO.Layouts.AddressLayoutBase)),
	DATASET(Corp2_Raw_MO.Layouts.mergerLayoutIn)						pInmerger   				= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.merger.Logical,
	DATASET(Corp2_Raw_MO.Layouts.mergerLayoutBase)			  	pBasemerger 				= IF(Corp2_Raw_MO._Flags.Base.merger, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.merger.qa, DATASET([], Corp2_Raw_MO.Layouts.mergerLayoutBase)),
	DATASET(Corp2_Raw_MO.Layouts.FilingLayoutIn)						pInFiling   				= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Filing.Logical,
	DATASET(Corp2_Raw_MO.Layouts.FilingLayoutBase)					pBaseFiling 				= IF(Corp2_Raw_MO._Flags.Base.Filing, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, DATASET([], Corp2_Raw_MO.Layouts.FilingLayoutBase)),
	DATASET(Corp2_Raw_MO.Layouts.CorporationLayoutIn)				pInCorporation   		= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input. Corporation.Logical,
  DATASET(Corp2_Raw_MO.Layouts.CorporationLayoutBase)			pBaseCorporation 		= IF(Corp2_Raw_MO._Flags.Base. Corporation, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base. Corporation.qa, DATASET([], Corp2_Raw_MO.Layouts.CorporationLayoutBase)),
	DATASET(Corp2_Raw_MO.Layouts.NamesLayoutIn)							pInName   			 		= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Names.Logical,
	DATASET(Corp2_Raw_MO.Layouts.NamesLayoutBase)						pBaseName			 			= IF(Corp2_Raw_MO._Flags.Base.Names, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Names.qa, DATASET([], Corp2_Raw_MO.Layouts.NamesLayoutBase)),
	DATASET(Corp2_Raw_MO.Layouts.officerLayoutIn)						pInofficer   				= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input. officer.Logical,
  DATASET(Corp2_Raw_MO.Layouts.officerLayoutBase)			 		pBaseofficer 				= IF(Corp2_Raw_MO._Flags.Base. officer, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base. officer.qa, DATASET([], Corp2_Raw_MO.Layouts.officerLayoutBase)),
	DATASET(Corp2_Raw_MO.Layouts.StockLayoutIn)				  		pInStock  					= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Stock.Logical,
	DATASET(Corp2_Raw_MO.Layouts.StockLayoutBase)	 					pBaseStock					= IF(Corp2_Raw_MO._Flags.Base.Stock, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_MO.Layouts.StockLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_MO.Build_Bases_Address(pfiledate,pversion,pUseOtherEnvironment,pInAddress,pBaseAddress).ALL,
																		Corp2_Raw_MO.Build_Bases_merger(pfiledate,pversion,pUseOtherEnvironment,pInmerger,pBasemerger).ALL,
																		Corp2_Raw_MO.Build_Bases_Filing(pfiledate,pversion,pUseOtherEnvironment,pInFiling,pBaseFiling).ALL,
																		Corp2_Raw_MO.Build_Bases_Corporation(pfiledate,pversion,pUseOtherEnvironment,pInCorporation,pBaseCorporation).ALL,
																		Corp2_Raw_MO.Build_Bases_Name(pfiledate,pversion,pUseOtherEnvironment,pInName,pBaseName).ALL,
																		Corp2_Raw_MO.Build_Bases_officer(pfiledate,pversion,pUseOtherEnvironment,pInofficer,pBaseofficer).ALL,
																		Corp2_Raw_MO.Build_Bases_Stock(pfiledate,pversion,pUseOtherEnvironment,pInStock,pBaseStock).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MO.Build_Bases attribute')
									 );

END;
