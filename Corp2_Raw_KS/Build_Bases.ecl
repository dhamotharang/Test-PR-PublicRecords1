IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_KS.Layouts.CPABREPLayoutIn)					pInCPABREP   		 	= Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPABREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPABREPLayoutBase)				pBaseCPABREP 		 	= IF(Corp2_Raw_KS._Flags.Base.CPABREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPABREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPABREPLayoutBase)),
	DATASET(Corp2_Raw_KS.Layouts.CPADREPLayoutIn)					pInCPADREP   			= Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPADREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPADREPLayoutBase)				pBaseCPADREP 			= IF(Corp2_Raw_KS._Flags.Base.CPADREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPADREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPADREPLayoutBase)),
	DATASET(Corp2_Raw_KS.Layouts.CPAEREPLayoutIn)					pInCPAEREP   			= Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPAEREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPAEREPLayoutBase)				pBaseCPAEREP 			= IF(Corp2_Raw_KS._Flags.Base.CPAEREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPAEREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPAEREPLayoutBase)),
	DATASET(Corp2_Raw_KS.Layouts.CPAHSTLayoutIn)					pInCPAHST   	 		= Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPAHST.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPAHSTLayoutBase)				pBaseCPAHST 	 		= IF(Corp2_Raw_KS._Flags.Base.CPAHST, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPAHST.qa, DATASET([], Corp2_Raw_KS.Layouts.CPAHSTLayoutBase)),
	DATASET(Corp2_Raw_KS.Layouts.CPAQREPLayoutIn)					pInCPAQREP   		 	= Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPAQREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPAQREPLayoutBase)				pBaseCPAQREP 		 	= IF(Corp2_Raw_KS._Flags.Base.CPAQREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPAQREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPAQREPLayoutBase)),
	DATASET(Corp2_Raw_KS.Layouts.CPBCREPLayoutIn)					pInCPBCREP   			= Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPBCREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPBCREPLayoutBase)				pBaseCPBCREP			= IF(Corp2_Raw_KS._Flags.Base.CPBCREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPBCREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPBCREPLayoutBase))
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_KS.Build_Bases_CPABREP(pfiledate,pversion,puseprod,pInCPABREP,pBaseCPABREP).ALL,
																		Corp2_Raw_KS.Build_Bases_CPADREP(pfiledate,pversion,puseprod,pInCPADREP,pBaseCPADREP).ALL,
																		Corp2_Raw_KS.Build_Bases_CPAEREP(pfiledate,pversion,puseprod,pInCPAEREP,pBaseCPAEREP).ALL,																		
																		Corp2_Raw_KS.Build_Bases_CPAHST(pfiledate,pversion,puseprod,pInCPAHST,pBaseCPAHST).ALL,
																		Corp2_Raw_KS.Build_Bases_CPAQREP(pfiledate,pversion,puseprod,pInCPAQREP,pBaseCPAQREP).ALL,
																		Corp2_Raw_KS.Build_Bases_CPBCREP(pfiledate,pversion,puseprod,pInCPBCREP,pBaseCPBCREP).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_KS.Build_Bases attribute')
									 );

END;
