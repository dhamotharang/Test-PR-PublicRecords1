//EXPORT BIPV2_Best_Proc_Build := 'todo';
import tools,BIPV2_Build,bipv2,bipv2_best,BIPV2_Best_Proxid,BIPV2_Files,BIPv2_HRCHY,BIPV2_Best_Proxid,BIPV2_Best_Seleid;

EXPORT BIPV2_Best_Proc_Build(

   string                                  pversion    = bipv2.keysuffix
  ,dataset(BIPV2.CommonBase.Layout ) pHrchyBase  = project(PRTE2_BIPV2_BusHeader.File_DS_CLEAN,BIPV2.CommonBase.Layout)
  ,dataset(BIPV2_Best_Proxid.Layout_Base ) pInBase     = PRTE2_BIPV2_BusHeader.BIPV2_Best_Proxid_In_Base
  ,dataset(BIPV2_Best_Seleid.Layout_Base ) sInBase     = PRTE2_BIPV2_BusHeader.BIPV2_Best_Seleid_In_Base
  ,dataset(BIPV2_Best.Layouts.Base       ) pBestFile   = BIPV2_Best.fn_Prep_for_Base(pInBase,sInbase,,,pHrchyBase)
  ,boolean                                 pPromote2QA = true
  
) :=
function
																							
  outputspecs := output(BIPV2_Best_Proxid.specificities(pInBase).Specificities  ,named('specificities'      ));
  outputshift := output(BIPV2_Best_Proxid.specificities(pInBase).SpcShift       ,named('specificitiesShift' ));
  
  Build_Base_File := tools.macf_WriteFile(PRTE2_BIPV2_BusHeader.Filenames(pversion).Base.BestBase.new	,pBestFile);
  semail := BIPV2_Build.Send_Emails(pversion,pBuildName := 'PRTE2_BIPV2_BusHeader Best',pEmailList := 'giri.rajulapalli@lexisnexisrisk.com').BIPV2FullKeys;
  
  returnresult := sequential(
     outputspecs
    ,outputshift
    ,Build_Base_File
    //,BIPV2_Best_Proxid.Keys(pInBase).BuildData
    ,PRTE2_BIPV2_BusHeader.Promote(pversion).New2Built
    ,PRTE2_BIPV2_BusHeader.BIPV2_Best_Build_Keys(pversion).all
    ,if(pPromote2QA = true  ,PRTE2_BIPV2_BusHeader.Promote(pversion).Built2QA)
    ,semail.BuildSuccess
  ) : failure(semail.BuildFailure)
  ;
  
  return returnresult;

end;