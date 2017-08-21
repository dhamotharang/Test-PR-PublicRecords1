IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																												pfiledate,
	STRING																												pversion,
	BOOLEAN																												puseprod,
	DATASET(Corp2_Raw_HI.Layouts.CompanyMasterLayoutIn)						pInCompanyMaster   				= Corp2_Raw_HI.Files(pfiledate,puseprod).Input.CompanyMaster.logical,
	DATASET(Corp2_Raw_HI.Layouts.CompanyMasterLayoutBase)					pBaseCompanyMaster 		 		= IF(Corp2_Raw_HI._Flags.Base.CompanyMaster, Corp2_Raw_HI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.CompanyMaster.qa, DATASET([], Corp2_Raw_HI.Layouts.CompanyMasterLayoutBase)),
	DATASET(Corp2_Raw_HI.Layouts.CompanyOfficerLayoutIn)					pInCompanyOfficer   			= Corp2_Raw_HI.Files(pfiledate,puseprod).Input.CompanyOfficer.logical,
	DATASET(Corp2_Raw_HI.Layouts.CompanyOfficerLayoutBase)				pBaseCompanyOfficer 			= IF(Corp2_Raw_HI._Flags.Base.CompanyOfficer, Corp2_Raw_HI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.CompanyOfficer.qa, DATASET([], Corp2_Raw_HI.Layouts.CompanyOfficerLayoutBase)),
	DATASET(Corp2_Raw_HI.Layouts.CompanyStockLayoutIn)						pInCompanyStock   				= Corp2_Raw_HI.Files(pfiledate,puseprod).Input.CompanyStock.logical,
	DATASET(Corp2_Raw_HI.Layouts.CompanyStockLayoutBase)					pBaseCompanyStock 				= IF(Corp2_Raw_HI._Flags.Base.CompanyStock, Corp2_Raw_HI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.CompanyStock.qa, DATASET([], Corp2_Raw_HI.Layouts.CompanyStockLayoutBase)),
	DATASET(Corp2_Raw_HI.Layouts.CompanyTransactionLayoutIn)			pInCompanyTransaction   	= Corp2_Raw_HI.Files(pfiledate,puseprod).Input.CompanyTransaction.logical,
	DATASET(Corp2_Raw_HI.Layouts.CompanyTransactionLayoutBase)		pBaseCompanyTransaction	 	= IF(Corp2_Raw_HI._Flags.Base.CompanyTransaction, Corp2_Raw_HI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.CompanyTransaction.qa, DATASET([], Corp2_Raw_HI.Layouts.CompanyTransactionLayoutBase)),
	DATASET(Corp2_Raw_HI.Layouts.TTSMasterLayoutIn)								pInTTSMaster 	 						= Corp2_Raw_HI.Files(pfiledate,puseprod).Input.TTSMaster.logical,
	DATASET(Corp2_Raw_HI.Layouts.TTSMasterLayoutBase)							pBaseTTSMaster						= IF(Corp2_Raw_HI._Flags.Base.TTSMaster, Corp2_Raw_HI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.TTSMaster.qa, DATASET([], Corp2_Raw_HI.Layouts.TTSMasterLayoutBase)),
	DATASET(Corp2_Raw_HI.Layouts.TTSTransactionLayoutIn)					pInTTSTransaction   			= Corp2_Raw_HI.Files(pfiledate,puseprod).Input.TTSTransaction.logical,
	DATASET(Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase)				pBaseTTSTransaction				= IF(Corp2_Raw_HI._Flags.Base.TTSTransaction, Corp2_Raw_HI.Files(pfiledate,pUseOtherEnvironment := FALSE).Base.TTSTransaction.qa, DATASET([], Corp2_Raw_HI.Layouts.TTSTransactionLayoutBase))

) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_HI.Build_Bases_CompanyMaster(pfiledate,pversion,puseprod,pInCompanyMaster,pBaseCompanyMaster).ALL,
																		Corp2_Raw_HI.Build_Bases_CompanyOfficer(pfiledate,pversion,puseprod,pInCompanyOfficer,pBaseCompanyOfficer).ALL,
																		Corp2_Raw_HI.Build_Bases_CompanyStock(pfiledate,pversion,puseprod,pInCompanyStock,pBaseCompanyStock).ALL,
																		Corp2_Raw_HI.Build_Bases_CompanyTransaction(pfiledate,pversion,puseprod,pInCompanyTransaction,pBaseCompanyTransaction).ALL,
																		Corp2_Raw_HI.Build_Bases_TTSMaster(pfiledate,pversion,puseprod,pInTTSMaster,pBaseTTSMaster).ALL,
																		Corp2_Raw_HI.Build_Bases_TTSTransaction(pfiledate,pversion,puseprod,pInTTSTransaction,pBaseTTSTransaction).ALL,
																		Promote(pversion,puseprod).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_HI.Build_Bases attribute')
									);

END;