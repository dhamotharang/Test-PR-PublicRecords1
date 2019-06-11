import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID_mj6;
//have to fix keys attribute too
EXPORT _Proc_Iterate(
   piteration
  ,pversion
  ,pFirstIteration = 'true'
  ,pInfile         = 'BIPV2_ProxID_mj6.In_DOT_Base'
  ,pMatchThreshold = '0'
  ,pDotFilename    = '\'\''//'BIPV2_Files.files_dotid.FILE_BASE'
  
) := 
functionmacro
    
  import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID_mj6,BIPV2_QA_Tool;
  
  InFile            := pInfile;
  string siter      := piteration;
  string previter   := (string)((unsigned)siter - 1);
  string lversion   := pversion;
  string combo      := lversion + '_' + siter;
  string prevcombo  := lversion + '_' + (string)((unsigned)siter - 1);
  names             :=    BIPV2_ProxID_mj6._filenames(combo).dall_filenames
                        + BIPV2_ProxID_mj6._keynames (combo).dall_filenames
                        ;
                              
  piterate              := BIPV2_ProxID_mj6.Proc_Iterate('',combo,pInfile,BIPV2_ProxID_mj6._filenames(combo).base.logical,pMatchThreshold,true).DoAllAgain;
  clearsupers           := nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)); //clear supers if needed
  // DebugKeys              := BIPV2_ProxID_mj6.Keys(pInfile,combo,pMatchThreshold).BuildAll;
//  outputpossiblematches  := OUTPUT(BIPV2_ProxID_mj6.matches(InFile).PossibleMatches,,BIPV2_ProxID_mj6.filenames(combo).possiblematches.logical,OVERWRITE,COMPRESSED);
  FilesReadRegexFilter    := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID_mj6|dot).*$'    ;
  FilesWrittenRegexFilter := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID_mj6.*base).*$'  ;
  // outputwksummary := wk_ut.mac_createSALTSummaryReport(pversion,workunit,workunit,BIPV2_ProxID_mj6._filenames(combo).wkhistory.logical ,FilesReadRegexFilter,FilesWrittenRegexFilter,'Proxid',pOverwrite := true,pOutputEcl := false,pNumRecords := 1,pSALT28 := true);
	constructTraceFiles:=BIPV2_ProxID_mj6._ConstructTracebackFiles(lversion, siter).outKeyFiles;
  return sequential(
     if(pDotFilename != ''  ,BIPV2_ProxID_mj6._Promote(,'base',pOddFilename := pDotFilename).odd2built)
    ,output(choosen(BIPV2_ProxID_mj6.In_DOT_Base,100))
    ,clearsupers
    ,piterate
    // ,DebugKeys
    ,BIPV2_ProxID_mj6._promote(combo,'^(?!.*?wkhistory.*).*$',pMove2DeleteSuper := true).new2built
    ,BIPV2_ProxID_mj6._promote(,'base',pDelete := true,pIncludeBuiltDelete := true,pCleanupFilter := 'base').Cleanup //cleanup iterations as we go
    ,BIPV2_ProxID_mj6._Output_Review_Samples(pMatchThreshold)
    // ,outputwksummary
    ,BIPV2_ProxID_mj6._promote(combo,'wkhistory').new2qaMult
    ,BIPV2_ProxID_mj6._mac_Check_Samples(BIPV2_ProxID_mj6._files(combo).base.logical,'ProxMj6' + siter)
		,constructTraceFiles
    ,BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,proxid ,pversion  ,piteration  ,BIPV2_Proxid_mj6.Config.MatchThreshold ,'BIPV2_Proxid_mj6')
    ,BIPV2_Build.mod_email.SendSuccessEmail(msg := wk_ut.get_Errors(workunit),subProduct := wk_ut.get_jobname(workunit))
  );
ENDmacro;
