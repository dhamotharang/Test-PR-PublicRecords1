IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																							pfiledate,
	STRING																							pversion,
	Boolean 																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_AR.Layouts.CorpDataLayoutIn)			pInCorpData      = Corp2_Raw_AR.Files(pfiledate,pUseOtherEnvironment).Input.CorpData.logical,
	DATASET(Corp2_Raw_AR.Layouts.CorpDataLayoutBase)		pBaseCorpData  	 = IF(Corp2_Raw_AR._Flags.Base.CorpData , Corp2_Raw_AR.Files(,pUseOtherEnvironment := FALSE).Base.CorpData .qa, DATASET([], Corp2_Raw_AR.Layouts.CorpDataLayoutBase)),
	DATASET(Corp2_Raw_AR.Layouts.CorpNamesLayoutIn)			pInCorpNames   	 = Corp2_Raw_AR.Files(pfiledate,pUseOtherEnvironment).Input.CorpNames.logical,
	DATASET(Corp2_Raw_AR.Layouts.CorpNamesLayoutBase)		pBaseCorpNames 	 = IF(Corp2_Raw_AR._Flags.Base.CorpNames, Corp2_Raw_AR.Files(,pUseOtherEnvironment := FALSE).Base.CorpNames.qa, DATASET([], Corp2_Raw_AR.Layouts.CorpNamesLayoutBase)),
	DATASET(Corp2_Raw_AR.Layouts.CorpOfficerLayoutIn)		pInCorpOfficer   = Corp2_Raw_AR.Files(pfiledate,pUseOtherEnvironment).Input.CorpOfficer.logical,
	DATASET(Corp2_Raw_AR.Layouts.CorpOfficerLayoutBase)	pBaseCorpOfficer = IF(Corp2_Raw_AR._Flags.Base.CorpOfficer, Corp2_Raw_AR.Files(,pUseOtherEnvironment := FALSE).Base.CorpOfficer.qa, DATASET([], Corp2_Raw_AR.Layouts.CorpOfficerLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(Corp2_Raw_AR.Build_Bases_CorpData(pfiledate,pversion,pUseOtherEnvironment,pInCorpData ,pBaseCorpData ).ALL,
																	Corp2_Raw_AR.Build_Bases_CorpNames(pfiledate,pversion,pUseOtherEnvironment,pInCorpNames ,pBaseCorpNames).ALL,
																	Corp2_Raw_AR.Build_Bases_CorpOfficer(pfiledate,pversion,pUseOtherEnvironment,pInCorpOfficer ,pBaseCorpOfficer).ALL,																		
																	Promote(pversion).BuildFiles.New2Built,
																	Promote().BuildFiles.Built2QA
																 );
																 
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_AR.Build_Bases attribute')
									 );

END;
