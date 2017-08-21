IMPORT tools;

EXPORT Build_Bases(
	STRING																												pfiledate,
	STRING																												pversion,
	BOOLEAN																												puseprod,
	DATASET(Corp2_Raw_MA.Layouts.CorpDataExportLayoutIn)					pInCorpDataExport   			= Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpDataExport.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpDataExportLayoutBase)				pBaseCorpDataExport 	 		= IF(Corp2_Raw_MA._Flags.Base.CorpDataExport, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpDataExport.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpDataExportLayoutBase)),
	DATASET(Corp2_Raw_MA.Layouts.CorpIndividualExportLayoutIn)		pInCorpIndividualExport  	= Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpIndividualExport.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpIndividualExportLayoutBase)	pBaseCorpIndividualExport	= IF(Corp2_Raw_MA._Flags.Base.CorpIndividualExport, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpIndividualExport.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpIndividualExportLayoutBase)),
	DATASET(Corp2_Raw_MA.Layouts.CorpNameChangeLayoutIn)					pInCorpNameChange   	 		= Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpNameChange.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase)				pBaseCorpNameChange 	 		= IF(Corp2_Raw_MA._Flags.Base.CorpNameChange, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpNameChange.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpNameChangeLayoutBase)),
	DATASET(Corp2_Raw_MA.Layouts.CorpMergerLayoutIn)							pInCorpMerger   					= Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpMerger.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpMergerLayoutBase)						pBaseCorpMerger 	 				= IF(Corp2_Raw_MA._Flags.Base.CorpMerger, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpMerger.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpMergerLayoutBase)),
	DATASET(Corp2_Raw_MA.Layouts.CorpDetailExportLayoutIn)				pInCorpDetailExport  			= Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpDetailExport.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpDetailExportLayoutBase)			pBaseCorpDetailExport			= IF(Corp2_Raw_MA._Flags.Base.CorpDetailExport, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpDetailExport.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpDetailExportLayoutBase)),
	DATASET(Corp2_Raw_MA.Layouts.CorpStockExportLayoutIn)					pInCorpStockExport   	 		= Corp2_Raw_MA.Files(pfiledate,pUseProd).Input.CorpStockExport.Logical,
	DATASET(Corp2_Raw_MA.Layouts.CorpStockExportLayoutBase)				pBaseCorpStockExport 	 		= IF(Corp2_Raw_MA._Flags.Base.CorpStockExport, Corp2_Raw_MA.Files(,pUseOtherEnvironment := FALSE).Base.CorpStockExport.qa, DATASET([], Corp2_Raw_MA.Layouts.CorpStockExportLayoutBase))
	
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_MA.Build_Bases_CorpDataExport(pfiledate,pversion,puseprod,pInCorpDataExport,pBaseCorpDataExport).ALL,
																		Corp2_Raw_MA.Build_Bases_CorpDetailExport(pfiledate,pversion,puseprod,pInCorpDetailExport,pBaseCorpDetailExport).ALL,
																		Corp2_Raw_MA.Build_Bases_CorpIndividualExport(pfiledate,pversion,puseprod,pInCorpIndividualExport,pBaseCorpIndividualExport).ALL,
																		Corp2_Raw_MA.Build_Bases_CorpMerger(pfiledate,pversion,puseprod,pInCorpMerger,pBaseCorpMerger).ALL,
																		Corp2_Raw_MA.Build_Bases_CorpNameChange(pfiledate,pversion,puseprod,pInCorpNameChange,pBaseCorpNameChange).ALL,
																		Corp2_Raw_MA.Build_Bases_CorpStockExport(pfiledate,pversion,puseprod,pInCorpStockExport,pBaseCorpStockExport).ALL,
																		Corp2_Raw_MA.Promote(pversion).buildfiles.New2Built,
																		Corp2_Raw_MA.Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MA.Build_Bases attribute')
									 );

END;
