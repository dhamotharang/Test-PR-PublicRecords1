IMPORT tools, ut, corp2, Corp2_Raw_NY;

EXPORT Build_Bases(	
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod
	,BOOLEAN pquarterlyReload

	,DATASET(Corp2_Raw_NY.Layouts.MasterLayout)		    pInMasterFile     = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.MasterFile
	,DATASET(Corp2_Raw_NY.Layouts.MasterLayoutBase)	  pBaseMasterFile   = IF(_Flags.Base.Master ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Master.qa ,DATASET([],Corp2_Raw_NY.Layouts.MasterLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.ProcAddrLayout)		  pInProcAddrFile   = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.ProcAddrFile
	,DATASET(Corp2_Raw_NY.Layouts.ProcAddrLayoutBase)	pBaseProcAddrFile = IF(_Flags.Base.ProcAddr ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.ProcAddr.qa ,DATASET([],Corp2_Raw_NY.Layouts.ProcAddrLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.RegAgentLayout)		  pInRegAgentFile   = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.RegAgentFile
	,DATASET(Corp2_Raw_NY.Layouts.RegAgentLayoutBase)	pBaseRegAgentFile = IF(_Flags.Base.RegAgent ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.RegAgent.qa ,DATASET([],Corp2_Raw_NY.Layouts.RegAgentLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.FictNameLayout)		  pInFictNameFile   = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.FictNameFile
	,DATASET(Corp2_Raw_NY.Layouts.FictNameLayoutBase)	pBaseFictNameFile = IF(_Flags.Base.FictName ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.FictName.qa ,DATASET([],Corp2_Raw_NY.Layouts.FictNameLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.StockLayout)		    pInStockFile      = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.StockFile
	,DATASET(Corp2_Raw_NY.Layouts.StockLayoutBase)	  pBaseStockFile    = IF(_Flags.Base.Stock ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Stock.qa ,DATASET([],Corp2_Raw_NY.Layouts.StockLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.ChairmanLayout)		  pInChairmanFile   = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.ChairmanFile
	,DATASET(Corp2_Raw_NY.Layouts.ChairmanLayoutBase)	pBaseChairmanFile = IF(_Flags.Base.Chairman ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Chairman.qa ,DATASET([],Corp2_Raw_NY.Layouts.ChairmanLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.ExecOffLayout)		  pInExecOffFile    = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.ExecOffFile
	,DATASET(Corp2_Raw_NY.Layouts.ExecOffLayoutBase)	pBaseExecOffFile  = IF(_Flags.Base.ExecOff ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.ExecOff.qa ,DATASET([],Corp2_Raw_NY.Layouts.ExecOffLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.OrigPartLayout)		  pInOrigPartFile   = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.OrigPartFile
	,DATASET(Corp2_Raw_NY.Layouts.OrigPartLayoutBase)	pBaseOrigPartFile = IF(_Flags.Base.OrigPart ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.OrigPart.qa ,DATASET([],Corp2_Raw_NY.Layouts.OrigPartLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.CurrPartLayout)		  pInCurrPartFile   = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.CurrPartFile
	,DATASET(Corp2_Raw_NY.Layouts.CurrPartLayoutBase)	pBaseCurrPartFile = IF(_Flags.Base.CurrPart ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.CurrPart.qa ,DATASET([],Corp2_Raw_NY.Layouts.CurrPartLayoutBase))
	
	,DATASET(Corp2_Raw_NY.Layouts.MergerLayoutIn)		  pInMergerFile     = Corp2_Raw_NY.Files(pfiledate,puseprod,pquarterlyReload).Input.MergerUnload
	,DATASET(Corp2_Raw_NY.Layouts.MergerLayoutBase)	  pBaseMergerFile   = IF(_Flags.Base.Merger ,Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Merger.qa ,DATASET([],Corp2_Raw_NY.Layouts.MergerLayoutBase))																																					
	
	   ) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_NY.Build_Bases_Master  (pfiledate,pversion,puseprod, pInMasterFile,   pBaseMasterFile).ALL,
																		Corp2_Raw_NY.Build_Bases_ProcAddr(pfiledate,pversion,puseprod, pInProcAddrFile, pBaseProcAddrFile).ALL,
																		Corp2_Raw_NY.Build_Bases_RegAgent(pfiledate,pversion,puseprod, pInRegAgentFile, pBaseRegAgentFile).ALL,
																		Corp2_Raw_NY.Build_Bases_FictName(pfiledate,pversion,puseprod, pInFictNameFile, pBaseFictNameFile).ALL,
																		Corp2_Raw_NY.Build_Bases_Stock   (pfiledate,pversion,puseprod, pInStockFile,    pBaseStockFile).ALL,
																		Corp2_Raw_NY.Build_Bases_Chairman(pfiledate,pversion,puseprod, pInChairmanFile, pBaseChairmanFile).ALL,
																		Corp2_Raw_NY.Build_Bases_ExecOff (pfiledate,pversion,puseprod, pInExecOffFile,  pBaseExecOffFile).ALL,
																		Corp2_Raw_NY.Build_Bases_OrigPart(pfiledate,pversion,puseprod, pInOrigPartFile, pBaseOrigPartFile).ALL,
																		Corp2_Raw_NY.Build_Bases_CurrPart(pfiledate,pversion,puseprod, pInCurrPartFile, pBaseCurrPartFile).ALL,
																		Corp2_Raw_NY.Build_Bases_Merger  (pfiledate,pversion,puseprod, pInMergerFile,   pBaseMergerFile).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases attribute')
									 );

END;