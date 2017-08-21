IMPORT BIPV2_Best_SBFE,	BIPV2_Best,	BIPV2,	BIPV2_Best_Proxid,	BIPV2_Best_Seleid,	VersionControl;

EXPORT proc_Build(

   STRING																		pversion			=	bipv2.keysuffix
	,Constants().buildType										pBuildType		=	Constants().buildType.Daily
  ,DATASET(BIPV2.CommonBase.Layout )				pHrchyBase		=	PROJECT(BIPV2_Best_SBFE.CommonBase.DS_SBFE_CLEAN,BIPV2.CommonBase.Layout)
  ,DATASET(BIPV2_Best_Proxid.Layout_Base )	pInBase     	=	BIPV2_Best.In_Base(pHrchyBase).For_Proxid
  ,DATASET(BIPV2_Best_Seleid.Layout_Base )	sInBase     	=	BIPV2_Best.In_Base(pHrchyBase).For_Seleid
  ,DATASET(BIPV2_Best.Layouts.Base       )	pBestSBFEFile	=	BIPV2_Best.fn_Prep_for_Base(pInBase,sInbase,,,pHrchyBase)
  ,BOOLEAN																	pPromote2QA		=	TRUE
  
) :=
FUNCTION
																							
	isDelta	:=	pBuildType=Constants().buildType.Daily;

  outputspecs := OUTPUT(BIPV2_Best_Proxid.specificities(pInBase).Specificities  ,named('specificities'      ));
  outputshift := OUTPUT(BIPV2_Best_Proxid.specificities(pInBase).SpcShift       ,named('specificitiesShift' ));
  
  VersionControl.macBuildNewLogicalFile(BIPV2_Best_SBFE.Filenames(pVersion).Base.bipv2_best.new	,pBestSBFEFile	,Build_SBFEBest_File	,TRUE);
  
  returnresult	:=	SEQUENTIAL(
		IF(~isDelta,
			SEQUENTIAL(
				 outputspecs
				,outputshift
				,Build_SBFEBest_File
				,BIPV2_Best_Proxid.Keys(pInBase).BuildData
				,BIPV2_Best_SBFE.Promote(pversion,pIsDeltaBuild:=isDelta).buildfiles.New2Built
			)
		)
    ,BIPV2_Best_SBFE.Build_Keys(pversion,pBuildType).ALL
    ,IF(pPromote2QA = TRUE  ,BIPV2_Best_SBFE.Promote(pversion,pIsDeltaBuild:=isDelta).BuildFiles.Built2QA)
    ,Send_Emails(pversion).BuildSuccess
  )	:	FAILURE(Send_Emails(pversion).BuildFailure);
  ;
  
  RETURN returnresult;

END;