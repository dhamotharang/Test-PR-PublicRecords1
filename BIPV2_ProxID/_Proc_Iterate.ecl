import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID;
//have to fix keys attribute too
EXPORT _Proc_Iterate(
   piteration
  ,pversion
  ,pFirstIteration = 'true'
  ,pInfile         = 'BIPV2_ProxID.In_DOT_Base'
  ,pMatchThreshold = 'BIPV2_ProxID.Config.MatchThreshold'
  ,pDotFilename    = 'BIPV2_Files.files_dotid().FILE_BASE'
  
) := 
functionmacro
    
  import tools,std,BIPV2_Files,wk_ut,bipv2_build,BIPV2_ProxID,BIPV2_QA_Tool;
  
  InFile            := pInfile;
  string siter      := piteration;
  string previter   := (string)((unsigned)siter - 1);
  string lversion   := pversion;
  string combo      := lversion + '_' + siter;
  string prevcombo  := lversion + '_' + (string)((unsigned)siter - 1);
  names             :=    BIPV2_ProxID.filenames(combo).dall_filenames
                        + BIPV2_ProxID.keynames (combo).dall_filenames
                        ;
                              
  piterate              := BIPV2_ProxID.Proc_Iterate('',combo,pInfile,BIPV2_ProxID.filenames(combo).base.logical,/*pMatchThreshold*/,true).DoAllAgain;
  clearsupers            := nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)); //clear supers if needed
  DebugKeys              := BIPV2_ProxID.Keys(pInfile/*,combo,pMatchThreshold*/).BuildAll;
  // DebugKeys              := BIPV2_ProxID.Keys(pInfile,combo,pMatchThreshold).BuildAll;
//  outputpossiblematches  := OUTPUT(BIPV2_ProxID.matches(InFile).PossibleMatches,,BIPV2_ProxID.filenames(combo).possiblematches.logical,OVERWRITE,COMPRESSED);
  FilesReadRegexFilter    := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID|dot).*$'    ;
  FilesWrittenRegexFilter := '^(?!.*?key.*)(?=.*?([[:digit:]]{5,}).*).*?(BIPV2_ProxID.*base).*$'  ;
  // outputwksummary := wk_ut.mac_createSALTSummaryReport(pversion,workunit,workunit,BIPV2_ProxID.filenames(combo).wkhistory.logical ,FilesReadRegexFilter,FilesWrittenRegexFilter,'Proxid',pOverwrite := true,pOutputEcl := false,pNumRecords := 1,pSALT28 := true);
  constructTraceFiles:=BIPV2_ProxID._ConstructTracebackFiles(lversion, siter).outKeyFiles; 
	return sequential(
     output(choosen(BIPV2_ProxID.In_DOT_Base,100))
    ,clearsupers
    ,piterate
    // ,DebugKeys
    ,BIPV2_ProxID.promote(combo,'^(?!.*?(wkhistory|changes).*).*$',pMove2DeleteSuper := true).new2built
    ,BIPV2_ProxID.promote(,'base',pDelete := true,pIncludeBuiltDelete := true,pCleanupFilter := 'base').Cleanup //cleanup iterations as we go
    ,BIPV2_ProxID._Output_Review_Samples(pMatchThreshold)
    // ,outputwksummary
    ,if(BIPV2_ProxID._Constants().Add2WorkmanSuper  ,BIPV2_ProxID.promote(combo,'(wkhistory|changes)').new2qaMult)
    ,BIPV2_Tools.mac_Check_Samples(BIPV2_ProxID.files(combo).base.logical,'Prox' + siter)
    // ,BIPV2_ProxID.fStatMissingProxIDLinks(BIPV2_ProxID.In_DOT_Base, piteration)
		,if(BIPV2_ProxID._Constants().doTraceBackFiles  ,constructTraceFiles)//PUT BACK!!!
    ,BIPV2_QA_Tool.mac_Iteration_Stats(workunit  ,proxid ,pversion  ,piteration  ,BIPV2_Proxid.Config.MatchThreshold ,'BIPV2_Proxid')
    ,BIPV2_Build.mod_email.SendSuccessEmail(msg := wk_ut.get_Errors(workunit),subProduct := wk_ut.get_jobname(workunit))
  );
ENDmacro;
