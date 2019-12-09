IMPORT BIPV2_Best_Debug,	BIPV2_Best,	BIPV2,	BIPV2_Best_Proxid,	BIPV2_Best_Seleid,	VersionControl;

EXPORT proc_Build(

   STRING																		pversion			  =	bipv2.keysuffix
  ,DATASET(BIPV2.CommonBase.Layout )				pHrchyBase		  =	PROJECT(BIPV2_Best_Debug.CommonBase.DS_DEBUG_CLEAN,BIPV2.CommonBase.Layout)
  ,DATASET(BIPV2_Best_Proxid.Layout_Base )	pInBase     	  =	BIPV2_Best.In_Base(pHrchyBase).For_Proxid
  ,DATASET(BIPV2_Best_Seleid.Layout_Base )	sInBase     	  =	BIPV2_Best.In_Base(pHrchyBase).For_Seleid
  ,DATASET(BIPV2_Best.Layouts.Base       )	pBestDebugFile  =	BIPV2_Best.fn_Prep_for_Base(pInBase,sInbase,,,pHrchyBase)
  ,BOOLEAN																	pPromote2QA     =	TRUE
  
) :=
FUNCTION
																							
	//	All filenames associated with this Dataset
  dAll_filenames	:=	Filenames().dAll_filenames  +	
                      Keynames().dAll_filenames;

  outputspecs := OUTPUT(BIPV2_Best_Proxid.specificities(pInBase).Specificities  ,NAMED('specificities'      ));
  outputshift := OUTPUT(BIPV2_Best_Proxid.specificities(pInBase).SpcShift       ,NAMED('specificitiesShift' ));
  
  VersionControl.macBuildNewLogicalFile(BIPV2_Best_Debug.Filenames(pVersion).Base.new	,pBestDebugFile	,Build_DebugBest_File	,TRUE);
  
  returnresult	:=	SEQUENTIAL(
    SEQUENTIAL(
      versioncontrol.mUtilities.createsupers(dAll_filenames)
      ,outputspecs
      ,outputshift
      ,Build_DebugBest_File
      ,BIPV2_Best_Proxid.Keys(pInBase).BuildData
      ,BIPV2_Best_Debug.Promote(pversion).buildfiles.New2Built
    )
    ,BIPV2_Best_Debug.Build_Keys(pversion).ALL
    ,IF(pPromote2QA = TRUE  ,BIPV2_Best_Debug.Promote(pversion).BuildFiles.Built2QA)
    ,Send_Emails(pversion).BuildSuccess
  )	:	FAILURE(Send_Emails(pversion).BuildFailure);
  ;
  
  RETURN returnresult;

END;