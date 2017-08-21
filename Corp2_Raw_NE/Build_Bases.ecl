IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																												pfiledate,
	STRING																												pversion,
	Boolean 																					 						pUseOtherEnvironment,
	DATASET(Corp2_Raw_NE.Layouts.CorpActionLayoutIn)							pInCorpAction   		  = Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment).Input.CorpAction.Logical,
	DATASET(Corp2_Raw_NE.Layouts.CorpActionLayoutBase)						pBaseCorpAction 		  = IF(Corp2_Raw_NE._Flags.Base.CorpAction, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.CorpAction.qa, DATASET([], Corp2_Raw_NE.Layouts.CorpActionLayoutBase)),
	DATASET(Corp2_Raw_NE.Layouts.CorpOfficersLayoutIn)						pInCorpOfficers   		= Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment).Input.CorpOfficers.Logical,
	DATASET(Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase)					pBaseCorpOfficers 		= IF(Corp2_Raw_NE._Flags.Base.CorpOfficers, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.CorpOfficers.qa, DATASET([], Corp2_Raw_NE.Layouts.CorpOfficersLayoutBase)),
	DATASET(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn)							pInCorpEntity   			= Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment).Input.CorpEntity.Logical,
	DATASET(Corp2_Raw_NE.Layouts.CorpEntityLayoutBase)						pBaseCorpEntity 			= IF(Corp2_Raw_NE._Flags.Base.CorpEntity, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.CorpEntity.qa, DATASET([], Corp2_Raw_NE.Layouts.CorpEntityLayoutBase)),
	DATASET(Corp2_Raw_NE.Layouts.RegisterAgentLayoutIn)						pInRegisterAgent   		= Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment).Input.RegisterAgent.Logical,
  DATASET(Corp2_Raw_NE.Layouts.RegisterAgentLayoutBase)					pBaseRegisterAgent 		= IF(Corp2_Raw_NE._Flags.Base.RegisterAgent, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.RegisterAgent.qa, DATASET([], Corp2_Raw_NE.Layouts. RegisterAgentLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_NE.Build_Bases_CorpAction(pfiledate,pversion,pUseOtherEnvironment,pInCorpAction,pBaseCorpAction).ALL,
																		Corp2_Raw_NE.Build_Bases_CorpOfficers(pfiledate,pversion,pUseOtherEnvironment,pInCorpOfficers,pBaseCorpOfficers).ALL,
																		Corp2_Raw_NE.Build_Bases_CorpEntity(pfiledate,pversion,pUseOtherEnvironment,pInCorpEntity,pBaseCorpEntity).ALL,
																		Corp2_Raw_NE.Build_Bases_RegisterAgent(pfiledate,pversion,pUseOtherEnvironment,pInRegisterAgent,pBaseRegisterAgent).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_NE.Build_Bases attribute')
									 );

END;
