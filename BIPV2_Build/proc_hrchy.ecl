import BIPV2;
import BIPV2_Testing,wk_ut,tools,_control,bipv2_build;

EXPORT proc_hrchy(
    pversion    = 'BIPV2.KeySuffix'
   ,pcluster    = 'BIPV2_Build._Constants().Groupname'
   ,pOutputEcl  = false
   ,pIsTesting  = 'false'
) := 
functionmacro

  ecl2run   :=  '#workunit(\'name\',\'BIPV2_Build.build_hrchy  @version@\');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n' 
              + 'BIPV2_Build.build_hrchy(\'@version@\' ,,,,,false,,' 
              + if(pIsTesting = false,'false','true') + '  ).runIter;';
  cluster   := pcluster;
  
  setresults := 
  ['Records_With_Lgid3 count_records_has_lgid','Proxids_With_Lgid3 count_proxids_has_lgid'
  ,'Hrchy_Proxids_With_Lgid3 count_hrchy_proxids_has_lgid','Hrchy_Proxids_Ult_Level count_hrchy_proxids_is_ult_level'
  ,'Hrchy_Proxids_Org_Level count_hrchy_proxids_is_org_level','Hrchy_Proxids_Sele_Level count_hrchy_proxids_is_sele_level'
  ,'Hrchy_Proxids_Has_Parent_Proxid count_hrchy_proxids_has_parent_proxid','sum_hrchy_total_nodes'
  ,'hrchy_sele_proxid_disagree_with_is_sele count_hrchy_sele_proxid_disagree_with_is_sele','count_hrchy_UltIDs'
  ,'count_hrchy_OrgIDs','count_hrchy_SELEIDs'
  ,'hrchy_UltIDs_contain_matching_OrgID count_hrchy_UltIDs_contain_matching_OrgID'
  ,'hrchy_OrgIDs_contain_matching_SELEID count_hrchy_OrgIDs_contain_matching_SELEID','hrchy_SELEIDs_contain_matching_ProxID count_hrchy_SELEIDs_contain_matching_ProxID'
  ];
  
  kickBuild := wk_ut.mac_ChainWuids(ecl2run,1,1,pversion,setresults,cluster,,,pOutputEcl,pUniqueOutput := 'BIPV2_HIERARCHY',pNotifyEmails := BIPV2_Build.mod_email.emailList
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_hrchy'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pSummaryFilename  := '~bipv2_build::@version@_@iteration@::summary_report::proc_hrchy'
      ,pSummarySuperfile := '~bipv2_build::qa::summary_report::proc_hrchy'                                                 
  );
  
  return kickBuild;

endmacro;