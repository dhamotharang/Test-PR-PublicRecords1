import BIPV2_Files,tools,BIPV2,BIPV2_ProxID,bipv2_build;
EXPORT _proc_Multiple_Iterations(
   pstartiter
  ,pnumiters 
  ,pversion         = 'BIPV2.KeySuffix'
  ,pDOTFile         = '\'BIPV2_Files.files_dotid().DS_BASE\''
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pDotFilename     = '\'\''                                  //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pdoSpecs         = 'true'
  ,pUniqueOut       = '\'Proxid\''
  ,pMatchThreshold  = 'BIPV2_ProxID.Config.MatchThreshold'
) :=
functionmacro
  
  import wk_ut,tools,bipv2,mdr,BIPV2_ProxID,SALTTOOLS22,BIPV2_Files,BIPV2_Build;
  
  lstartiter        := pstartiter                       ;
  lnumiters         := pnumiters                        ;
  version           := pversion                         ;
  cluster           := pcluster                         ;
  previter          := (string)(pstartiter - 1)         ;
  string prevcombo  := version + '_' + previter         ;
  dotbase           := BIPV2_ProxID.files().base.built  ;
  dotbasefilename   := if(trim(pDotFilename) = '' ,BIPV2_Files.files_dotid().FILE_BASE  ,pDotFilename);
  
//  #workunit('name','BIPV2_ProxID Specificites + kick off iterations ' + (string)startiter + '-' + (string)(startiter + numiters - 1));
  #workunit('priority','high' );
  #workunit('protect' ,true   );
  
  ecltextPreprocess :=  '#workunit(\'name\',\'BIPV2_ProxID._Preprocess @version@\');\n\n#workunit(\'priority\',\'high\');\n'
                      + 'BIPV2_ProxID._Preprocess('+ pDOTFile + ',\'@version@\',\'' + dotbasefilename + '\''
                      + ',\'' + pUniqueOut + '\''
                      + ');';
                      
  workman_preprocess_file  := '_Preprocess.'  + pUniqueOut;
  workman_postprocess_file := '_PostProcess.' + pUniqueOut;
  
  ecltextSpecs  := '#workunit(\'name\',BIPV2_ProxID._Constants().name + \' @version@ Specificities\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\ndotbase := BIPV2_ProxID.files().base.built;\n\nSpecMod := BIPV2_ProxID.specificities(BIPV2_ProxID.files().base.built);\n'
                  +'sequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID._SPC\',dotbase,,false)\n//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID._SPC\',dotbase,,false,false)\n  )\n);\n';;
  
  ecltextIter     := 'import BIPV2,BIPV2_Build,BIPV2_ProxID,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\niteration       := \'@iteration@\'                          ;\npversion        := \'@version@\'                            ;\npFirstIteration := false                                  ;\npInfile         := BIPV2_ProxID.In_DOT_Base               ;\npMatchThreshold := @matchthreshold@                                     ;\npDotFilename    := \'\'                                     ;/*done by BIPV2_ProxID._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid().FILE_DOTID_BASE*/\n\n#workunit(\'name\',BIPV2_ProxID._Constants().name + \' \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n\n'
                    +'BIPV2_ProxID._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);\n';
                    
  ecltextIterFix  := regexreplace('@matchthreshold@',ecltextIter,#TEXT(pMatchThreshold),nocase);

  eclsetResults   := [ 'PreClusterCount PreClusterCount[3].cnt'         ,'{STRING10 Count_Type, UNSIGNED Cnt}'
                      ,'PostClusterCount PostClusterCount[3].cnt'       ,'{STRING10 Count_Type, UNSIGNED Cnt}'
                      ,'MatchesPerformed MatchStatistics[1].Value'      ,'{STRING label, UNSIGNED value}'
                      // ,'BasicMatchesPerformed MatchStatistics[2].Value' ,'{STRING label, UNSIGNED value}'  //can't do this yet because it references the same result output as above.  Next release of workman will allow it
                      // ,'SlicesPerformed MatchStatistics[3].Value'       ,'{STRING label, UNSIGNED value}'  //can't do this yet because it references the same result output as above.  Next release of workman will allow it
                      ,'ProxidsCreatedByCleave'
                     ];

  // eclsetResults   := ['PreClusterCount PreClusterCount[3].cnt' ,'{STRING10 Count_Type, UNSIGNED Cnt}' ,'PostClusterCount PostClusterCount[3].cnt' ,'{STRING10 Count_Type, UNSIGNED Cnt}' ,'ProxidsCreatedByCleave'];

  ecltextPost    := '#workunit(\'name\',\'BIPV2_ProxID._PostProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' 
                  + 'BIPV2_ProxID._PostProcess(\'@version@\',' + pDOTFile + ',\'' + dotbasefilename + '\');';  

  kickPreprocess := wk_ut.mac_ChainWuids(ecltextPreprocess ,1         ,1        ,prevcombo,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Patch',pNotifyEmails := BIPV2_ProxID._Constants().EmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid.' + workman_preprocess_file
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickSpecs := wk_ut.mac_ChainWuids(ecltextSpecs  ,1         ,1        ,version  ,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Specs',pNotifyEmails := BIPV2_ProxID._Constants().EmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid.Specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  kickiters := wk_ut.mac_ChainWuids(ecltextIterFix,lstartiter,lnumiters,version  ,eclsetResults,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Iters',pNotifyEmails := BIPV2_ProxID._Constants().EmailList
      ,pOutputFilename   := '~bipv2_build::@version@_@iteration@::workunit_history::proc_proxid.iterations'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~bipv2_build::@version@_@iteration@::summary_report::proc_proxid.iterations'
      ,pSummarySuperfile := '~bipv2_build::qa::summary_report::proc_proxid.iterations'                                                 
  );
 
  kickPost  := wk_ut.mac_ChainWuids(ecltextPost   ,1         ,1        ,version,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'PostProcess',pNotifyEmails := BIPV2_ProxID._Constants().EmailList
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::proc_proxid.' + workman_postprocess_file
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );

  //kickiters;
  return sequential(
     kickPreprocess
    ,iff(pdoSpecs = true ,kickSpecs)
    ,kickiters
    ,if(BIPV2_ProxID._Constants().RunPostProcess  ,kickPost)
    
    //need to do post process here to copy to storage thor
  );
endmacro;
