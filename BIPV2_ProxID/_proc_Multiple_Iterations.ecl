import BIPV2_Files,tools,BIPV2,BIPV2_ProxID,bipv2_build;
EXPORT _proc_Multiple_Iterations(
   pstartiter       = '\'\''    //default is to start where it left off
  ,pnumiters        = '3'
  ,pversion         = 'BIPV2.KeySuffix'
  ,pDOTFile         = '\'BIPV2_Files.files_dotid().DS_BASE\''
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pDotFilename     = '\'\''                                  //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pdoPreprocess    = 'true'
  ,pdoSpecs         = 'true'
  ,pdoIter          = 'true'
  ,pdoPostprocess   = 'BIPV2_ProxID._Constants().RunPostProcess'
  ,pUniqueOut       = '\'Proxid\''
  ,pMatchThreshold  = 'BIPV2_ProxID.Config.MatchThreshold'
  ,pEmailList       = 'BIPV2_ProxID._Constants().EmailList'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
  ,pdo1Iteration    = 'false'
  ,pIsTesting       = 'false'
) :=
functionmacro
  
  import workman,tools,bipv2,mdr,BIPV2_ProxID,SALTTOOLS22,BIPV2_Files,BIPV2_Build;
  
  lstartiter        := pstartiter                       ;
  lnumiters         := pnumiters                        ;
  lnumitersmax      := #IF(pdo1Iteration = false) pnumiters + 1  #ELSE pnumiters #END                 ;
  version           := pversion                         ;
  cluster           := pcluster                         ;
  dotbase           := BIPV2_ProxID.files().base.built  ;
  dotbasefilename   := if(trim(pDotFilename) = '' ,BIPV2_Files.files_dotid().FILE_BASE  ,pDotFilename);
  
//  #workunit('name','BIPV2_ProxID Specificites + kick off iterations ' + (string)startiter + '-' + (string)(startiter + numiters - 1));
  #workunit('priority','high' );
  #workunit('protect' ,true   );
  
  ecltextPreprocess :=  '#workunit(\'name\',\'BIPV2_ProxID._Preprocess @version@\');\n\n#workunit(\'priority\',\'high\');\n'
                      + 'BIPV2_ProxID._Preprocess('+ pDOTFile + ',\'@version@\',\'' + dotbasefilename + '\''
                      + ',\'' + pUniqueOut + '\''
  #IF(pIsTesting = true)  //don't need to do all the other stuff when testing an iteration
                      + ',false'
                      + ',false'
                      + ',false'
                      + ',false'
                      + ',false'
  #END
                      + ');';
                      
  workman_preprocess_file  := '_Preprocess.'  + pUniqueOut;
  workman_postprocess_file := '_PostProcess.' + pUniqueOut;
  
  ecltextSpecs  := '#workunit(\'name\',BIPV2_ProxID._Constants().name + \' @version@ Specificities\');\n'
                  + '#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n'
                  + 'dotbase := BIPV2_ProxID.files().base.built;\n\n'
                  + 'SpecMod := BIPV2_ProxID.specificities(BIPV2_ProxID.files().base.built);\n'
                  +'sequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n'
                  + '//,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID._SPC\',dotbase,,false)\n'
                  + '//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID._SPC\',dotbase,,false,false)\n'
                  + ')\n);\n';
  
  ecltextIter     := 'import BIPV2,BIPV2_Build,BIPV2_ProxID,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\niteration       := \'@iteration@\'                          ;\npversion        := \'@version@\'                            ;\npFirstIteration := false                                  ;\npInfile         := BIPV2_ProxID.In_DOT_Base               ;\npMatchThreshold := @matchthreshold@                                     ;\npDotFilename    := \'\'                                     ;/*done by BIPV2_ProxID._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid().FILE_DOTID_BASE*/\n\n#workunit(\'name\',BIPV2_ProxID._Constants().name + \' \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n\n'
                    +'BIPV2_ProxID._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);\n';
                    
  ecltextIterFix  := regexreplace('@matchthreshold@',ecltextIter,#TEXT(pMatchThreshold),nocase);

/*  eclsetResults   := [ 'PreClusterCount PreClusterCount[3].cnt'         ,'{STRING10 Count_Type, UNSIGNED Cnt}'
                      ,'PostClusterCount PostClusterCount[3].cnt'       ,'{STRING10 Count_Type, UNSIGNED Cnt}'
                      ,'MatchesPerformed MatchStatistics[1].Value'      ,'{STRING label, UNSIGNED value}'
                      // ,'BasicMatchesPerformed MatchStatistics[2].Value' ,'{STRING label, UNSIGNED value}'  //can't do this yet because it references the same result output as above.  Next release of workman will allow it
                      // ,'SlicesPerformed MatchStatistics[3].Value'       ,'{STRING label, UNSIGNED value}'  //can't do this yet because it references the same result output as above.  Next release of workman will allow it
                      ,'ProxidsCreatedByCleave'
                     ];
*/
  eclsetResults   := [ 'PreClusterCount PreClusterCount.Proxid_Cnt'        
                      ,'PostClusterCount PostClusterCount.Proxid_Cnt'       
                      ,'MatchesPerformed'      
                      ,'BasicMatchesPerformed'
                      ,'SlicesPerformed'
                      ,'ProxidsCreatedByCleave'
                      ,'LinkBlockSplits'
                      ,'recordsrejected0'
                      ,'unlinkablerecords0'
                     ];
  StopCondition   := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
  SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];

  ecltextPost    := '#workunit(\'name\',\'BIPV2_ProxID._PostProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' 
                  + 'BIPV2_ProxID._PostProcess(\'@version@\',' + pDOTFile + ',\'' + dotbasefilename + '\');';  

  kickPreprocess := Workman.mac_WorkMan(ecltextPreprocess ,version,cluster,1         ,1        ,pBuildName := pUniqueOut + 'Patch',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_ProxID.proc_proxid.' + workman_preprocess_file
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );
  kickSpecs := Workman.mac_WorkMan(ecltextSpecs  ,version,cluster,1         ,1        ,pBuildName := pUniqueOut + 'Specs',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_ProxID.proc_proxid.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );
  kickiters := Workman.mac_WorkMan(ecltextIterFix,version,cluster,pstartiter,lnumitersmax,lnumiters
      ,pSetResults          := eclsetResults
      ,pStopCondition       := StopCondition
      ,pSetNameCalculations := SetNameCalculations
      ,pBuildName           := 'ProxidIters'
      ,pNotifyEmails        := pEmailList
      ,pOutputFilename      := '~bipv2_build::@version@::workunit_history::BIPV2_ProxID.proc_proxid.iterations.' + trim(pUniqueOut)
      ,pOutputSuperfile     := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly         := pCompileTest
  );
 
  kickPost  := Workman.mac_WorkMan(ecltextPost,version ,cluster  ,1         ,1        ,pBuildName := pUniqueOut + 'PostProcess',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_ProxID.proc_proxid.' + workman_postprocess_file
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );

  //kickiters;
  return sequential(
     #IF(pdoPreprocess = true)   kickPreprocess,  #END
     #IF(pdoSpecs      = true)   kickSpecs,       #END
                                 kickiters
     #IF(pdoPostprocess = true) ,kickPost #END
  );
endmacro;
