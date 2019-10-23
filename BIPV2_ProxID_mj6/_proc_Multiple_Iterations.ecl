import BIPV2_Files,tools,BIPV2,BIPV2_ProxID_mj6,BIPV2_ProxID,bipv2_build;
EXPORT _proc_Multiple_Iterations(
   pstartiter       = '\'\''  //default is to start where it left off
  ,pnumiters        = '3'
  ,pversion         = 'BIPV2.KeySuffix'
  ,pdoPreprocess    = 'true'
  ,pdoSpecs         = 'true'
  ,pdoIters         = 'true'
  ,pdoPostProcess   = 'true'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pUniqueOut       = '\'ProxidMJ6\''
  ,pDotFilename     = 'BIPV2_Proxid.filenames().out.built'  //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pMatchThreshold  = '\'0\''
  ,pEmailList       = 'BIPV2_Build.mod_email.emailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
) :=
functionmacro
  
  import workman,tools,bipv2,mdr,BIPV2_ProxID_mj6,BIPV2_Files,bipv2_build;
  
  lstartiter    := pstartiter                               ;
  lnumiters     := pnumiters                                ;
  lnumitersmax  := pnumiters + 1                    ;
  version       := pversion                                 ;
  cluster       := pcluster                                 ;
  dotbase       := BIPV2_ProxID_mj6._files().base.built ;
  
  #workunit('priority','high' );
  #workunit('protect' ,true   );
  
  ecltextPre    := '#workunit(\'name\',\'BIPV2_ProxID_mj6._PreProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' + 'BIPV2_ProxID_mj6._PreProcess(\'@version@\',\'' + pDotFilename + '\');';  
   
  ecltextSpecs  := '#workunit(\'name\',BIPV2_ProxID_mj6._Constants().name + \' @version@ Specificities\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\ndotbase := BIPV2_ProxID_mj6._files().base.built;\n\nSpecMod := BIPV2_ProxID_mj6.specificities(BIPV2_ProxID_mj6._files().base.built);\nsequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_mj6._SPC\',dotbase,,false)\n//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_mj6._SPC\',dotbase,,false,false)\n  )\n);\n';;

  ecltextIter     :=  'import BIPV2,BIPV2_Build,BIPV2_ProxID_mj6,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\niteration       := \'@iteration@\'                          ;\npversion        := \'@version@\'                            ;\npFirstIteration := false                                  ;\npInfile         := BIPV2_ProxID_mj6.In_DOT_Base               ;\npMatchThreshold := @matchthreshold@                                     ;\npDotFilename    := \'\'                                     ;/*done by BIPV2_ProxID_mj6._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid.FILE_DOTID_BASE*/\n\n#workunit(\'name\',BIPV2_ProxID_mj6._Constants().name + \' \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n\n' 
                    + 'BIPV2_ProxID_mj6._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);\n';
                    
  ecltextIterFix  := regexreplace('@matchthreshold@',ecltextIter,pMatchThreshold,nocase);

  ecltextPost    := '#workunit(\'name\',\'BIPV2_ProxID_mj6._PostProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' + 'BIPV2_ProxID_mj6._PostProcess(\'@version@\');';  

  eclsetResults   := [ 'PreClusterCount PreClusterCount.Proxid'        
                      ,'PostClusterCount PostClusterCount.Proxid'       
                      ,'MatchesPerformed'      
                      ,'BasicMatchesPerformed'
                      ,'SlicesPerformed'
                      ,'ProxidsCreatedByCleave'
                      ,'recordsrejected0'
                      ,'unlinkablerecords0'
                    ];
  StopCondition       := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
  SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

  // eclsetResults   := ['PreClusterCount[1].Proxid_Count'   ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','PostClusterCount[1].Proxid_Count'  ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','MatchesPerformed','BasicMatchesPerformed','SlicesPerformed','ProxidsCreatedByCleave'];

  kickPre   := Workman.mac_WorkMan(ecltextPre   ,version,cluster ,1         ,1  ,pBuildName := pUniqueOut + 'PreProcess' ,pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid_mj6.Preprocess'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );
  kickSpecs := Workman.mac_WorkMan(ecltextSpecs  ,version ,cluster ,1         ,1  ,pBuildName := pUniqueOut + 'Specs'   ,pNotifyEmails := pEmailList   
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid_mj6.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );
  kickiters := Workman.mac_WorkMan(ecltextIterFix,version ,cluster,lstartiter,lnumitersmax,lnumiters   
      ,pSetResults          := eclsetResults
      ,pStopCondition       := StopCondition
      ,pSetNameCalculations := SetNameCalculations
      ,pBuildName           := 'ProxidIters'
      ,pNotifyEmails        := pEmailList
      ,pOutputFilename      := '~bipv2_build::@version@::workunit_history::proc_proxid_mj6.iterations'
      ,pOutputSuperfile     := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly         := pCompileTest
  );
  kickPost  := Workman.mac_WorkMan(ecltextPost  ,version ,cluster  ,1         ,1        ,pBuildName := pUniqueOut + 'PostProcess',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid_mj6.PostProcess'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );
  
  //kickiters;
  return sequential(
     // if(pDotFilename != ''  and pdoSpecs = true,BIPV2_ProxID_mj6._Promote(,'base',pOddFilename := pDotFilename).odd2built)
     if(pdoPreprocess ,kickPre  )
    // ,output(dotbase)       
    ,if(pdoSpecs      ,kickSpecs)
    ,if(pdoIters      ,kickiters)
    ,if(pdoPostProcess,kickPost )
  );
endmacro;