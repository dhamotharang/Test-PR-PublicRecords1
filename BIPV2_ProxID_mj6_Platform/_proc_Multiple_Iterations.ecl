import BIPV2_Files,tools,BIPV2,BIPV2_ProxID_mj6_PlatForm,BIPV2_ProxID,bipv2_build;
EXPORT _proc_Multiple_Iterations(
   pstartiter
  ,pnumiters 
  ,pversion         = 'BIPV2.KeySuffix'
  ,pdoPreprocess    = 'true'
  ,pdoSpecs         = 'true'
  ,pdoIters         = 'true'
  ,pdoPostProcess   = 'true'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pUniqueOut       = '\'ProxidMJ6\''
  ,pDotFilename     = 'BIPV2_Proxid.filenames().base.built'                        //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pMatchThreshold  = '\'0\''
) :=
functionmacro
  
  import wk_ut,tools,bipv2,mdr,BIPV2_ProxID_mj6_PlatForm,BIPV2_Files,bipv2_build;
  
          lstartiter  := pstartiter                               ;
          lnumiters   := pnumiters                                ;
          version     := pversion                                 ;
          cluster     := pcluster                                 ;
  string  previter    := (string)(pstartiter - 1)                 ;
  string  prevcombo   := version + '_' + previter                 ;
          dotbase     := BIPV2_ProxID_mj6_PlatForm._files().base.built ;
  
  #workunit('priority','high' );
  #workunit('protect' ,true   );
  
  ecltextPre    := '#workunit(\'name\',\'BIPV2_ProxID_mj6_PlatForm._PreProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' + 'BIPV2_ProxID_mj6_PlatForm._PreProcess(\'@version@\',\'' + pDotFilename + '\');';  
   
  ecltextSpecs  := '#workunit(\'name\',BIPV2_ProxID_mj6_PlatForm._Constants().name + \' @version@ Specificities\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\ndotbase := BIPV2_ProxID_mj6_PlatForm._files().base.built;\n\nSpecMod := BIPV2_ProxID_mj6_PlatForm.specificities(BIPV2_ProxID_mj6_PlatForm._files().base.built);\nsequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_mj6_PlatForm._SPC\',dotbase,,false)\n//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_mj6_PlatForm._SPC\',dotbase,,false,false)\n  )\n);\n';;

  ecltextIter     :=  'import BIPV2,BIPV2_Build,BIPV2_ProxID_mj6_PlatForm,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\niteration       := \'@iteration@\'                          ;\npversion        := \'@version@\'                            ;\npFirstIteration := false                                  ;\npInfile         := BIPV2_ProxID_mj6_PlatForm.In_DOT_Base               ;\npMatchThreshold := @matchthreshold@                                     ;\npDotFilename    := \'\'                                     ;/*done by BIPV2_ProxID_mj6_PlatForm._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid.FILE_DOTID_BASE*/\n\n#workunit(\'name\',BIPV2_ProxID_mj6_PlatForm._Constants().name + \' \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n\n' 
                    + 'BIPV2_ProxID_mj6_PlatForm._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);\n';
                    
  ecltextIterFix  := regexreplace('@matchthreshold@',ecltextIter,pMatchThreshold,nocase);

  ecltextPost    := '#workunit(\'name\',\'BIPV2_ProxID_mj6_PlatForm._PostProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' + 'BIPV2_ProxID_mj6_PlatForm._PostProcess(\'@version@\');';  

  eclsetResults   := ['PreClusterCount[1].Proxid_Count'   ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','PostClusterCount[1].Proxid_Count'  ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','MatchesPerformed','BasicMatchesPerformed','SlicesPerformed','ProxidsCreatedByCleave'];

  kickPre   := wk_ut.mac_ChainWuids(ecltextPre    ,1         ,1        ,prevcombo,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'PreProcess' ,pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid_mj6.Preprocess'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickSpecs := wk_ut.mac_ChainWuids(ecltextSpecs  ,1         ,1        ,version  ,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Specs'   ,pNotifyEmails := BIPV2_Build.mod_email.emailList   
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid_mj6.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickiters := wk_ut.mac_ChainWuids(ecltextIterFix,lstartiter,lnumiters,version  ,eclsetResults,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Iters'  ,pNotifyEmails := BIPV2_Build.mod_email.emailList    
      ,pOutputFilename   := '~bipv2_build::@version@_@iteration@::workunit_history::proc_proxid_mj6.iterations'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~bipv2_build::@version@_@iteration@::summary_report::proc_proxid_mj6.iterations'
      ,pSummarySuperfile := '~bipv2_build::qa::summary_report::proc_proxid_mj6.iterations'                                                 
  );
  kickPost  := wk_ut.mac_ChainWuids(ecltextPost   ,1         ,1        ,version,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'PostProcess',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid_mj6.PostProcess'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  //kickiters;
  return sequential(
     // if(pDotFilename != ''  and pdoSpecs = true,BIPV2_ProxID_mj6_PlatForm._Promote(,'base',pOddFilename := pDotFilename).odd2built)
     if(pdoPreprocess ,kickPre  )
    // ,output(dotbase)       
    ,if(pdoSpecs      ,kickSpecs)
    ,if(pdoIters      ,kickiters)
    ,if(pdoPostProcess,kickPost )
  );
endmacro;