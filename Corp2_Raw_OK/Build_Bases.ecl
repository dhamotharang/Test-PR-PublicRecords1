IMPORT tools, ut;

EXPORT Build_Bases(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	
	DATASET(Corp2_Raw_OK.Layouts.Entity_01_Layout)		    pInf01_Entity 	 = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f01_Entity,
	DATASET(Corp2_Raw_OK.Layouts.Entity_01_LayoutBase)	  pBasef01_Entity = IF(Corp2_Raw_OK._Flags.Base.f01_Entity, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f01_Entity.qa, DATASET([], Corp2_Raw_OK.Layouts.Entity_01_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.Address_02_Layout)		    pInf02_Address   = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f02_Address,
	DATASET(Corp2_Raw_OK.Layouts.Address_02_LayoutBase)	  pBasef02_Address = IF(Corp2_Raw_OK._Flags.Base.f02_Address, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f02_Address.qa, DATASET([], Corp2_Raw_OK.Layouts.Address_02_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.Agent_03_Layout)		      pInf03_Agent   = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f03_Agent,
	DATASET(Corp2_Raw_OK.Layouts.Agent_03_LayoutBase)	    pBasef03_Agent = IF(Corp2_Raw_OK._Flags.Base.f03_Agent, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f03_Agent.qa, DATASET([], Corp2_Raw_OK.Layouts.Agent_03_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.Officer_04_Layout)		    pInf04_Officer    = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f04_Officer,
	DATASET(Corp2_Raw_OK.Layouts.Officer_04_LayoutBase)	  pBasef04_Officer	 = IF(Corp2_Raw_OK._Flags.Base.f04_Officer, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f04_Officer.qa, DATASET([], Corp2_Raw_OK.Layouts.Officer_04_LayoutBase)),
  
	DATASET(Corp2_Raw_OK.Layouts.Names_05_Layout)	        pInf05_Names  = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f05_Names,
	DATASET(Corp2_Raw_OK.Layouts.Names_05_LayoutBase)     pBasef05_Names= IF(Corp2_Raw_OK._Flags.Base.f05_Names, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f05_Names.qa, DATASET([], Corp2_Raw_OK.Layouts.Names_05_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.AssocEnt_06_Layout)	    pInf06_AssocEnt       = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f06_AssocEnt,
	DATASET(Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase)  pBasef06_AssocEnt	   = IF(Corp2_Raw_OK._Flags.Base.f06_AssocEnt, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f06_AssocEnt.qa, DATASET([], Corp2_Raw_OK.Layouts.AssocEnt_06_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.StockData_07_Layout)	    pInf07_StockData    = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f07_StockData,
	DATASET(Corp2_Raw_OK.Layouts.StockData_07_LayoutBase) pBasef07_StockData	 = IF(Corp2_Raw_OK._Flags.Base.f07_StockData, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f07_StockData.qa, DATASET([], Corp2_Raw_OK.Layouts.StockData_07_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.StockInfo_08_Layout)	    pInf08_StockInfo    = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f08_StockInfo,
	DATASET(Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase) pBasef08_StockInfo	 = IF(Corp2_Raw_OK._Flags.Base.f08_StockInfo, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f08_StockInfo.qa, DATASET([], Corp2_Raw_OK.Layouts.StockInfo_08_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.CorpType_12_Layout)	    pInf12_CorpType    = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f12_CorpType,
	DATASET(Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase)  pBasef12_CorpType	 = IF(Corp2_Raw_OK._Flags.Base.f12_CorpType, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f12_CorpType.qa, DATASET([], Corp2_Raw_OK.Layouts.CorpType_12_LayoutBase)),
	
	DATASET(Corp2_Raw_OK.Layouts.CorpFiling_17_Layout)	  pInf17_CorpFiling    = Corp2_Raw_OK.Files(pfiledate,puseprod).Input.f17_CorpFiling,
	DATASET(Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase)pBasef17_CorpFiling	 = IF(Corp2_Raw_OK._Flags.Base.f17_CorpFiling, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f17_CorpFiling.qa, DATASET([], Corp2_Raw_OK.Layouts.CorpFiling_17_LayoutBase))
			
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_OK.Build_Bases_f01_Entity    (pfiledate,pversion,puseprod,pInf01_Entity,    pBasef01_Entity).ALL,
																		Corp2_Raw_OK.Build_Bases_f02_Address   (pfiledate,pversion,puseprod,pInf02_Address,   pBasef02_Address).ALL,
																		Corp2_Raw_OK.Build_Bases_f03_Agent     (pfiledate,pversion,puseprod,pInf03_Agent,     pBasef03_Agent).ALL,
																		Corp2_Raw_OK.Build_Bases_f04_Officer   (pfiledate,pversion,puseprod,pInf04_Officer,   pBasef04_Officer).ALL,
																		Corp2_Raw_OK.Build_Bases_f05_Names     (pfiledate,pversion,puseprod,pInf05_Names,     pBasef05_Names).ALL,
																		Corp2_Raw_OK.Build_Bases_f06_AssocEnt  (pfiledate,pversion,puseprod,pInf06_AssocEnt,  pBasef06_AssocEnt).ALL,
																		Corp2_Raw_OK.Build_Bases_f07_StockData (pfiledate,pversion,puseprod,pInf07_StockData, pBasef07_StockData).ALL,	
																		Corp2_Raw_OK.Build_Bases_f08_StockInfo (pfiledate,pversion,puseprod,pInf08_StockInfo, pBasef08_StockInfo).ALL,
																		Corp2_Raw_OK.Build_Bases_f12_CorpType  (pfiledate,pversion,puseprod,pInf12_CorpType,  pBasef12_CorpType).ALL,
																		Corp2_Raw_OK.Build_Bases_f17_CorpFiling(pfiledate,pversion,puseprod,pInf17_CorpFiling,pBasef17_CorpFiling).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA	
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases attribute')
									 );

END;