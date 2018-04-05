import wk_ut,tools;

EXPORT proc_xlink_validation(pversion = 'BIPV2.KeySuffix') := 
functionmacro

  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.proc_xlink_validation @version@\');\n#workunit(\'priority\',\'high\');\n#OPTION(\'multiplePersistInstances\',FALSE);\n' 
               + 'LinkingTools.modXLinkValidation.macCompareBuilds(BizLinkFull,,\'cnp_name,prim_range,prim_name,sec_range,city,st,zip,company_phone,company_fein\',\'st,source\',\'@version@\');'
               ;
               
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickBuild	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'proc_xlink_validation',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::proc_xlink_validation'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickBuild;

endmacro;