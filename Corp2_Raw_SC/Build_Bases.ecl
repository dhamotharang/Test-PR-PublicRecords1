IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_SC.Layouts.CorpFileLayoutIn)		pInCorpFile   				= Corp2_Raw_SC.Files(pfiledate,puseprod).Input.CorpFile.logical,
	DATASET(Corp2_Raw_SC.Layouts.CorpFileLayoutBase)	pBaseCorpFile 		 		= IF(Corp2_Raw_SC._Flags.Base.CorpFile, Corp2_Raw_SC.Files(,pUseOtherEnvironment := FALSE).Base.CorpFile.qa, DATASET([], Corp2_Raw_SC.Layouts.CorpFileLayoutBase)),
	DATASET(Corp2_Raw_SC.Layouts.CorpNameLayoutIn)		pInCorpNameFile   		= Corp2_Raw_SC.Files(pfiledate,puseprod).Input.CorpName.logical,
	DATASET(Corp2_Raw_SC.Layouts.CorpNameLayoutBase)	pBaseCorpNameFile 		= IF(Corp2_Raw_SC._Flags.Base.CorpName, Corp2_Raw_SC.Files(,pUseOtherEnvironment := FALSE).Base.CorpName.qa, DATASET([], Corp2_Raw_SC.Layouts.CorpNameLayoutBase)),
	DATASET(Corp2_Raw_SC.Layouts.CorpTXNLayoutIn)			pInCorpTXNFile   			= Corp2_Raw_SC.Files(pfiledate,puseprod).Input.CorpTXN.logical,
	DATASET(Corp2_Raw_SC.Layouts.CorpTXNLayoutBase)		pBaseCorpTXNFile 			= IF(Corp2_Raw_SC._Flags.Base.CorpTXN, Corp2_Raw_SC.Files(,pUseOtherEnvironment := FALSE).Base.CorpTXN.qa, DATASET([], Corp2_Raw_SC.Layouts.CorpTXNLayoutBase))
) := MODULE

	EXPORT full_build := SEQUENTIAL(	Corp2_Raw_SC.Build_Bases_CorpFile(pfiledate,pversion,puseprod,pInCorpFile,pBaseCorpFile).ALL,
																		Corp2_Raw_SC.Build_Bases_CorpNameFile(pfiledate,pversion,puseprod,pInCorpNameFile,pBaseCorpNameFile).ALL,
																		Corp2_Raw_SC.Build_Bases_CorpTXNFile(pfiledate,pversion,puseprod,pInCorpTXNFile,pBaseCorpTXNFile).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_SC.Build_Bases attribute')
									);

END;