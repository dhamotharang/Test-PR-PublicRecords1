IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NV.Layouts.ActionsLayoutIn)					pInActions   		 = Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Actions.Logical,
	DATASET(Corp2_Raw_NV.Layouts.ActionsLayoutBase)				pBaseActions 		 = IF(Corp2_Raw_NV._Flags.Base.Actions, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Actions.qa, DATASET([], Corp2_Raw_NV.Layouts.ActionsLayoutBase)),
	DATASET(Corp2_Raw_NV.Layouts.CorporationsLayoutIn)		pInCorporation   = Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Corporation.Logical,
	DATASET(Corp2_Raw_NV.Layouts.CorporationsLayoutBase)	pBaseCorporation = IF(Corp2_Raw_NV._Flags.Base.Corporation, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Corporation.qa, DATASET([], Corp2_Raw_NV.Layouts.CorporationsLayoutBase)),
	DATASET(Corp2_Raw_NV.Layouts.OfficersLayoutIn)				pInOfficers   	 = Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Officers.Logical,
	DATASET(Corp2_Raw_NV.Layouts.OfficersLayoutBase)			pBaseOfficers 	 = IF(Corp2_Raw_NV._Flags.Base.Officers, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Officers.qa, DATASET([], Corp2_Raw_NV.Layouts.OfficersLayoutBase)),
	DATASET(Corp2_Raw_NV.Layouts.RALayoutIn)							pInRA   				 = Corp2_Raw_NV.Files(pfiledate,puseprod).Input.RA.Logical,
	DATASET(Corp2_Raw_NV.Layouts.RALayoutBase)						pBaseRA 				 = IF(Corp2_Raw_NV._Flags.Base.RA, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.RA.qa, DATASET([], Corp2_Raw_NV.Layouts.RALayoutBase)),
	DATASET(Corp2_Raw_NV.Layouts.StockLayoutIn)						pInStock   			 = Corp2_Raw_NV.Files(pfiledate,puseprod).Input.Stock.Logical,
	DATASET(Corp2_Raw_NV.Layouts.StockLayoutBase)					pBaseStock			 = IF(Corp2_Raw_NV._Flags.Base.Stock, Corp2_Raw_NV.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa, DATASET([], Corp2_Raw_NV.Layouts.StockLayoutBase))
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_NV.Build_Bases_Actions(pfiledate,pversion,puseprod,pInActions,pBaseActions).ALL,
																		Corp2_Raw_NV.Build_Bases_Corporations(pfiledate,pversion,puseprod,pInCorporation,pBaseCorporation).ALL,
																		Corp2_Raw_NV.Build_Bases_Officers(pfiledate,pversion,puseprod,pInOfficers,pBaseOfficers).ALL,
																		Corp2_Raw_NV.Build_Bases_RA(pfiledate,pversion,puseprod,pInRA,pBaseRA).ALL,
																		Corp2_Raw_NV.Build_Bases_Stock(pfiledate,pversion,puseprod,pInStock,pBaseStock).ALL,
																		Promote(pversion).BuildFiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );
																		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NV.Build_Bases attribute')
									 );

END;
