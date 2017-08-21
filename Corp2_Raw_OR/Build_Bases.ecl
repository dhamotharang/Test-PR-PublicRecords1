IMPORT tools, ut;

EXPORT Build_Bases(
	STRING																												pfiledate,
	STRING																												pversion,
	BOOLEAN																												puseprod,	
	DATASET(Corp2_Raw_OR.Layouts.CountyDBExtractLayoutIn)					pInCountyDBExtract   				= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.CountyDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase)				pBaseCountyDBExtract 		 		= IF(Corp2_Raw_OR._Flags.Base.CountyDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.CountyDBExtract.qa, DATASET([], Corp2_Raw_OR.Layouts.CountyDBExtractLayoutBase)),
	DATASET(Corp2_Raw_OR.Layouts.EntityDBExtractLayoutIn)					pInEntityDBExtract   				= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.EntityDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.EntityDBExtractLayoutBase)				pBaseEntityDBExtract 				= IF(Corp2_Raw_OR._Flags.Base.EntityDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.EntityDBExtract.qa, DATASET([], Corp2_Raw_OR.Layouts.EntityDBExtractLayoutBase)),
	DATASET(Corp2_Raw_OR.Layouts.MergerShareDBExtractLayoutIn)		pInMergerShareDBExtract   	= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.MergerShareDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.MergerShareDBExtractLayoutBase)	pBaseMergerShareDBExtract 	= IF(Corp2_Raw_OR._Flags.Base.MergerShareDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.MergerShareDBExtract.qa, DATASET([], Corp2_Raw_OR.Layouts.MergerShareDBExtractLayoutBase)),
	DATASET(Corp2_Raw_OR.Layouts.NameDBExtractLayoutIn)						pInNameDBExtract   					= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.NameDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.NameDBExtractLayoutBase)					pBaseNameDBExtract	 				= IF(Corp2_Raw_OR._Flags.Base.NameDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.NameDBExtract.qa, DATASET([], Corp2_Raw_OR.Layouts.NameDBExtractLayoutBase)),
	DATASET(Corp2_Raw_OR.Layouts.RelAssocNameDBExtractLayoutIn)		pInRelAssocNameDBExtract 	 	= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.RelAssocNameDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.RelAssocNameDBExtractLayoutBase)	pBaseRelAssocNameDBExtract	= IF(Corp2_Raw_OR._Flags.Base.RelAssocNameDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.RelAssocNameDBExtract.qa, DATASET([], Corp2_Raw_OR.Layouts.RelAssocNameDBExtractLayoutBase)),
	DATASET(Corp2_Raw_OR.Layouts.TranDBExtractLayoutIn)						pInTranDBExtract   			 		= Corp2_Raw_OR.Files(pfiledate,pUseProd).Input.TranDBExtract.Logical,
	DATASET(Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase)					pBaseTranDBExtract					= IF(Corp2_Raw_OR._Flags.Base.TranDBExtract, Corp2_Raw_OR.Files(,pUseOtherEnvironment := FALSE).Base.TranDBExtract.qa, DATASET([], Corp2_Raw_OR.Layouts.TranDBExtractLayoutBase))

) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_OR.Build_Bases_CountyDBExtract(pfiledate,pversion,puseprod,pInCountyDBExtract,pBaseCountyDBExtract).ALL,
																		Corp2_Raw_OR.Build_Bases_EntityDBExtract(pfiledate,pversion,puseprod,pInEntityDBExtract,pBaseEntityDBExtract).ALL,
																		Corp2_Raw_OR.Build_Bases_MergerShareDBExtract(pfiledate,pversion,puseprod,pInMergerShareDBExtract,pBaseMergerShareDBExtract).ALL,
																		Corp2_Raw_OR.Build_Bases_NameDBExtract(pfiledate,pversion,puseprod,pInNameDBExtract,pBaseNameDBExtract).ALL,
																		Corp2_Raw_OR.Build_Bases_RelAssocNameDBExtract(pfiledate,pversion,puseprod,pInRelAssocNameDBExtract,pBaseRelAssocNameDBExtract).ALL,
																		Corp2_Raw_OR.Build_Bases_TranDBExtract(pfiledate,pversion,puseprod,pInTranDBExtract,pBaseTranDBExtract).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA																		
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OR.Build_Bases attribute')
									 );

END;