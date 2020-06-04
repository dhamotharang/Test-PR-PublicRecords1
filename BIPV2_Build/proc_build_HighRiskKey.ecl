import wk_ut,tools,bipv2_build;
export proc_build_HighRiskKey(pversion = 'BIPV2.KeySuffix') := 
functionmacro
  eclsample		:= '#workunit(\'name\',\'BIPV2_Build.proc_HighRiskKey @version@\');\n#workunit(\'protect\' ,true);\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'priority\',\'high\');\n' 
               + 'BIPV2_Build.proc_HighRiskKey(\'@version@\').run;';
  cluster     := BIPV2_Build._Constants().Groupname;
  
  kickXlinkSample	  := wk_ut.mac_ChainWuids(eclsample,1,1,pversion,,cluster,pOutputEcl := false,pUniqueOutput := 'HighRiskKey',pNotifyEmails := BIPV2_Build.mod_email.emailList
  ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::high_risk_key'
  ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
  );
  
  return kickXlinkSample;
endmacro;