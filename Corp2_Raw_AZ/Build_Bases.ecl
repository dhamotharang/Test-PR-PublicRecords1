IMPORT tools, ut, Corp2_Raw_AZ;

EXPORT Build_Bases(	
	 STRING	 pfiledate
	,STRING	 pversion
	,BOOLEAN puseprod
	
	,DATASET(Corp2_Raw_AZ.Layouts.COREXT_LayoutIn)		pInCOREXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.COREXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.COREXT_LayoutBase)	pBaseCOREXTFile = IF(_Flags.Base.COREXT 
																																				 ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.COREXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.COREXT_LayoutBase))

	,DATASET(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn)		pInCHGEXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.CHGEXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase)	pBaseCHGEXTFile = IF(_Flags.Base.CHGEXT 
																																			   ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.CHGEXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.CHGEXT_LayoutBase))

	,DATASET(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn)		pInFLMEXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.FLMEXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase)	pBaseFLMEXTFile = IF(_Flags.Base.FLMEXT 
																																			   ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.FLMEXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.FLMEXT_LayoutBase))

	,DATASET(Corp2_Raw_AZ.Layouts.OFFEXT_LayoutIn)		pInOFFEXTFile   = Corp2_Raw_AZ.Files(pfiledate,puseprod).Input.OFFEXT.logical
	,DATASET(Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase)	pBaseOFFEXTFile = IF(_Flags.Base.OFFEXT 
																																				 ,Corp2_Raw_AZ.Files(,pUseOtherEnvironment := FALSE).Base.OFFEXT.qa
																																				 ,DATASET([],Corp2_Raw_AZ.Layouts.OFFEXT_LayoutBase))																																						    																																				
	   ) := MODULE

	// --------------------------------
	EXPORT full_build := sequential(	Corp2_Raw_AZ.Build_Bases_COREXT(pfiledate,pversion,puseprod,pInCOREXTFile,pBaseCOREXTFile).ALL,
																		Corp2_Raw_AZ.Build_Bases_CHGEXT(pfiledate,pversion,puseprod,pInCHGEXTFile,pBaseCHGEXTFile).ALL,
																		Corp2_Raw_AZ.Build_Bases_FLMEXT(pfiledate,pversion,puseprod,pInFLMEXTFile,pBaseFLMEXTFile).ALL,
																		Corp2_Raw_AZ.Build_Bases_OFFEXT(pfiledate,pversion,puseprod,pInOFFEXTFile,pBaseOFFEXTFile).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																		);																	

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AZ.Build_Bases attribute')
									 );

END;
