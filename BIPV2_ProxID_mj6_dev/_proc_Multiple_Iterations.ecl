import BIPV2_Files,tools,BIPV2,BIPV2_ProxID_mj6_dev;
EXPORT _proc_Multiple_Iterations(
   pstartiter
  ,pnumiters 
  ,pversion         = 'BIPV2.KeySuffix'
  ,pdoPreprocess    = 'true'
  ,pdoSpecs         = 'true'
  ,pdoIters         = 'true'
  ,pdoPostProcess   = 'true'
  ,pcluster         = 'tools.fun_Groupname(\'20\',false)'
  ,pUniqueOut       = '\'ProxidMJ6\''
  ,pDOTFile         = '\'BIPV2_Proxid._files().base.built\''
  ,pDotFilename     = 'BIPV2_Proxid._filenames().base.built'                        //'BIPV2_Files.files_dotid.FILE_BASE' //by default it will start where it left off
  ,pMatchThreshold  = '\'0\''
) :=
functionmacro
  
  import wk_ut,tools,bipv2,mdr,BIPV2_ProxID_mj6_dev,BIPV2_Files;
  
          lstartiter  := pstartiter                               ;
          lnumiters   := pnumiters                                ;
          version     := pversion                                 ;
          cluster     := pcluster                                 ;
  string  previter    := (string)(pstartiter - 1)                 ;
  string  prevcombo   := version + '_' + previter                 ;
          dotbase     := BIPV2_ProxID_mj6_dev._files().base.built ;
  
  #workunit('priority','high' );
  #workunit('protect' ,true   );
  
  ecltextPre    := '#workunit(\'name\',\'BIPV2_ProxID_mj6_dev._PreProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' + 'BIPV2_ProxID_mj6_dev._PreProcess(\'@version@\');';  
   
  ecltextSpecs  := '#workunit(\'name\',BIPV2_ProxID_mj6_dev._Constants().name + \' @version@ Specificities\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\ndotbase := BIPV2_ProxID_mj6_dev._files().base.built;\n\nSpecMod := BIPV2_ProxID_mj6_dev.specificities(BIPV2_ProxID_mj6_dev._files().base.built);\nsequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_mj6_dev._SPC\',dotbase,,false)\n//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_ProxID_mj6_dev._SPC\',dotbase,,false,false)\n  )\n);\n';;

  ecltextIter     :=  'import BIPV2,BIPV2_Build,BIPV2_ProxID_mj6_dev,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\niteration       := \'@iteration@\'                          ;\npversion        := \'@version@\'                            ;\npFirstIteration := false                                  ;\npInfile         := BIPV2_ProxID_mj6_dev.In_DOT_Base               ;\npMatchThreshold := @matchthreshold@                                     ;\npDotFilename    := \'\'                                     ;/*done by BIPV2_ProxID_mj6_dev._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid.FILE_DOTID_BASE*/\n\n#workunit(\'name\',BIPV2_ProxID_mj6_dev._Constants().name + \' \' + pversion + \' iter \' + iteration);\n#workunit(\'priority\',\'high\');\n#workunit(\'protect\' ,true);\n\n' 
                    + 'BIPV2_ProxID_mj6_dev._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);\n';
                    
  ecltextIterFix  := regexreplace('@matchthreshold@',ecltextIter,pMatchThreshold,nocase);

  ecltextPost    := '#workunit(\'name\',\'BIPV2_ProxID_mj6_dev._PostProcess @version@\');\n\n' + '#workunit(\'priority\',\'high\');\n' + 'BIPV2_ProxID_mj6_dev._PostProcess(\'@version@\');';  

  eclsetResults   := ['PreClusterCount[1].Proxid_Count'   ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','PostClusterCount[1].Proxid_Count'  ,'{UNSIGNED rcid_Count,UNSIGNED Proxid_Count}','MatchesPerformed','BasicMatchesPerformed','SlicesPerformed','ProxidsCreatedByCleave'];

  kickPre   := wk_ut.mac_ChainWuids(ecltextPre    ,1         ,1        ,prevcombo,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'PreProcess' );
  kickSpecs := wk_ut.mac_ChainWuids(ecltextSpecs  ,1         ,1        ,version  ,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Specs'      );
  kickiters := wk_ut.mac_ChainWuids(ecltextIterFix,lstartiter,lnumiters,version  ,eclsetResults,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Iters'      );
  kickPost  := wk_ut.mac_ChainWuids(ecltextPost   ,1         ,1        ,prevcombo,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'PostProcess');
  
  //kickiters;
  return sequential(
     if(pDotFilename != ''  and pdoSpecs = true,BIPV2_ProxID_mj6_dev._Promote(,'base',pOddFilename := pDotFilename).odd2built)
    ,if(pdoPreprocess ,kickPre  )
    ,output(dotbase)       
    ,if(pdoSpecs      ,kickSpecs)
    ,if(pdoIters      ,kickiters)
    ,if(pdoPostProcess,kickPost )
  );
endmacro;