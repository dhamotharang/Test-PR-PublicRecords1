import BIPV2_Files,tools,BIPV2,BIPV2_ProxID_Platform,bipv2_build;
EXPORT _proc_Multiple_Iterations(
   pstartiter
  ,pnumiters 
  ,pversion     = 'BIPV2.KeySuffix'
  ,pDOTFile     = '\'BIPV2_Files.files_dotid.DS_BASE\''
  ,pdopatch     = 'true'
  ,pcluster     = 'BIPV2_Build._Constants().Groupname'
  ,pDotFilename = '\'\''                                  //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pdoSpecs     = 'true'
  ,pUniqueOut  = '\'Proxid\''
  ,pMatchThreshold = 'BIPV2_ProxID_Platform.Config.MatchThreshold'
  ,pForceFile      = 'false'  //force the pDotFilename to be used?
) :=
functionmacro
  
  import wk_ut,tools,bipv2,mdr,BIPV2_ProxID_Platform,SALT25,SALTTOOLS22,BIPV2_Files;
  
  lstartiter := pstartiter;
  lnumiters  := pnumiters ;
  version   := pversion  ;
  cluster   := pcluster  ;
  previter  := (string)(pstartiter - 1) ;
  string prevcombo  := version + '_' + previter;
  dopatch   := pdopatch  ;
  dotbase   := BIPV2_ProxID_Platform.files().base.built ;
  
//  #workunit('name','BIPV2_ProxID_Platform Specificites + kick off iterations ' + (string)startiter + '-' + (string)(startiter + numiters - 1));
  #workunit('priority','high' );
  #workunit('protect' ,true   );
  
  ecltextPatch   := '#workunit(\'name\',BIPV2_ProxID_Platform._Constants().name + \' @version@ ID Patch\'     );\n\n#workunit(\'priority\',\'high\');\nBIPV2_ProxID_Platform._fPatch_Foreign_Corpkey_Overlinking(@INFILE@,\'@version@\');';  
  ecltextPatch2  := regexreplace('@INFILE@',ecltextPatch,pDOTFile,nocase);
   
  ecltextPromote := '#workunit(\'name\',BIPV2_ProxID_Platform._Constants().name + \' @version@ Pre Promote\'     );\n\n#workunit(\'priority\',\'high\');\n' + 'sequential(\n'
   + '   BIPV2_ProxID_Platform.Promote(,\'base\',pOddFilename := \'' + pDotFilename + '\').odd2built\n' 
   + '  ,BIPV2_ProxID_Platform._PreProcess_Strata(,BIPV2_ProxID_Platform.files().base.built,\'@version@\',\'PrePost\')\n'
  + ');';  

  ecltextSpecs  := '#workunit(\'name\',BIPV2_ProxID_Platform._Constants().name + \' @version@ Specificities\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\ndotbase := BIPV2_ProxID_Platform.files().base.built;\n\nSpecMod := BIPV2_ProxID_Platform.specificities(BIPV2_ProxID_Platform.files().base.built);\nsequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_Platform._SPC\',dotbase,,false)\n//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_Platform._SPC\',dotbase,,false,false)\n  )\n);\n';;

  ecltextIter     := 'import BIPV2,BIPV2_Build,BIPV2_ProxID_Platform,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\niteration       := \'@iteration@\'                          ;\npversion        := \'@version@\'                            ;\npFirstIteration := false                                  ;\npInfile         := BIPV2_ProxID_Platform.In_DOT_Base               ;\npMatchThreshold := @matchthreshold@                                     ;\npDotFilename    := \'\'                                     ;/*done by BIPV2_ProxID_Platform._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid.FILE_DOTID_BASE*/\n\n#workunit(\'name\',BIPV2_ProxID_Platform._Constants().name + \' \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n\nBIPV2_ProxID_Platform._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);\n';
  ecltextIterFix  := regexreplace('@matchthreshold@',ecltextIter,#TEXT(pMatchThreshold),nocase);
  eclsetResults   := ['PreClusterCount[1].Proxid_Count'   ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','PostClusterCount[1].Proxid_Count'  ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','MatchesPerformed','BasicMatchesPerformed','SlicesPerformed','ProxidsCreatedByCleave'];

  kickPatch := wk_ut.mac_ChainWuids(ecltextPatch2 ,1         ,1        ,prevcombo,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Patch',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid.Patch'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickPrePromote := wk_ut.mac_ChainWuids(ecltextPromote ,1         ,1        ,prevcombo,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'PrePromote',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid.PrePromote'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickSpecs := wk_ut.mac_ChainWuids(ecltextSpecs  ,1         ,1        ,version  ,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Specs',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickiters := wk_ut.mac_ChainWuids(ecltextIterFix,lstartiter,lnumiters,version  ,eclsetResults,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Iters',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::@version@_@iteration@::workunit_history::proc_proxid.iterations'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      //,pSummaryFilename  := '~bipv2_build::@version@_@iteration@::summary_report::proc_proxid.iterations'
      //,pSummarySuperfile := '~bipv2_build::qa::summary_report::proc_proxid.iterations'                                                 
  );
  
  //kickiters;
  return sequential(
  // output(pDotFilename)
   iff(dopatch = true  
      ,kickPatch 
      ,if(pDotFilename != '' and (pdoSpecs = true or pForceFile = true),kickPrePromote)
    )
    // ,output(dotbase)       
    ,iff(pdoSpecs = true ,kickSpecs)
    ,kickiters
    //need to do post process here to copy to storage thor
  );
endmacro;