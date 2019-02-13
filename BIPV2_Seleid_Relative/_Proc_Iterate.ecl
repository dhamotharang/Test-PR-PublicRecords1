import BIPV2_Files,tools,BIPV2,BIPV2_ProxID_mj6,BIPV2_ProxID,bipv2_build;
EXPORT _Proc_Iterate(
   pversion         = 'BIPV2.KeySuffix'
  ,pdoSpecs         = 'true'
  ,pdoIters         = 'true'
  ,pcluster         = 'BIPV2_Build._Constants().Groupname'
  ,pUniqueOut       = '\'BIPV2_Seleid_Relative\''
) :=
functionmacro
  
  import wk_ut,tools,bipv2,mdr,BIPV2_ProxID_mj6,BIPV2_Files,bipv2_build;
  
  version       := pversion                      ;
  cluster       := pcluster                      ;
  ds_CommonBase := BIPV2_Seleid_Relative.In_Base ;
  
  #workunit('priority','high' );
  #workunit('protect' ,true   );
    
  ecltextSpecs  :=  '#workunit(\'name\',\'BIPV2_Seleid_Relative @version@ Specificities\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' + 'ds_CommonBase := BIPV2_Seleid_Relative.In_Base;\n\n'
                  + 'SpecMod := BIPV2_Seleid_Relative.specificities(BIPV2_Seleid_Relative.In_Base);\nsequential(\n  SpecMod.Build\n  ,parallel(\n     OUTPUT(SpecMod.Specificities ,NAMED(\'Specificities\'))\n'
                  + '    ,OUTPUT(SpecMod.SpcShift      ,NAMED(\'SpcShift\'     ))\n    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_Seleid_Relative._SPC\',ds_CommonBase,,false)\n'
                  + '//     ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,\'BIPV2_Seleid_Relative._SPC\',ds_CommonBase,,false,true)\n  )\n);\n';

  ecltextIter     :=  'import BIPV2,BIPV2_Build,tools,mdr,BIPV2_Files;\n\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n'
                    + 'pversion        := \'@version@\'                  ;\n' 
                    + 'ds_CommonBase   := BIPV2_Seleid_Relative.In_Base  ;\n'
                    + '\n\n#workunit(\'name\',\'BIPV2_Seleid_Relative._Proc_Iterate \' + pversion);\n'
                    + '#workunit(\'protect\' ,true);\n\n' 
                    + 'sequential(\n'
                    + '  BIPV2_Seleid_Relative.Proc_Iterate(\'1\',ds_CommonBase,pversion).DoAll\n'
                    + ' ,BIPV2_Seleid_Relative.Promote(pversion).New2Built\n'
                    + '// ,if(pPromote2QA = true  ,BIPV2_Seleid_Relative.Promote(pversion).Built2QA)\n'
                    + ');'
                    ;
                    
  kickSpecs := wk_ut.mac_ChainWuids(ecltextSpecs  ,1         ,1        ,version  ,[]           ,cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Specs' ,pNotifyEmails := BIPV2_Build.mod_email.emailList     
      ,pOutputFilename   := '~bipv2_build::' + version + '::workunit_history::BIPV2_Seleid_Relative.specificities'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  kickiters := wk_ut.mac_ChainWuids(ecltextIter,1,1,version  ,[],cluster,pOutputEcl := false,pUniqueOutput := pUniqueOut + 'Iters'     ,pNotifyEmails := BIPV2_Build.mod_email.emailList 
      ,pOutputFilename   := '~bipv2_build::@version@_@iteration@::workunit_history::BIPV2_Seleid_Relative'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      // ,pSummaryFilename  := '~bipv2_build::@version@_@iteration@::summary_report::proc_proxid_mj6.iterations'
      // ,pSummarySuperfile := '~bipv2_build::qa::summary_report::proc_proxid_mj6.iterations'                                                 
  );
  
  //kickiters;
  return sequential(
     if(pdoSpecs      ,kickSpecs)
    ,if(pdoIters      ,kickiters)
  );
endmacro;