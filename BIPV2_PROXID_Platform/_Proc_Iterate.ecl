import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID_Platform;
//have to fix keys attribute too
EXPORT _Proc_Iterate(
   piteration
  ,pversion
  ,pFirstIteration = 'true'
  ,pInfile         = 'BIPV2_ProxID_Platform.In_DOT_Base'
  ,pMatchThreshold = 'BIPV2_ProxID_Platform.Config.MatchThreshold'
  ,pDotFilename    = 'BIPV2_Files.files_dotid().FILE_BASE'
  
) := 
functionmacro
    
  import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID_Platform;
  
  InFile            := pInfile;
  string siter      := piteration;
  string previter   := (string)((unsigned)siter - 1);
  string lversion   := pversion;
  string combo      := lversion + '_' + siter;
  string prevcombo  := lversion + '_' + (string)((unsigned)siter - 1);
  names             :=    BIPV2_ProxID_Platform.filenames(combo).dall_filenames
                        + BIPV2_ProxID_Platform.keynames (combo).dall_filenames
                        ;
                              
  piterate              := BIPV2_ProxID_Platform.Proc_Iterate('',combo,pInfile,BIPV2_ProxID_Platform.filenames(combo).base.logical,/*pMatchThreshold*/,true).DoAllAgain;
  clearsupers            := nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)); //clear supers if needed
  DebugKeys              := BIPV2_ProxID_Platform.Keys(pInfile/*,combo,pMatchThreshold*/).BuildAll;
  // DebugKeys              := BIPV2_ProxID_Platform.Keys(pInfile,combo,pMatchThreshold).BuildAll;
//  outputpossiblematches  := OUTPUT(BIPV2_ProxID_Platform.matches(InFile).PossibleMatches,,BIPV2_ProxID_Platform.filenames(combo).possiblematches.logical,OVERWRITE,COMPRESSED);
  FilesReadRegexFilter    := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID_Platform|dot).*$'    ;
  FilesWrittenRegexFilter := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID_Platform.*base).*$'  ;
  // outputwksummary := wk_ut.mac_createSALTSummaryReport(pversion,workunit,workunit,BIPV2_ProxID_Platform.filenames(combo).wkhistory.logical ,FilesReadRegexFilter,FilesWrittenRegexFilter,'Proxid',pOverwrite := true,pOutputEcl := false,pNumRecords := 1,pSALT28 := true);
  return sequential(
    if(pFirstIteration = true  
        ,BIPV2_ProxID_Platform._fPatch_Foreign_Corpkey_Overlinking(pInfile,prevcombo) 
        ,if(pDotFilename != ''  ,BIPV2_ProxID_Platform.Promote(,'base',pOddFilename := pDotFilename).odd2built)
     )
    ,output(choosen(BIPV2_ProxID_Platform.In_DOT_Base,100))
    ,clearsupers
    ,piterate
    // ,DebugKeys
    ,BIPV2_ProxID_Platform.promote(combo,'^(?!.*?wkhistory.*).*$',pMove2DeleteSuper := true).new2built
    ,BIPV2_ProxID_Platform.promote(,'base',pDelete := true,pIncludeBuiltDelete := true,pCleanupFilter := 'base').Cleanup //cleanup iterations as we go
    ,BIPV2_ProxID_Platform._Output_Review_Samples(pMatchThreshold)
    // ,outputwksummary
    ,BIPV2_ProxID_Platform.promote(combo,'wkhistory').new2qaMult
    ,BIPV2_Tools.mac_Check_Samples(BIPV2_ProxID_Platform.files(combo).base.logical,'Prox' + siter)
    // ,BIPV2_ProxID_Platform.fStatMissingProxIDLinks(BIPV2_ProxID_Platform.In_DOT_Base, piteration)
    ,BIPV2_Build.mod_email.SendSuccessEmail(msg := wk_ut.get_Errors(workunit),subProduct := wk_ut.get_jobname(workunit))
  );
ENDmacro;
