import tools,BIPV2_Build,bipv2,bipv2_best,BIPV2_Best_Proxid,BIPV2_Files,BIPv2_HRCHY,BIPV2_Best_Seleid;

EXPORT proc_Build(

   string                                   pversion    = bipv2.keysuffix
  ,dataset(BIPV2.CommonBase.Layout        ) pHrchyBase  = project(BIPV2.CommonBase.DS_CLEAN,BIPV2.CommonBase.Layout)
  ,dataset(BIPV2_Best_Proxid.Layout_Base  ) pInBase     = BIPV2_Best_Proxid.In_Base
  ,dataset(BIPV2_Best_Seleid.Layout_Base  ) sInBase     = BIPV2_Best_Seleid.In_Base
  ,dataset(BIPV2_Best.Layouts.Base        ) pBestFile   = BIPV2_Best.fn_Prep_for_Base(pInBase,sInbase,,,pHrchyBase)
  ,boolean                                  pPromote2QA = true
  
) :=
function
																							
  outputspecs := output(BIPV2_Best_Proxid.specificities(pInBase).Specificities  ,named('specificities'      ));
  outputshift := output(BIPV2_Best_Proxid.specificities(pInBase).SpcShift       ,named('specificitiesShift' ));
  
  Build_Base_File := tools.macf_WriteFile(BIPV2_Best.Filenames(pversion).base.new	,pBestFile);
  semail := BIPV2_Build.Send_Emails(pversion,pBuildName := 'BIPV2 Best',pEmailList := 'laverne.bentley@lexisnexis.com,5615731227@txt.att.net,angela.herzberg@lexisnexis.com').BIPV2FullKeys;
  
  returnresult := sequential(
     outputspecs
    ,outputshift
    ,Build_Base_File
    ,BIPV2_Best_Proxid.Keys(pInBase).BuildData
    ,BIPV2_Best.Promote(pversion).New2Built
    ,BIPV2_Best.Build_Keys(pversion).all
    ,if(pPromote2QA = true  ,BIPV2_Best.Promote(pversion).Built2QA)
    ,semail.BuildSuccess
  ) : failure(semail.BuildFailure)
  ;
  
  return returnresult;

end;