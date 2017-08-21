IMPORT tools, ut;

EXPORT Build_Bases(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN	puseprod,

	DATASET(Corp2_Raw_CA.Layouts.MastLayoutIn)	 pInMast   = Corp2_Raw_CA.Files(pfiledate,pUseProd).Input.Mast.logical,
	DATASET(Corp2_Raw_CA.Layouts.MastLayoutBase) pBaseMast = IF(Corp2_Raw_CA._Flags.Base.Mast, Corp2_Raw_CA.Files(,pUseOtherEnvironment := FALSE).Base.Mast.qa, DATASET([], Corp2_Raw_CA.Layouts.MastLayoutBase)),
	
	DATASET(Corp2_Raw_CA.Layouts.HistLayoutIn)	 pInHist   = Corp2_Raw_CA.Files(pfiledate,pUseProd).Input.Hist.logical,
	DATASET(Corp2_Raw_CA.Layouts.HistLayoutBase) pBaseHist = IF(Corp2_Raw_CA._Flags.Base.Hist, Corp2_Raw_CA.Files(,pUseOtherEnvironment := FALSE).Base.Hist.qa, DATASET([], Corp2_Raw_CA.Layouts.HistLayoutBase)),
  
	DATASET(Corp2_Raw_CA.Layouts.LPLayoutIn)		 pInLP     = Corp2_Raw_CA.Files(pfiledate,pUseProd).Input.LP.logical,
	DATASET(Corp2_Raw_CA.Layouts.LPLayoutBase)   pBaseLP   = IF(Corp2_Raw_CA._Flags.Base.LP, Corp2_Raw_CA.Files(,pUseOtherEnvironment := FALSE).Base.LP.qa, DATASET([], Corp2_Raw_CA.Layouts.LPLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_CA.Build_Bases_Mast(pfiledate,pversion,puseprod,pInMast,pBaseMast).ALL,
	                                  Corp2_Raw_CA.Build_Bases_Hist(pfiledate,pversion,puseprod,pInHist,pBaseHist).ALL, 
																		Corp2_Raw_CA.Build_Bases_LP(pfiledate,pversion,puseprod,pInLP,pBaseLP).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																	);
											

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CA.Build_Bases attribute')
									 );
 END;

